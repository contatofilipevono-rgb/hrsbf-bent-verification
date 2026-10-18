import H12PeriodFour
import H12BooleanPolynomial
namespace H12Quadratic
open H12BooleanPolynomial
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
set_option linter.unusedSimpArgs false
def m0 : List Nat := [1,32768,8589934592,67108865,10,130,4194306,536870914,260,4100,2097156,40,160,320,2097216,33554496,2176,134217856,131328,268435712,66048,4294967808,68719477248,17408,2147484672,73728,1056768,2147500032,137438969856,557056,1074790400,5368709120,21474836480]
def q0 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m0
def m1 : List Nat := [3,33,2049,134217729,16386,8388610,34359738370,12,516,262148,2097160,48,4194368,536870976,1099511627904,8448,262400,2199023255808,8589935104,549755814400,66560,1049600,2147485696,139264,68719493120,274877923328,98304,16809984,1572864,1107296256,38654705664,141733920768,25769803776]
def q1 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m1
def m2 : List Nat := [8,32,5,65,131073,268435457,1048578,16777218,274877906946,1028,8388612,2097168,8388672,2147483712,8320,262272,2199023255680,4398046511360,17179869696,2199023256064,33555456,67584,2147487744,270336,163840,268468224,17825792,1610612736,73014444032,279172874240,42949672960]
def q2 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m2
def m3 : List Nat := [9,129,4194305,536870913,1099511627778,2052,134217732,24,96,2097184,16777280,4294967360,16512,8388736,34359738496,1048832,16777472,274877907200,34359738880,137438953984,536871936,69632,532480,2147491840,17179885568,2199023271936,294912,1073774592,269484032,3221225472,12884901888,554050781184,77309411328]
def q3 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m3
def m4 : List Nat := [17179869184,257,2097153,33554433,34,16777218,4294967298,20,32772,8388612,262152,4194312,4112,67108928,4194432,536871040,8388864,2147483904,262656,1073742336,132096,549755814912,1050624,68719478784,20480,536879104,268451840,2129920,16842752,655360,34078720,274878955520,137472507904,4429185024,42949672960]
def q4 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m4
def m5 : List Nat := [513,1073741825,17179869185,66,8589934594,549755813890,65540,16777220,24,8388616,4194320,4128,134217792,34359738496,137438953600,68719476992,274877907200,524800,137438953984,2199023256576,133120,33556480,68719480832,24576,2147491840,2199023271936,4227072,268500992,786432,549756862464,50331648,137975824384,1103806595072,77309411328,51539607552]
def q5 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m5
def m6 : List Nat := [16,16384,524288,8589934592,1025,2147483649,137438953473,130,17179869186,2199023255554,131076,33554436,134217736,4194336,4160,268435520,68719476864,274877907072,1049088,274877907456,137438954496,536872960,135168,4294975488,68719484928,4398046527488,8421376,1073807360,17180917760,301989888,139586437120,2203318222848,85899345920]
def q6 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m6
def m7 : List Nat := [34359738368,524289,262146,1073741826,68,2097156,40,16777224,262176,2097216,65664,16777344,131328,268435712,134218240,525312,264192,2199023257600,33558528,549755817984,1056768,8404992,67141632,268566528,17039360,2148007936,4299161600,553648128,549789368320,275414777856,85899345920]
def q7 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m7
def m8 : List Nat := [65537,4294967297,68719476737,34359738370,137438953474,132,4194308,33554440,48,134217744,8388640,262208,1073741888,8589934720,549755814016,17179869440,2199023255808,1099511628288,1049600,137438955520,266240,536875008,549755822080,1064960,274877923328,134250496,1073872896,17301504,4295491584,17213423616,805306368,277025390592,141733920768,25769803776,103079215104]
def q8 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m8
def m9 : List Nat := [68719476736,257,4097,2097153,2050,134217730,67108868,136,80,33554448,16777248,134217760,32832,8388672,640,262272,1280,8388864,4194816,1050624,528384,137438957568,536879104,2199023263744,147456,33570816,2129920,4295032832,1074003968,268959744,4311744512,2415919104,17716740096,551903297536,42949672960]
def q9 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m9
def m10 : List Nat := [9,129,66,2097154,16777220,134217732,32776,67108872,34359738376,144,528,536870928,8389120,1073742848,2199023256576,268437504,8589936640,4294971392,67117056,4210688,294912,196608,2162688,4718592,269484032,1099512676352,18874368,167772160,68753031168,8724152320,2684354560,35433480192,154618822656]
def q10 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m10
def m11 : List Nat := [131072,2147483648,1025,16385,8194,1073741826,268435460,549755813892,65544,274877906952,1040,67108880,536870944,320,2176,4352,274877907456,137438954496,4398046512128,17179871232,268439552,134225920,4294975488,137438969856,557056,4259840,8912896,270532608,549789368320,671088640,69793218560,1108101562368,292057776128]
def q11 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m11
def m12 : List Nat := [65537,1048577,524290,2147483650,536870916,2199023255556,131080,1099511627784,2064,67108896,536870976,384,131200,262400,549755814400,34359740416,4294983680,68719493120,1081344,8454144,393216,17301504,34360786944,4398047559680,1075838976,2199056809984,2281701376,9663676416,6442450944,2207613190144,566935683072]
def q12 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m12
def m13 : List Nat := [1048577,4294967297,32770,2147483650,262148,2097160,268435464,134217744,274877906960,1056,34359738400,576,33554560,536871168,131584,134218752,4398046513152,17179873280,2199023259648,2105344,8589942784,81920,589824,67174400,393216,9437184,272629760,8594128896,25165824,2199056809984,550292684800,1100048498688,70866960384,309237645312,206158430208]
def q13 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m13
def m14 : List Nat := [262144,16777216,4294967298,68719476738,34359738372,4194312,536870920,1099511627792,2080,134217760,34359738432,640,17179869312,34359738624,17179869696,1099511628800,274877908992,34359742464,1073750016,2199023263744,1114112,134283264,274878955520,1077936128,34393292800,2199560126464,1101659111424,73014444032,584115552256]
def q14 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m14
def m15 : List Nat := [8193,1073741825,258,268435458,2052,67108872,536870928,268435488,1099511627808,2112,274877907008,1152,524416,16777472,1536,16896,4195328,274877911040,40960,34359746560,4398046519296,17179885568,2162688,8590000128,786432,1082130432,285212672,34896609280,554050781184,283467841536,618475290624]
def q15 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m15
def m16 : List Nat := [5,65,34,32772,136,262152,1073741832,272,549755813904,65568,16777248,32832,132096,134219776,274877908992,8392704,137438957568,1073750016,1114112,67239936,4456448,541065216,17184063488,41943040,150994944,137472507904,335544320,68853694464,2415919104,2199560126464,1133871366144]
def q16 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m16
def m17 : List Nat := [513,8193,4098,4294967300,2147483656,34359738376,4194320,2199023255568,131104,2097184,16777280,1152,32896,2304,17179870208,549755815936,1099511629824,274877911040,8396800,1073758208,134348800,8650752,1074266112,3145728,8590983168,2151677952,285212672,68753031168,274911461376,1140850688,8724152320,4563402752,4398583382016,154618822656,2233382993920]
def q17 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m17
def m18 : List Nat := [1024,268435456,16385,2147483649,536870914,260,2056,67108880,2147483664,1073741856,2199023255584,131136,549755813952,65664,1048704,33554688,1049088,4196352,549755817984,137438969856,557056,17179934720,2228224,33685504,8912896,5242880,1207959552,69256347648,139586437120,4400193994752,2203318222848,1108101562368,2267742732288]
def q18 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m18
def m19 : List Nat := [3,33,18,132,2064,4294967312,32800,67108896,34359738400,262208,4194368,2097280,33554944,3072,4198400,17179873280,139264,1099511635968,134234112,16809984,2147549184,34359803904,537001984,2359296,134742016,68157440,1075838976,8594128896,4303355904,1342177280,9126805504,277025390592,206158430208]
def q19 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m19
def m20 : List Nat := [1,16,2097152,137438953472,10,68,33554436,2056,4294967304,160,544,536870944,4160,2097408,134218240,67109888,2147484672,10240,33558528,4259840,2199023321088,268566528,537919488,549757911040,4299161600,68723671040,2214592512,1207959552,17314086912,275951648768,1108101562368]
def q20 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m20
def m21 : List Nat := [3,1026,8196,17179869188,131080,8589934600,48,1048592,2147483680,192,8256,1073742080,4608,268435968,68719477760,18432,526336,67110912,16809984,274877939712,4398046576640,4325376,33816576,268697600,34360786944,6291456,2199025352704,68727865344,2281701376,34493956096,550829555712,1100585369600,141733920768,2207613190144,412316860416]
def q21 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m21
def m22 : List Nat := [128,5,65538,524292,137438953476,4194312,17179869192,80,33554448,4294967328,16448,2147483904,262656,536871424,549755814912,16779264,67112960,147456,33587200,549755846656,274877972480,4456448,268959744,274878955520,10485760,137441050624,41943040,68736253952,68853694464,2415919104,18253611008,2200096997376,73014444032,42949672960,687194767360]
def q22 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m22
def m23 : List Nat := [8192,274877906944,257,1048578,524292,2147483652,1073741832,131088,2080,1048608,16448,33024,536871424,134219776,528384,2147487744,33570816,163840,16842752,4295032832,8519680,4398046642176,537133056,2199023517696,17825792,69206016,2149580800,1077936128,2199027449856,549764202496,2216203124736,1133871366144,687194767360]
def q23 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m23
def m24 : List Nat := [513,8589934594,137438953480,4194320,33554464,2112,16512,4294967552,34359738880,536871936,2199023256576,16781312,134221824,4294971392,24576,17179885568,17179901952,33619968,274878038016,8650752,2199023779840,549756862464,136314880,137443147776,545259520,549772591104,3221225472,138512695296,12884901888,51539607552,154618822656,1168231104512,824633720832]
def q24 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m24
def m25 : List Nat := [256,2097152,34359738368,549755813888,32769,8194,4100,268435460,134217736,4194336,131136,33554496,1048704,16777728,4294967808,33792,8389632,536872960,268439552,16785408,2147516416,1073807360,33685504,1310720,17039360,4295229440,274878169088,4398047035392,2155872256,137447342080,2199040032768,292057776128,2267742732288]
def q25 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m25
def m26 : List Nat := [129,6,36,16392,524296,528,1073741840,17179869200,33554464,8589934624,4294967360,33280,1073742848,2099200,268437504,68719480832,2147491840,196608,8590000128,274878038016,8650752,18874368,68721573888,12582912,71303168,34363932672,137443147776,50331648,2199090364416,2684354560,34896609280,154618822656,1374389534720]
def q26 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m26
def m27 : List Nat := [8388608,8589934592,137438953472,16385,514,4100,68719476744,17179869216,33554496,4294967424,2560,4294967808,17408,2147484672,2199023257600,2101248,549755817984,2147500032,17179934720,549755944960,8912896,35651584,138412032,68723671040,549789368320,137506062336,17314086912,550024249344,4831838208,275414777856,69793218560,85899345920,2473901162496]
def q27 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m27
def m28 : List Nat := [4294967297,16386,536870916,4104,134217744,137438953504,8589934720,768,33554944,8589935104,66560,8390656,2147485696,1073745920,549755822080,1064960,68719493120,68719509504,137439019008,33816576,549756076032,274878431232,6291456,37748736,25165824,137573171200,2199291691008,277025390592,38654705664,1116691496960,103079215104,206158430208,2748779069440]
def q28 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m28
def m29 : List Nat := [2,65,20,16388,520,4112,134217760,68719476768,524352,137438953536,1073741952,1280,17179869696,132096,4294969344,36864,8392704,2199023263744,268451840,549755846656,68719542272,274877972480,655360,537133056,17180131328,10485760,137441050624,17184063488,150994944,4311744512,100663296,2200096997376,551903297536,42949672960,687194767360]
def q29 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m29
def m30 : List Nat := [1,4,64,4096,32768,8388608,33554432,67108864,137438953472,1099511627776,4398113619968]
def q30 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m30
def m31 : List Nat := [3,516,72,4104,8589934600,65552,4294967312,68719476752,16416,524320,192,3072,1049600,34359740416,266240,4295000064,2147549184,537001984,2359296,538968064,17181966336,25165824,142606336,17213423616,201326592,274945015808,34493956096,137573171200,1342177280,2199291691008,9663676416,206158430208,3298534883328]
def q31 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m31
def m32 : List Nat := [1048576,2199023255552,257,16388,8200,536870920,268435472,65568,1088,524352,8320,33024,1073742336,2098176,33555456,16779264,4294969344,20480,270336,268468224,134283264,1074003968,34078720,69206016,541065216,276824064,549764202496,274894684160,275012124672,4398314946560,1133871366144,343597383680,687194767360]
def q32 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m32
def m33 : List Nat := [129,6,1048580,24,1032,8208,268435488,8589934624,1048640,68719476800,2147483776,65792,137438953984,4195328,16781312,34359746560,536887296,294912,2199023288320,549755879424,1099511693312,16908288,4295098368,537395200,136314880,274880004096,34363932672,17188257792,4328521728,603979776,402653184,4399120252928,19327352832,283467841536,2336462209024]
def q33 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m33
def m34 : List Nat := [66,258,36,4294967300,32776,2097184,65600,32896,1048832,524800,6144,133120,68719480832,532480,294912,536903680,268500992,274878038016,786432,8650752,2199023779840,269484032,136314880,12582912,1082130432,17188257792,1099528404992,167772160,4328521728,618475290624,824633720832]
def q34 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m34
def m35 : List Nat := [130,514,8589934596,40,65544,1073741856,8589934656,4294967424,8589934848,68719477248,10240,4196352,8589938688,1056768,2199023321088,1099511758848,537919488,1099513724928,138412032,8623489024,671088640,1099780063232,275951648768,21474836480,558345748480,85899345920,2473901162496]
def q35 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m35
def m36 : List Nat := [32770,132,1073741828,72,2097160,32800,576,384,8448,4608,34816,4198400,139264,16809984,8454144,1073872896,1099511889920,1572864,17301504,4295491584,274878431232,6291456,25165824,142606336,68727865344,570425344,17213423616,805306368,2199291691008,566935683072,2748779069440]
def q36 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m36
def m37 : List Nat := [34359738368,130,68,260,4294967304,544,320,525312,17179871232,2101248,33558528,73728,49152,327680,268566528,549755944960,17039360,134479872,68719738880,2148007936,137439477760,1074790400,35651584,20971520,138412032,75497472,1090519040,17196646400,550024249344,69256347648,2473901162496]
def q37 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m37
def m38 : List Nat := [16386,8196,65552,1056,384,768,4294968320,68719477760,34816,137438955520,1073745920,33562624,8589942784,4294983680,34359803904,268697600,549756076032,17301504,68720001024,538968064,272629760,1099515822080,274886295552,1107296256,201326592,17448304640,9126805504,566935683072,309237645312,412316860416,4672924418048]
def q38 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m38
def m39 : List Nat := [4194304,134217728,4294967298,2147483652,2097168,1088,640,8704,5120,67584,36864,137438957568,17179877376,33587200,8519680,137439084544,17180131328,2199023517696,4296015872,68720525312,276824064,68736253952,274894684160,2181038080,137472507904,137707388928,1610612736,42949672960,2216203124736,343597383680,4947802324992]
def q39 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m39
def m40 : List Nat := [2,128,512,262144,16777216,4294967296,17179869184,68719476736,5497558138880]
def q40 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m40
def m41 : List Nat := [258,2147483656,1073741840,1048640,16512,4294967552,16896,2147484160,2099200,8589936640,69632,1052672,536903680,33619968,16908288,134348800,68719607808,786432,17180393472,8590983168,71303168,2199031644160,549772591104,1099645845504,137975824384,35433480192,19327352832,2233382993920,618475290624,2336462209024,6597069766656]
def q41 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m41
def m42 : List Nat := [67108864,1099511627776,4398046511104]
def q42 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD m42
def rm1 : List Nat := [2,128,512,262144,16777216,4294967296,17179869184,68719476736]
def r1 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD rm1
def rm2 : List Nat := [67108864,1099511627776,4398046511104]
def r2 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD rm2
def rm3 : List Nat := [1,2,4,64,128,512,4096,32768,262144,8388608,16777216,33554432,4294967296,17179869184,68719476736,137438953472]
def r3 (c : BitVec 43) : Bool := evaluate 43 c.getLsbD rm3
def values (c : BitVec 43) : List Bool := [q0 c,q1 c,q2 c,q3 c,q4 c,q5 c,q6 c,q7 c,q8 c,q9 c,q10 c,q11 c,q12 c,q13 c,q14 c,q15 c,q16 c,q17 c,q18 c,q19 c,q20 c,q21 c,q22 c,q23 c,q24 c,q25 c,q26 c,q27 c,q28 c,q29 c,q30 c,q31 c,q32 c,q33 c,q34 c,q35 c,q36 c,q37 c,q38 c,q39 c,q40 c,q41 c,q42 c]
def Passes (c : BitVec 43) : Prop := ∀ i : Fin 43, (values c)[i.val]! = false
def f_r1_0 : List Nat := (m1.map (fun m => m ||| 2^7))
def f_r1_1 : List Nat := (m3.map (fun m => m ||| 2^1))
def f_r1_2 : List Nat := (m5.map (fun m => m ||| 2^32))
def f_r1_3 : List Nat := (m8.map (fun m => m ||| 2^9))
def f_r1_4 : List Nat := (m10.map (fun m => m ||| 2^5))
def f_r1_5 : List Nat := (m12.map (fun m => m ||| 2^13))
def f_r1_6 : List Nat := (m13.map (fun m => m ||| 2^30))
def f_r1_7 : List Nat := (m15.map (fun m => m ||| 2^20))
def f_r1_8 : List Nat := (m17.map (fun m => m ||| 2^16))
def f_r1_9 : List Nat := (m19.map (fun m => m ||| 2^3))
def f_r1_10 : List Nat := (m21.map (fun m => m ||| 2^29))
def f_r1_11 : List Nat := (m24.map (fun m => m ||| 2^36))
def f_r1_12 : List Nat := (m26.map (fun m => m ||| 2^27))
def f_r1_13 : List Nat := (m28.map (fun m => m ||| 2^34))
def f_r1_14 : List Nat := (m31.map (fun m => m ||| 2^22))
def f_r1_15 : List Nat := (m33.map (fun m => m ||| 2^11))
def f_r1_16 : List Nat := (m34.map (fun m => m ||| 2^24))
def f_r1_17 : List Nat := (m36.map (fun m => m ||| 2^18))
def f_r1_18 : List Nat := (m38.map (fun m => m ||| 2^41))
def f_r1_19 : List Nat := m40
def f_r1_20 : List Nat := (m40.map (fun m => m ||| 2^40))
def f_r1_21 : List Nat := (m41.map (fun m => m ||| 2^38))
def factors_r1 : List (List Nat) := [f_r1_0,f_r1_1,f_r1_2,f_r1_3,f_r1_4,f_r1_5,f_r1_6,f_r1_7,f_r1_8,f_r1_9,f_r1_10,f_r1_11,f_r1_12,f_r1_13,f_r1_14,f_r1_15,f_r1_16,f_r1_17,f_r1_18,f_r1_19,f_r1_20,f_r1_21]
def expanded_r1 : List Nat := factors_r1.flatten
def target_r1 : List Nat := rm1 ++ paired [11,26,41,98,131,140,161,176,560,644,2054,2072,2177,3080,8576,10256,16514,32808,66049,66688,67840,69634,73729,98432,139272,139392,196640,262216,262276,262528,262720,266752,270592,294914,294944,296960,401408,532482,1048834,1049728,1050112,1050628,1050688,1056769,1065472,1089536,1572992,1835008,2097186,2097288,2162720,2359304,3211264,4194307,4194376,4194496,4194820,4197376,4198408,4210720,4259856,4460544,4718624,5243904,6553600,8388738,8389152,8462336,8716288,16777252,16777282,16777474,16783360,16809992,16810112,16842816,16910336,17072128,17302016,17309696,17563648,17826048,18874400,25427968,29360128,33554952,67108904,67117088,68157448,134217734,134217764,134217857,134218256,134234120,134251008,134414336,134742024,136316928,142868480,146800640,153092096,167772192,184549376,205520896,268437536,269484034,269484064,285278208,286261248,402655232,536870915,536870960,536871104,536871938,536875520,536879108,536879168,536889344,537001992,537397248,537919504,541196288,543162368,553680896,570687488,603981824,805306880,805568512,1073742400,1073742880,1073774594,1073823744,1073873408,1074003972,1074135040,1074331648,1074790401,1075838984,1075847168,1083179008,1098907648,1107296384,1140916224,1207959568,1207960576,1342177288,1346371584,1610612992,2147485824,2147491842,2147549192,2151743488,2281709568,2684354592,2818572288,3221225474,4294967320,4294967362,4294967809,4294971424,4294991872,4295032836,4295100416,4295492096,4295753728,4299161616,4299194368,4303355912,4311744516,4328523776,4345298944,4429185088,4563468288,5368709121,6442459136,8589935232,8589936672,8591048704,8594128904,8724152352,8724217856,9126805512,9663684608,9667870720,12884901890,17179869952,17179873288,17179885570,17179935744,17180934144,17186160640,17188259840,17205035008,17213424128,17213685760,17217617920,17314086928,17716740100,18253615104,19327354880,21474836481,25769803904,25769804288,34359738408,34359738498,34359738882,34359748608,34359803912,34360795136,34363934720,34498150400,34897657856,35030827008,35433480224,38654705792,55834574848,68719477249,68719478848,68719493248,68719501312,68723671056,68728127488,68736258048,68753031200,68753096704,68853698560,68855791616,69256348672,69264736256,71940702208,73014444288,73014448128,77309411330,81604378624,85899362304,85899378688,103079215616,120259084288,137438953986,137438956032,137577365504,141733920896,141733921280,142270791680,154618822688,154618888192,154753040384,206158430216,206162624512,207232172032,223338299392,274877907202,274877923456,274877923840,274877976576,274878693376,274878955584,274878959616,274880006144,274894815232,274911526912,274949210112,275012255744,275414810624,275951648784,277025390600,277025391104,279172874496,283467843584,283468890112,292058300416,294205259776,310311387136,343597514752,412853731328,549755814528,549755822592,549755881472,551366426624,554050781186,554051829760,566935691264,566935945216,618476339200,618492067840,824650498048,893353197568,1099511627778,1099511627904,1099511628288,1099511635976,1099511695360,1099511889920,1099512676384,1099528404992,1101122240512,1103806595072,1116691496960,1168231104512,1374523752448,2199023255936,2199023256320,2199023256608,2199023263748,2199023271938,2199023290368,2199023321104,2199040557056,2199056818176,2199224582144,2199291953152,2199295885312,2199562223616,2200097001472,2200130551808,2203318223872,2203318239232,2207613198336,2208150061056,2216471560192,2233383059456,2267742733312,2267743256576,2336462211072,2473909551104,2508260900864,2611340115968,2748779331584,2765958938624,3298539077632,4398047567872,4398583447552,4399120254976,5497558138880,6871947673600]
theorem sorted_r1 : H12Descent.sortFuel 10 expanded_r1 = H12Descent.sortFuel 10 target_r1 := by decide +kernel
theorem identity_r1 (c : BitVec 43) : evaluate 43 c.getLsbD expanded_r1 = evaluate 43 c.getLsbD (rm1) := by
  have h := evaluate_permutation 43 c.getLsbD (permutation_of_sorted expanded_r1 target_r1 10 sorted_r1)
  simpa only [target_r1, evaluate_append, evaluate_paired, Bool.xor_false] using h
