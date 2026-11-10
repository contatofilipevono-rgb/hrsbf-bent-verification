using System;
using System.IO;

class CountNearAntipodal
{
    static int Parity(ulong x)
    {
        x ^= x >> 32;
        x ^= x >> 16;
        x ^= x >> 8;
        x ^= x >> 4;
        return (0x6996 >> (int)(x & 15)) & 1;
    }

    static unsafe bool PlaneFibres(byte* map, int* counts, int* sums, byte* fibres)
    {
        for (int i = 0; i < 32; i++)
        {
            counts[i] = 0;
            sums[i] = 0;
        }
        for (int x = 0; x < 128; x++)
        {
            int label = map[x];
            int index = counts[label]++;
            if (index >= 4) return false;
            fibres[4 * label + index] = (byte)x;
            sums[label] ^= x;
        }
        // No fibre has more than four points and the sizes sum to 128.
        for (int label = 0; label < 32; label++)
            if (sums[label] != 0) return false;
        return true;
    }

    static unsafe int PhaseDimension(ulong* phase, byte* fibres, ulong[,] kernel, int* pivots)
    {
        int variables = kernel.GetLength(0);
        int rhs = 1 << variables;
        int rank = 0;
        for (int i = 0; i < variables; i++) pivots[i] = 0;
        for (int label = 0; label < 32; label++)
        {
            ulong low = 0;
            ulong high = 0;
            for (int j = 0; j < 4; j++)
            {
                int x = fibres[4 * label + j];
                if (x < 64) low |= 1UL << x;
                else high |= 1UL << (x - 64);
            }
            int row = (1 ^ Parity((phase[0] & low) ^ (phase[1] & high))) << variables;
            for (int j = 0; j < variables; j++)
                row |= Parity((kernel[j, 0] & low) ^ (kernel[j, 1] & high)) << j;
            for (int bit = 0; bit < variables; bit++)
            {
                if ((row & (1 << bit)) == 0) continue;
                if (pivots[bit] == 0)
                {
                    pivots[bit] = row;
                    rank++;
                    row = 0;
                    break;
                }
                row ^= pivots[bit];
            }
            if (row == rhs) return -1;
        }
        return variables - rank;
    }

    static unsafe void WriteWitness(ulong* table, ulong[,] kernel, int* pivots, TextWriter output)
    {
        int variables = kernel.GetLength(0);
        int solution = 0;
        for (int i = variables - 1; i >= 0; i--)
        {
            if (pivots[i] == 0) continue;
            int bit = ((pivots[i] >> variables) & 1) ^ Parity((ulong)(pivots[i] & solution));
            solution |= bit << i;
        }
        var bytes = new byte[144];
        byte* map = (byte*)table;
        for (int i = 0; i < 128; i++) bytes[i] = map[i];
        for (int j = 0; j < 2; j++)
        {
            ulong h = table[16 + j];
            for (int i = 0; i < variables; i++)
                if ((solution & (1 << i)) != 0) h ^= kernel[i, j];
            Array.Copy(BitConverter.GetBytes(h), 0, bytes, 128 + 8 * j, 8);
        }
        output.WriteLine(Convert.ToBase64String(bytes));
    }

    public static unsafe void Main(string[] args)
    {
        var stats = new long[8, 20];
        var weights = new int[8];
        int* counts = stackalloc int[32];
        int* sums = stackalloc int[32];
        byte* fibres = stackalloc byte[128];
        int witnessCount = 0;
        using (var planes = args.Length > 2 ? new BinaryWriter(File.Create(args[2])) : null)
        using (var witnesses = new StreamWriter(args[1]))
        using (var reader = new BinaryReader(File.OpenRead(args[0])))
        {
            int branches = reader.ReadInt32();
            int n = reader.ReadInt32();
            int* pivots = stackalloc int[n];
            var kernel = new ulong[n, 2];
            for (int i = 0; i < n; i++)
                for (int j = 0; j < 2; j++) kernel[i, j] = reader.ReadUInt64();
            for (int b = 0; b < branches; b++)
            {
                int id = reader.ReadInt32();
                weights[id] = reader.ReadInt32();
                int d = reader.ReadInt32();
                var vectors = new ulong[18 * (d + 1)];
                for (int j = 0; j < vectors.Length; j++) vectors[j] = reader.ReadUInt64();
                fixed (ulong* p = vectors)
                {
                    stats[id, 0] += 1L << d;
                    for (int word = 0; word < (1 << d); word++)
                    {
                        if (word != 0)
                        {
                            int bit = 1;
                            int value = word;
                            while ((value & 1) == 0) { bit++; value >>= 1; }
                            ulong* change = p + 18 * bit;
                            for (int j = 0; j < 18; j++) p[j] ^= change[j];
                        }
                        if (!PlaneFibres((byte*)p, counts, sums, fibres)) continue;
                        stats[id, 1]++;
                        if (planes != null)
                            for (int j = 0; j < 18; j++) planes.Write(p[j]);
                        int dim = PhaseDimension(p + 16, fibres, kernel, pivots);
                        if (dim < 0) continue;
                        stats[id, 2]++;
                        stats[id, 3] += 1L << dim;
                        stats[id, 4 + dim]++;
                        if (witnessCount < 8)
                        {
                            WriteWitness(p, kernel, pivots, witnesses);
                            witnessCount++;
                        }
                    }
                }
            }
            if (reader.BaseStream.Position != reader.BaseStream.Length) throw new Exception("Unread data");
        }
        Console.WriteLine("id weight trials plane_partitions maps functions dimensions");
        for (int id = 0; id < 8 && weights[id] != 0; id++)
        {
            Console.Write("{0} {1}", id, weights[id]);
            for (int j = 0; j < 4; j++) Console.Write(" {0}", stats[id, j]);
            for (int d = 0; d <= 15; d++)
                if (stats[id, 4 + d] != 0) Console.Write(" {0}:{1}", d, stats[id, 4 + d]);
            Console.WriteLine();
        }
    }
}