theorem necessary_r1 (c : BitVec 43) (h : Passes c) : r1 c = false := by
  have hq1 : q1 c = false := by have hh := h ⟨1, by decide⟩; exact hh
  have hq3 : q3 c = false := by have hh := h ⟨3, by decide⟩; exact hh
  have hq5 : q5 c = false := by have hh := h ⟨5, by decide⟩; exact hh
  have hq8 : q8 c = false := by have hh := h ⟨8, by decide⟩; exact hh
  have hq10 : q10 c = false := by have hh := h ⟨10, by decide⟩; exact hh
  have hq12 : q12 c = false := by have hh := h ⟨12, by decide⟩; exact hh
  have hq13 : q13 c = false := by have hh := h ⟨13, by decide⟩; exact hh
  have hq15 : q15 c = false := by have hh := h ⟨15, by decide⟩; exact hh
  have hq17 : q17 c = false := by have hh := h ⟨17, by decide⟩; exact hh
  have hq19 : q19 c = false := by have hh := h ⟨19, by decide⟩; exact hh
  have hq21 : q21 c = false := by have hh := h ⟨21, by decide⟩; exact hh
  have hq24 : q24 c = false := by have hh := h ⟨24, by decide⟩; exact hh
  have hq26 : q26 c = false := by have hh := h ⟨26, by decide⟩; exact hh
  have hq28 : q28 c = false := by have hh := h ⟨28, by decide⟩; exact hh
  have hq31 : q31 c = false := by have hh := h ⟨31, by decide⟩; exact hh
  have hq33 : q33 c = false := by have hh := h ⟨33, by decide⟩; exact hh
  have hq34 : q34 c = false := by have hh := h ⟨34, by decide⟩; exact hh
  have hq36 : q36 c = false := by have hh := h ⟨36, by decide⟩; exact hh
  have hq38 : q38 c = false := by have hh := h ⟨38, by decide⟩; exact hh
  have hq40 : q40 c = false := by have hh := h ⟨40, by decide⟩; exact hh
  have hq41 : q41 c = false := by have hh := h ⟨41, by decide⟩; exact hh
  have hf0 : evaluate 43 c.getLsbD f_r1_0 = false := by
    unfold f_r1_0
    rw [evaluate_multiply_variable 43 c.getLsbD m1 7 (by decide)]
    change (q1 c && c.getLsbD 7) = false
    rw [hq1]; rfl
  have hf1 : evaluate 43 c.getLsbD f_r1_1 = false := by
    unfold f_r1_1
    rw [evaluate_multiply_variable 43 c.getLsbD m3 1 (by decide)]
    change (q3 c && c.getLsbD 1) = false
    rw [hq3]; rfl
  have hf2 : evaluate 43 c.getLsbD f_r1_2 = false := by
    unfold f_r1_2
    rw [evaluate_multiply_variable 43 c.getLsbD m5 32 (by decide)]
    change (q5 c && c.getLsbD 32) = false
    rw [hq5]; rfl
  have hf3 : evaluate 43 c.getLsbD f_r1_3 = false := by
    unfold f_r1_3
    rw [evaluate_multiply_variable 43 c.getLsbD m8 9 (by decide)]
    change (q8 c && c.getLsbD 9) = false
    rw [hq8]; rfl
  have hf4 : evaluate 43 c.getLsbD f_r1_4 = false := by
    unfold f_r1_4
    rw [evaluate_multiply_variable 43 c.getLsbD m10 5 (by decide)]
    change (q10 c && c.getLsbD 5) = false
    rw [hq10]; rfl
  have hf5 : evaluate 43 c.getLsbD f_r1_5 = false := by
    unfold f_r1_5
    rw [evaluate_multiply_variable 43 c.getLsbD m12 13 (by decide)]
    change (q12 c && c.getLsbD 13) = false
    rw [hq12]; rfl
  have hf6 : evaluate 43 c.getLsbD f_r1_6 = false := by
    unfold f_r1_6
    rw [evaluate_multiply_variable 43 c.getLsbD m13 30 (by decide)]
    change (q13 c && c.getLsbD 30) = false
    rw [hq13]; rfl
  have hf7 : evaluate 43 c.getLsbD f_r1_7 = false := by
    unfold f_r1_7
    rw [evaluate_multiply_variable 43 c.getLsbD m15 20 (by decide)]
    change (q15 c && c.getLsbD 20) = false
    rw [hq15]; rfl
  have hf8 : evaluate 43 c.getLsbD f_r1_8 = false := by
    unfold f_r1_8
    rw [evaluate_multiply_variable 43 c.getLsbD m17 16 (by decide)]
    change (q17 c && c.getLsbD 16) = false
    rw [hq17]; rfl
  have hf9 : evaluate 43 c.getLsbD f_r1_9 = false := by
    unfold f_r1_9
    rw [evaluate_multiply_variable 43 c.getLsbD m19 3 (by decide)]
    change (q19 c && c.getLsbD 3) = false
    rw [hq19]; rfl
  have hf10 : evaluate 43 c.getLsbD f_r1_10 = false := by
    unfold f_r1_10
    rw [evaluate_multiply_variable 43 c.getLsbD m21 29 (by decide)]
    change (q21 c && c.getLsbD 29) = false
    rw [hq21]; rfl
  have hf11 : evaluate 43 c.getLsbD f_r1_11 = false := by
    unfold f_r1_11
    rw [evaluate_multiply_variable 43 c.getLsbD m24 36 (by decide)]
    change (q24 c && c.getLsbD 36) = false
    rw [hq24]; rfl
  have hf12 : evaluate 43 c.getLsbD f_r1_12 = false := by
    unfold f_r1_12
    rw [evaluate_multiply_variable 43 c.getLsbD m26 27 (by decide)]
    change (q26 c && c.getLsbD 27) = false
    rw [hq26]; rfl
  have hf13 : evaluate 43 c.getLsbD f_r1_13 = false := by
    unfold f_r1_13
    rw [evaluate_multiply_variable 43 c.getLsbD m28 34 (by decide)]
    change (q28 c && c.getLsbD 34) = false
    rw [hq28]; rfl
  have hf14 : evaluate 43 c.getLsbD f_r1_14 = false := by
    unfold f_r1_14
    rw [evaluate_multiply_variable 43 c.getLsbD m31 22 (by decide)]
    change (q31 c && c.getLsbD 22) = false
    rw [hq31]; rfl
  have hf15 : evaluate 43 c.getLsbD f_r1_15 = false := by
    unfold f_r1_15
    rw [evaluate_multiply_variable 43 c.getLsbD m33 11 (by decide)]
    change (q33 c && c.getLsbD 11) = false
    rw [hq33]; rfl
  have hf16 : evaluate 43 c.getLsbD f_r1_16 = false := by
    unfold f_r1_16
    rw [evaluate_multiply_variable 43 c.getLsbD m34 24 (by decide)]
    change (q34 c && c.getLsbD 24) = false
    rw [hq34]; rfl
  have hf17 : evaluate 43 c.getLsbD f_r1_17 = false := by
    unfold f_r1_17
    rw [evaluate_multiply_variable 43 c.getLsbD m36 18 (by decide)]
    change (q36 c && c.getLsbD 18) = false
    rw [hq36]; rfl
  have hf18 : evaluate 43 c.getLsbD f_r1_18 = false := by
    unfold f_r1_18
    rw [evaluate_multiply_variable 43 c.getLsbD m38 41 (by decide)]
    change (q38 c && c.getLsbD 41) = false
    rw [hq38]; rfl
  have hf19 : evaluate 43 c.getLsbD f_r1_19 = false := by
    exact hq40
  have hf20 : evaluate 43 c.getLsbD f_r1_20 = false := by
    unfold f_r1_20
    rw [evaluate_multiply_variable 43 c.getLsbD m40 40 (by decide)]
    change (q40 c && c.getLsbD 40) = false
    rw [hq40]; rfl
  have hf21 : evaluate 43 c.getLsbD f_r1_21 = false := by
    unfold f_r1_21
    rw [evaluate_multiply_variable 43 c.getLsbD m41 38 (by decide)]
    change (q41 c && c.getLsbD 38) = false
    rw [hq41]; rfl
  have hz : evaluate 43 c.getLsbD expanded_r1 = false := by
    unfold expanded_r1 factors_r1
    rw [evaluate_flatten]
    simp only [List.foldr_cons, List.foldr_nil, hf0, hf1, hf2, hf3, hf4, hf5, hf6, hf7, hf8, hf9, hf10, hf11, hf12, hf13, hf14, hf15, hf16, hf17, hf18, hf19, hf20, hf21, Bool.false_xor]
  rw [identity_r1] at hz
  exact hz
#print axioms necessary_r1
def f_r2_0 : List Nat := m42
def factors_r2 : List (List Nat) := [f_r2_0]
def expanded_r2 : List Nat := factors_r2.flatten
def target_r2 : List Nat := rm2 ++ paired []
theorem sorted_r2 : H12Descent.sortFuel 2 expanded_r2 = H12Descent.sortFuel 2 target_r2 := by decide +kernel
theorem identity_r2 (c : BitVec 43) : evaluate 43 c.getLsbD expanded_r2 = evaluate 43 c.getLsbD (rm2) := by
  have h := evaluate_permutation 43 c.getLsbD (permutation_of_sorted expanded_r2 target_r2 2 sorted_r2)
  simpa only [target_r2, evaluate_append, evaluate_paired, Bool.xor_false] using h
theorem necessary_r2 (c : BitVec 43) (h : Passes c) : r2 c = false := by
  have hq42 : q42 c = false := by have hh := h ⟨42, by decide⟩; exact hh
  have hf0 : evaluate 43 c.getLsbD f_r2_0 = false := by
    exact hq42
  have hz : evaluate 43 c.getLsbD expanded_r2 = false := by
    unfold expanded_r2 factors_r2
    rw [evaluate_flatten]
    simp only [List.foldr_cons, List.foldr_nil, hf0, Bool.false_xor]
  rw [identity_r2] at hz
  exact hz
#print axioms necessary_r2
def f_r3_0 : List Nat := m30
def f_r3_1 : List Nat := (m30.map (fun m => m ||| 2^26))
def f_r3_2 : List Nat := (m30.map (fun m => m ||| 2^40))
def f_r3_3 : List Nat := (m30.map (fun m => m ||| 2^42))
def f_r3_4 : List Nat := m40
def f_r3_5 : List Nat := (m40.map (fun m => m ||| 2^26))
def f_r3_6 : List Nat := (m40.map (fun m => m ||| 2^40))
def f_r3_7 : List Nat := (m40.map (fun m => m ||| 2^42))
def f_r3_8 : List Nat := (m42.map (fun m => m ||| 2^0))
def f_r3_9 : List Nat := (m42.map (fun m => m ||| 2^1))
def f_r3_10 : List Nat := (m42.map (fun m => m ||| 2^2))
def f_r3_11 : List Nat := (m42.map (fun m => m ||| 2^6))
def f_r3_12 : List Nat := (m42.map (fun m => m ||| 2^7))
def f_r3_13 : List Nat := (m42.map (fun m => m ||| 2^9))
def f_r3_14 : List Nat := (m42.map (fun m => m ||| 2^12))
def f_r3_15 : List Nat := (m42.map (fun m => m ||| 2^15))
def f_r3_16 : List Nat := (m42.map (fun m => m ||| 2^18))
def f_r3_17 : List Nat := (m42.map (fun m => m ||| 2^23))
def f_r3_18 : List Nat := (m42.map (fun m => m ||| 2^24))
def f_r3_19 : List Nat := (m42.map (fun m => m ||| 2^25))
def f_r3_20 : List Nat := (m42.map (fun m => m ||| 2^32))
def f_r3_21 : List Nat := (m42.map (fun m => m ||| 2^34))
def f_r3_22 : List Nat := (m42.map (fun m => m ||| 2^36))
def f_r3_23 : List Nat := (m42.map (fun m => m ||| 2^37))
def factors_r3 : List (List Nat) := [f_r3_0,f_r3_1,f_r3_2,f_r3_3,f_r3_4,f_r3_5,f_r3_6,f_r3_7,f_r3_8,f_r3_9,f_r3_10,f_r3_11,f_r3_12,f_r3_13,f_r3_14,f_r3_15,f_r3_16,f_r3_17,f_r3_18,f_r3_19,f_r3_20,f_r3_21,f_r3_22,f_r3_23]
def expanded_r3 : List Nat := factors_r3.flatten
def target_r3 : List Nat := rm3 ++ paired [67108864,67108865,67108866,67108868,67108928,67108992,67109376,67112960,67141632,67371008,75497472,83886080,100663296,4362076160,17246978048,68786585600,137506062336,1099511627776,1099511627777,1099511627778,1099511627780,1099511627840,1099511627904,1099511628288,1099511631872,1099511660544,1099511889920,1099520016384,1099528404992,1099545182208,1099578736640,1103806595072,1116691496960,1168231104512,1236950581248,4398046511105,4398046511106,4398046511108,4398046511168,4398046511232,4398046511616,4398046515200,4398046543872,4398046773248,4398054899712,4398063288320,4398080065536,4398113619968,4398113619968,4402341478400,4415226380288,4466765987840,4535485464576,5497558138880,5497558138880,5497625247744]
theorem sorted_r3 : H12Descent.sortFuel 7 expanded_r3 = H12Descent.sortFuel 7 target_r3 := by decide +kernel
theorem identity_r3 (c : BitVec 43) : evaluate 43 c.getLsbD expanded_r3 = evaluate 43 c.getLsbD (rm3) := by
  have h := evaluate_permutation 43 c.getLsbD (permutation_of_sorted expanded_r3 target_r3 7 sorted_r3)
  simpa only [target_r3, evaluate_append, evaluate_paired, Bool.xor_false] using h
theorem necessary_r3 (c : BitVec 43) (h : Passes c) : r3 c = false := by
  have hq30 : q30 c = false := by have hh := h ⟨30, by decide⟩; exact hh
  have hq40 : q40 c = false := by have hh := h ⟨40, by decide⟩; exact hh
  have hq42 : q42 c = false := by have hh := h ⟨42, by decide⟩; exact hh
  have hf0 : evaluate 43 c.getLsbD f_r3_0 = false := by
    exact hq30
  have hf1 : evaluate 43 c.getLsbD f_r3_1 = false := by
    unfold f_r3_1
    rw [evaluate_multiply_variable 43 c.getLsbD m30 26 (by decide)]
    change (q30 c && c.getLsbD 26) = false
    rw [hq30]; rfl
  have hf2 : evaluate 43 c.getLsbD f_r3_2 = false := by
    unfold f_r3_2
    rw [evaluate_multiply_variable 43 c.getLsbD m30 40 (by decide)]
    change (q30 c && c.getLsbD 40) = false
    rw [hq30]; rfl
  have hf3 : evaluate 43 c.getLsbD f_r3_3 = false := by
    unfold f_r3_3
    rw [evaluate_multiply_variable 43 c.getLsbD m30 42 (by decide)]
    change (q30 c && c.getLsbD 42) = false
    rw [hq30]; rfl
  have hf4 : evaluate 43 c.getLsbD f_r3_4 = false := by
    exact hq40
  have hf5 : evaluate 43 c.getLsbD f_r3_5 = false := by
    unfold f_r3_5
    rw [evaluate_multiply_variable 43 c.getLsbD m40 26 (by decide)]
    change (q40 c && c.getLsbD 26) = false
    rw [hq40]; rfl
  have hf6 : evaluate 43 c.getLsbD f_r3_6 = false := by
    unfold f_r3_6
    rw [evaluate_multiply_variable 43 c.getLsbD m40 40 (by decide)]
    change (q40 c && c.getLsbD 40) = false
    rw [hq40]; rfl
  have hf7 : evaluate 43 c.getLsbD f_r3_7 = false := by
    unfold f_r3_7
    rw [evaluate_multiply_variable 43 c.getLsbD m40 42 (by decide)]
    change (q40 c && c.getLsbD 42) = false
    rw [hq40]; rfl
  have hf8 : evaluate 43 c.getLsbD f_r3_8 = false := by
    unfold f_r3_8
    rw [evaluate_multiply_variable 43 c.getLsbD m42 0 (by decide)]
    change (q42 c && c.getLsbD 0) = false
    rw [hq42]; rfl
  have hf9 : evaluate 43 c.getLsbD f_r3_9 = false := by
    unfold f_r3_9
    rw [evaluate_multiply_variable 43 c.getLsbD m42 1 (by decide)]
    change (q42 c && c.getLsbD 1) = false
    rw [hq42]; rfl
  have hf10 : evaluate 43 c.getLsbD f_r3_10 = false := by
    unfold f_r3_10
    rw [evaluate_multiply_variable 43 c.getLsbD m42 2 (by decide)]
    change (q42 c && c.getLsbD 2) = false
    rw [hq42]; rfl
  have hf11 : evaluate 43 c.getLsbD f_r3_11 = false := by
    unfold f_r3_11
    rw [evaluate_multiply_variable 43 c.getLsbD m42 6 (by decide)]
    change (q42 c && c.getLsbD 6) = false
    rw [hq42]; rfl
  have hf12 : evaluate 43 c.getLsbD f_r3_12 = false := by
    unfold f_r3_12
    rw [evaluate_multiply_variable 43 c.getLsbD m42 7 (by decide)]
    change (q42 c && c.getLsbD 7) = false
    rw [hq42]; rfl
  have hf13 : evaluate 43 c.getLsbD f_r3_13 = false := by
    unfold f_r3_13
    rw [evaluate_multiply_variable 43 c.getLsbD m42 9 (by decide)]
    change (q42 c && c.getLsbD 9) = false
    rw [hq42]; rfl
  have hf14 : evaluate 43 c.getLsbD f_r3_14 = false := by
    unfold f_r3_14
    rw [evaluate_multiply_variable 43 c.getLsbD m42 12 (by decide)]
    change (q42 c && c.getLsbD 12) = false
    rw [hq42]; rfl
  have hf15 : evaluate 43 c.getLsbD f_r3_15 = false := by
    unfold f_r3_15
    rw [evaluate_multiply_variable 43 c.getLsbD m42 15 (by decide)]
    change (q42 c && c.getLsbD 15) = false
    rw [hq42]; rfl
  have hf16 : evaluate 43 c.getLsbD f_r3_16 = false := by
    unfold f_r3_16
    rw [evaluate_multiply_variable 43 c.getLsbD m42 18 (by decide)]
    change (q42 c && c.getLsbD 18) = false
    rw [hq42]; rfl
  have hf17 : evaluate 43 c.getLsbD f_r3_17 = false := by
    unfold f_r3_17
    rw [evaluate_multiply_variable 43 c.getLsbD m42 23 (by decide)]
    change (q42 c && c.getLsbD 23) = false
    rw [hq42]; rfl
  have hf18 : evaluate 43 c.getLsbD f_r3_18 = false := by
    unfold f_r3_18
    rw [evaluate_multiply_variable 43 c.getLsbD m42 24 (by decide)]
    change (q42 c && c.getLsbD 24) = false
    rw [hq42]; rfl
  have hf19 : evaluate 43 c.getLsbD f_r3_19 = false := by
    unfold f_r3_19
    rw [evaluate_multiply_variable 43 c.getLsbD m42 25 (by decide)]
    change (q42 c && c.getLsbD 25) = false
    rw [hq42]; rfl
  have hf20 : evaluate 43 c.getLsbD f_r3_20 = false := by
    unfold f_r3_20
    rw [evaluate_multiply_variable 43 c.getLsbD m42 32 (by decide)]
    change (q42 c && c.getLsbD 32) = false
    rw [hq42]; rfl
  have hf21 : evaluate 43 c.getLsbD f_r3_21 = false := by
    unfold f_r3_21
    rw [evaluate_multiply_variable 43 c.getLsbD m42 34 (by decide)]
    change (q42 c && c.getLsbD 34) = false
    rw [hq42]; rfl
  have hf22 : evaluate 43 c.getLsbD f_r3_22 = false := by
    unfold f_r3_22
    rw [evaluate_multiply_variable 43 c.getLsbD m42 36 (by decide)]
    change (q42 c && c.getLsbD 36) = false
    rw [hq42]; rfl
  have hf23 : evaluate 43 c.getLsbD f_r3_23 = false := by
    unfold f_r3_23
    rw [evaluate_multiply_variable 43 c.getLsbD m42 37 (by decide)]
    change (q42 c && c.getLsbD 37) = false
    rw [hq42]; rfl
  have hz : evaluate 43 c.getLsbD expanded_r3 = false := by
    unfold expanded_r3 factors_r3
    rw [evaluate_flatten]
    simp only [List.foldr_cons, List.foldr_nil, hf0, hf1, hf2, hf3, hf4, hf5, hf6, hf7, hf8, hf9, hf10, hf11, hf12, hf13, hf14, hf15, hf16, hf17, hf18, hf19, hf20, hf21, hf22, hf23, Bool.false_xor]
  rw [identity_r3] at hz
  exact hz
#print axioms necessary_r3
def rm2_times42 : List Nat := rm2.map (fun m => m ||| 2^42)
def factors_short : List (List Nat) := [m30,rm1,rm3,rm2,rm2_times42]
def expanded_short : List Nat := factors_short.flatten
def target_short : List Nat := [5497558138880] ++ paired [1,2,4,64,128,512,4096,32768,262144,8388608,16777216,33554432,67108864,4294967296,17179869184,68719476736,137438953472,1099511627776,4398046511104,4398113619968]
theorem sorted_short : H12Descent.sortFuel 6 expanded_short = H12Descent.sortFuel 6 target_short := by decide +kernel
theorem identity_short (c : BitVec 43) : evaluate 43 c.getLsbD expanded_short = evaluate 43 c.getLsbD ([5497558138880]) := by
  have h := evaluate_permutation 43 c.getLsbD (permutation_of_sorted expanded_short target_short 6 sorted_short)
  simpa only [target_short, evaluate_append, evaluate_paired, Bool.xor_false] using h
theorem short_product_zero (c : BitVec 43) (h : Passes c) :
    (c.getLsbD 40 && c.getLsbD 42) = false := by
  have hq : q30 c = false := by have hh := h ⟨30, by decide⟩; exact hh
  have h1 := necessary_r1 c h
  have h2 := necessary_r2 c h
  have h3 := necessary_r3 c h
  have hm : evaluate 43 c.getLsbD rm2_times42 = false := by
    unfold rm2_times42
    rw [evaluate_multiply_variable 43 c.getLsbD rm2 42 (by decide)]
    change (r2 c && c.getLsbD 42) = false
    rw [h2]; rfl
  have hz : evaluate 43 c.getLsbD expanded_short = false := by
    unfold expanded_short factors_short
    rw [evaluate_flatten]
    change (q30 c ^^ (r1 c ^^ (r3 c ^^ (r2 c ^^ (evaluate 43 c.getLsbD rm2_times42 ^^ false))))) = false
    simp only [hq, h1, h2, h3, hm, Bool.false_xor]
  rw [identity_short] at hz
  have he : evaluate 43 c.getLsbD [5497558138880] = (c.getLsbD 40 && c.getLsbD 42) := by
    rw [evaluate_cons, evaluate_nil, Bool.xor_false]
    change monomial 43 c.getLsbD ((2^40) ||| (2^42)) = _
    rw [monomial_union, monomial_unit 43 c.getLsbD 40 (by decide),
      monomial_unit 43 c.getLsbD 42 (by decide)]
  rw [he] at hz
  exact hz
#print axioms short_product_zero
end H12Quadratic
