;
; A very ROUGH disassembly of Family BASIC v2.1A
;
; Bytes:
; - instruction: 31425
; - data       : 1343
; Labels:
; - named    : 2190
; - anonymous: 752
; Bytes in CDL file:
; - instruction  : 0
; - data         : 0
; - unaccessed   : 32768

; --- Macros ------------------------------------------------------------------

; force 16-bit addressing (absolute/absolute,x/absolute,y) with
; operands <= $ff
macro ora_abs _zp
                db $0d, _zp, $00
endm
macro asl_abs _zp
                db $0e, _zp, $00
endm
macro asl_absx _zp
                db $1e, _zp, $00
endm
macro bit_abs _zp
                db $2c, _zp, $00
endm
macro and_abs _zp
                db $2d, _zp, $00
endm
macro and_absx _zp
                db $3d, _zp, $00
endm
macro rol_absx _zp
                db $3e, _zp, $00
endm
macro lsr_abs _zp
                db $4e, _zp, $00
endm
macro lsr_absx _zp
                db $5e, _zp, $00
endm
macro sty_abs _zp
                db $8c, _zp, $00
endm
macro stx_abs _zp
                db $8e, _zp, $00
endm
macro ldx_abs _zp
                db $ae, _zp, $00
endm
macro ldx_absy _zp
                db $be, _zp, $00
endm
macro inc_absx _zp
                db $fe, _zp, $00
endm

; --- Address constants at $0000-$7fff ----------------------------------------

; 'arr' = RAM array, 'ram' = RAM non-array, 'misc' = $2000-$7fff
; note: unused hardware registers commented out

arr1            equ $00
arr2            equ $01
arr3            equ $02
ram1            equ $03
ram2            equ $04
arr4            equ $05
arr5            equ $06
ram3            equ $07
arr6            equ $08
ram4            equ $09
ram5            equ $0a
ram6            equ $0b
arr7            equ $0c
arr8            equ $0d
ram7            equ $0e
arr9            equ $0f
ram8            equ $10
ram9            equ $11
ram10           equ $12
ram11           equ $13
arr10           equ $14
ram12           equ $15
arr11           equ $16
ram13           equ $17
arr12           equ $18
ram14           equ $19
ram15           equ $1a
ram16           equ $1b
ram17           equ $1c
ram18           equ $1d
ram19           equ $1e
arr13           equ $1f
arr14           equ $20
arr15           equ $21
ram20           equ $22
arr16           equ $23
ram21           equ $24
arr17           equ $25
ram22           equ $26
ram23           equ $27
ram24           equ $28
ram25           equ $29
ram26           equ $2a
ram27           equ $2b
arr18           equ $2c
arr19           equ $2d
ram28           equ $2e
ram29           equ $2f
arr20           equ $30
ram30           equ $31
arr21           equ $32
ram31           equ $33
arr22           equ $34
ram32           equ $35
ram33           equ $36
arr23           equ $37
arr24           equ $38
ram34           equ $39
arr25           equ $3a
ram35           equ $3b
ram36           equ $3c
arr26           equ $3d
arr27           equ $3e
arr28           equ $3f
ram37           equ $40
ram38           equ $41
arr29           equ $42
arr30           equ $43
arr31           equ $44
arr32           equ $45
arr33           equ $46
ram39           equ $47
arr34           equ $48
arr35           equ $49
ram40           equ $4a
ram41           equ $4b
arr36           equ $4c
ram42           equ $4d
arr37           equ $4e
arr38           equ $4f
arr39           equ $50
arr40           equ $51
arr41           equ $52
arr42           equ $53
arr43           equ $54
arr44           equ $55
arr45           equ $56
ram43           equ $57
arr46           equ $58
ram44           equ $59
ram45           equ $5a
ram46           equ $5b
ram47           equ $5c
ram48           equ $5d
ram49           equ $5e
ram50           equ $5f
arr47           equ $60
ram51           equ $61
arr48           equ $62
ram52           equ $63
arr49           equ $64
ram53           equ $65
ram54           equ $66
arr50           equ $67
ram55           equ $68
ram56           equ $69
arr51           equ $6a
ram57           equ $6b
ram58           equ $6c
ram59           equ $6d
ram60           equ $6e
arr52           equ $6f
arr53           equ $70
arr54           equ $71
arr55           equ $72
arr56           equ $73
arr57           equ $74
ram61           equ $75
arr58           equ $76
arr59           equ $77
arr60           equ $78
arr61           equ $79
ram62           equ $7a
ram63           equ $7b
ram64           equ $7c
ram65           equ $7d
ram66           equ $7e
ram67           equ $7f
arr62           equ $80
ram68           equ $81
ram69           equ $82
arr63           equ $83
ram70           equ $84
ram71           equ $85
ram72           equ $86
ram73           equ $87
ram74           equ $88
ram75           equ $89
ram76           equ $8a
ram77           equ $8b
arr64           equ $8c
arr65           equ $8d
arr66           equ $8e
ram78           equ $8f
ram79           equ $90
ram80           equ $91
ram81           equ $92
arr67           equ $93
arr68           equ $94
arr69           equ $95
ram82           equ $96
arr70           equ $97
ram83           equ $98
ram84           equ $99
ram85           equ $9a
ram86           equ $9b
ram87           equ $9c
ram88           equ $9d
ram89           equ $9e
arr71           equ $9f
arr72           equ $a0
ram90           equ $a1
ram91           equ $a2
ram92           equ $a3
ram93           equ $a4
ram94           equ $a5
ram95           equ $a6
ram96           equ $a7
arr73           equ $a8
ram97           equ $a9
arr74           equ $aa
arr75           equ $ab
ram98           equ $ac
arr76           equ $ad
ram99           equ $ae
ram100          equ $af
arr77           equ $b0
ram101          equ $b1
ram102          equ $b2
ram103          equ $b3
ram104          equ $b4
ram105          equ $b5
ram106          equ $b6
ram107          equ $b7
ram108          equ $b8
arr78           equ $b9
ram109          equ $ba
ram110          equ $bb
arr79           equ $bc
arr80           equ $bd
ram111          equ $be
arr81           equ $bf
ram112          equ $c0
ram113          equ $c1
ram114          equ $c2
arr82           equ $c3
ram115          equ $c4
arr83           equ $c5
arr84           equ $c6
ram116          equ $c7
ram117          equ $c8
ram118          equ $c9
arr85           equ $ca
arr86           equ $cb
ram119          equ $cc
ram120          equ $cd
arr87           equ $ce
arr88           equ $cf
arr89           equ $d0
ram121          equ $d1
arr90           equ $d2
ram122          equ $d3
arr91           equ $d4
arr92           equ $d5
ram123          equ $d6
arr93           equ $d7
ram124          equ $d8
ram125          equ $d9
arr94           equ $da
ram126          equ $db
arr95           equ $dc
arr96           equ $dd
arr97           equ $de
ram127          equ $df
ram128          equ $e0
ram129          equ $e1
ram130          equ $e6
ram131          equ $e9
ram132          equ $ea
arr98           equ $ed
arr99           equ $ee
ram133          equ $ef
ram134          equ $f0
arr100          equ $f1
ram135          equ $f2
ram136          equ $f3
arr101          equ $f4
arr102          equ $f5
ram137          equ $f6
ram138          equ $f7
ram139          equ $f8
ram140          equ $f9
ram141          equ $fa
arr103          equ $fb
arr104          equ $fc
ram142          equ $fd
ram143          equ $fe
arr105          equ $ff
ram144          equ $0100
ram145          equ $0162
ram146          equ $017d
ram147          equ $01a9
arr106          equ $01c5
ram148          equ $01fb
ram149          equ $01ff
arr107          equ $0200
arr108          equ $0201
arr109          equ $0202
arr110          equ $0203
ram150          equ $0205
ram151          equ $0209
ram152          equ $0210
ram153          equ $0211
ram154          equ $0212
ram155          equ $0213
ram156          equ $0215
ram157          equ $0220
ram158          equ $0221
ram159          equ $0222
ram160          equ $0223
arr111          equ $0230
arr112          equ $0240
arr113          equ $0280
arr114          equ $0281
arr115          equ $0282
arr116          equ $0283
arr117          equ $0284
arr118          equ $0285
arr119          equ $0286
arr120          equ $0287
arr121          equ $0288
arr122          equ $0289
arr123          equ $028a
arr124          equ $028b
arr125          equ $028c
arr126          equ $028d
arr127          equ $028e
arr128          equ $028f
ram161          equ $02c0
ram162          equ $02c1
ram163          equ $02c2
arr129          equ $02c3
arr130          equ $02de
ram164          equ $0300
arr131          equ $0301
arr132          equ $0302
arr133          equ $0303
arr134          equ $0304
arr135          equ $0305
ram165          equ $0308
arr136          equ $030b
arr137          equ $030c
ram166          equ $0316
ram167          equ $0340
ram168          equ $0341
arr138          equ $0343
ram169          equ $0344
ram170          equ $0345
arr139          equ $0346
ram171          equ $0347
ram172          equ $0348
ram173          equ $0349
ram174          equ $034a
ram175          equ $034b
arr140          equ $0350
arr141          equ $038c
ram176          equ $0390
ram177          equ $0391
ram178          equ $03a9
arr142          equ $03f0
ram179          equ $03f1
arr143          equ $03ff
arr144          equ $0400
arr145          equ $0401
arr146          equ $0402
ram180          equ $0403
arr147          equ $0405
arr148          equ $0409
ram181          equ $040a
arr149          equ $040f
arr150          equ $0410
arr151          equ $0415
ram182          equ $0416
ram183          equ $0417
ram184          equ $0418
ram185          equ $0419
ram186          equ $041a
arr152          equ $041f
arr153          equ $0420
ram187          equ $042a
arr154          equ $042f
arr155          equ $0430
arr156          equ $0434
ram188          equ $0435
ram189          equ $0436
ram190          equ $0437
ram191          equ $0438
ram192          equ $0439
ram193          equ $043a
arr157          equ $0440
ram194          equ $0444
ram195          equ $0445
ram196          equ $0447
ram197          equ $0448
arr158          equ $0449
arr159          equ $0480
ram198          equ $04a9
arr160          equ $0500
arr161          equ $0501
ram199          equ $0504
ram200          equ $0505
ram201          equ $0506
arr162          equ $0510
ram202          equ $0512
ram203          equ $0513
ram204          equ $0514
ram205          equ $0515
ram206          equ $0516
ram207          equ $0517
arr163          equ $0520
arr164          equ $0530
arr165          equ $0531
ram208          equ $0534
arr166          equ $0550
arr167          equ $0580
ram209          equ $05ff
arr168          equ $0600
arr169          equ $0601
arr170          equ $0602
arr171          equ $0607
arr172          equ $0618
ram210          equ $0619
arr173          equ $0620
arr174          equ $0634
ram211          equ $063b
arr175          equ $063c
arr176          equ $063d
arr177          equ $063e
arr178          equ $0645
arr179          equ $0655
arr180          equ $066d
arr181          equ $0680
arr182          equ $06c0
arr183          equ $06c1
arr184          equ $06c2
arr185          equ $06c3
arr186          equ $06c4
arr187          equ $06c5
arr188          equ $06c6
arr189          equ $06c7
arr190          equ $06fd
arr191          equ $0700
ram212          equ $0701
ram213          equ $0702
ram214          equ $0703
ram215          equ $0704
arr192          equ $0715
arr193          equ $072d
arr194          equ $073c
arr195          equ $073d
arr196          equ $073e
ram216          equ $0781
ram217          equ $0800
ram218          equ $0802
arr197          equ $0903
arr198          equ $0a00
ram219          equ $0a0d
ram220          equ $0b0c
arr199          equ $0c06
arr200          equ $0d0d
ram221          equ $0d2e
ram222          equ $0d4d
ram223          equ $0d54
arr201          equ $0d5b
ram224          equ $0d61
ram225          equ $0d79
arr202          equ $0d92
ram226          equ $0da5
ram227          equ $0dc0
ram228          equ $0df3
ram229          equ $0e10
ram230          equ $0ea9
arr203          equ $0f00
ram231          equ $0f0c
ram232          equ $0f0e
arr204          equ $0f14
arr205          equ $0f9a
ram233          equ $0fac
ram234          equ $1020
arr206          equ $10c2
ram235          equ $1211
ram236          equ $1415
ram237          equ $15a9
ram238          equ $1612
ram239          equ $16a9
ram240          equ $1744
ram241          equ $1800
arr207          equ $1814
ram242          equ $1920
ram243          equ $1a23
arr208          equ $1aff
arr209          equ $1b1a
arr210          equ $1c00
ram244          equ $1c24
ram245          equ $1ca9
arr211          equ $1cc5
arr212          equ $1d02
ram246          equ $1d1f
ram247          equ $1e08
ppu_ctrl        equ $2000
ppu_mask        equ $2001
ppu_status      equ $2002
oam_addr        equ $2003
;oam_data       equ $2004
ppu_scroll      equ $2005
ppu_addr        equ $2006
ppu_data        equ $2007
misc1           equ $200b
misc2           equ $200d
misc3           equ $2020
misc4           equ $2033
misc5           equ $2045
misc6           equ $206f
misc7           equ $2075
misc8           equ $2078
misc9           equ $2079
misc10          equ $2087
misc11          equ $208c
misc12          equ $208d
misc13          equ $2097
misc14          equ $20b7
misc15          equ $20c0
misc16          equ $20f1
misc17          equ $20fe
misc18          equ $211f
misc19          equ $2120
misc20          equ $2121
misc21          equ $2161
misc22          equ $221f
misc23          equ $22a0
misc24          equ $22ff
misc25          equ $2320
misc26          equ $2323
misc27          equ $23bf
misc28          equ $23fb
misc29          equ $2420
misc30          equ $2622
misc31          equ $2720
misc32          equ $2824
misc33          equ $28c9
misc34          equ $2b08
misc35          equ $2c2c
misc36          equ $2c36
misc37          equ $2d46
misc38          equ $2d63
misc39          equ $2d64
misc40          equ $2d82
misc41          equ $2d94
misc42          equ $2da4
misc43          equ $2daa
misc44          equ $2daf
misc45          equ $2ea4
misc46          equ $300f
misc47          equ $3060
misc48          equ $3122
misc49          equ $3239
misc50          equ $3256
misc51          equ $33a5
misc52          equ $3432
misc53          equ $3446
misc54          equ $34f3
misc55          equ $3746
misc56          equ $37b9
misc57          equ $3846
misc58          equ $3a08
misc59          equ $3a34
misc60          equ $3a3a
misc61          equ $3b3a
misc62          equ $3cf5
misc63          equ $3cf8
misc64          equ $3df6
misc65          equ $3ef4
misc66          equ $3f22
misc67          equ $3f29
misc68          equ $3f65
misc69          equ $3f73
sq1_vol         equ $4000
sq1_sweep       equ $4001
sq1_lo          equ $4002
sq1_hi          equ $4003
sq2_vol         equ $4004
sq2_sweep       equ $4005
;sq2_lo         equ $4006
;sq2_hi         equ $4007
tri_linear      equ $4008
tri_lo          equ $400a
tri_hi          equ $400b
;noise_vol      equ $400c
;noise_lo       equ $400e
;noise_hi       equ $400f
dmc_freq        equ $4010
dmc_raw         equ $4011
;dmc_start      equ $4012
;dmc_len        equ $4013
oam_dma         equ $4014
snd_chn         equ $4015
joypad1         equ $4016
joypad2         equ $4017
misc70          equ $4040
misc71          equ $4131
misc72          equ $4142
misc73          equ $4143
misc74          equ $4145
misc75          equ $4147
misc76          equ $414f
misc77          equ $4150
misc78          equ $4156
misc79          equ $4200
misc80          equ $4220
misc81          equ $422d
misc82          equ $4240
misc83          equ $4300
misc84          equ $434f
misc85          equ $4427
misc86          equ $442e
misc87          equ $4435
misc88          equ $4447
misc89          equ $4449
misc90          equ $444e
misc91          equ $444f
misc92          equ $4455
misc93          equ $452d
misc94          equ $4548
misc95          equ $454e
misc96          equ $4554
misc97          equ $4600
misc98          equ $4620
misc99          equ $4645
misc100         equ $464f
misc101         equ $4700
misc102         equ $4720
misc103         equ $4752
misc104         equ $4800
misc105         equ $494e
misc106         equ $4b4f
misc107         equ $4ba8
misc108         equ $4c00
misc109         equ $4c4b
misc110         equ $4c55
misc111         equ $4c5c
misc112         equ $4cac
misc113         equ $4d0d
misc114         equ $4d41
misc115         equ $4d4e
misc116         equ $4dac
misc117         equ $4dfb
misc118         equ $4e00
misc119         equ $4e0e
misc120         equ $4e45
misc121         equ $4e49
misc122         equ $4e4f
misc123         equ $4e99
misc124         equ $4f42
misc125         equ $4f44
misc126         equ $4f46
misc127         equ $4f4c
misc128         equ $4f50
misc129         equ $4f9b
misc130         equ $5000
misc131         equ $5048
misc132         equ $504e
misc133         equ $5088
misc134         equ $50da
misc135         equ $5200
misc136         equ $5245
misc137         equ $5246
misc138         equ $5247
misc139         equ $524f
misc140         equ $5284
misc141         equ $5300
misc142         equ $5345
misc143         equ $5349
misc144         equ $5354
misc145         equ $5355
misc146         equ $53d2
misc147         equ $5445
misc148         equ $544f
misc149         equ $5450
misc150         equ $5453
misc151         equ $5486
misc152         equ $5548
misc153         equ $564f
misc154         equ $574f
misc155         equ $5753
misc156         equ $5808
misc157         equ $590a
misc158         equ $5942
misc159         equ $5a63
misc160         equ $5ba2
misc161         equ $5ef7
misc162         equ $5f3f
misc163         equ $5fbd
misc164         equ $6020
misc165         equ $6052
misc166         equ $605c
misc167         equ $6064
misc168         equ $607b
misc169         equ $60ff
misc170         equ $610d
misc171         equ $6120
misc172         equ $613f
misc173         equ $6161
misc174         equ $6165
misc175         equ $616f
misc176         equ $6172
misc177         equ $6179
misc178         equ $6185
misc179         equ $6220
misc180         equ $6240
misc181         equ $626e
misc182         equ $6278
misc183         equ $6285
misc184         equ $62a5
misc185         equ $62ff
misc186         equ $630d
misc187         equ $6397
misc188         equ $6420
misc189         equ $6423
misc190         equ $650d
misc191         equ $6520
misc192         equ $6562
misc193         equ $6565
misc194         equ $656c
misc195         equ $6585
misc196         equ $6666
misc197         equ $666a
misc198         equ $6672
misc199         equ $6696
misc200         equ $66a4
misc201         equ $6796
misc202         equ $6869
misc203         equ $6871
misc204         equ $689c
misc205         equ $690d
misc206         equ $6968
misc207         equ $696c
misc208         equ $6973
misc209         equ $6978
misc210         equ $6ae6
misc211         equ $6aff
misc212         equ $6b0d
misc213         equ $6b20
misc214         equ $6b61
misc215         equ $6b7d
misc216         equ $6b86
misc217         equ $6ba4
misc218         equ $6c66
misc219         equ $6c6a
misc220         equ $6c6c
misc221         equ $6c7f
misc222         equ $6ca4
misc223         equ $6d65
misc224         equ $6d83
misc225         equ $6d95
misc226         equ $6da3
misc227         equ $6dff
misc228         equ $6e6d
misc229         equ $6ecf
misc230         equ $6f6b
misc231         equ $6f6c
misc232         equ $6f8b
misc233         equ $7000
misc234         equ $7001
misc235         equ $7013
misc236         equ $7020
misc237         equ $7026
misc238         equ $7039
misc239         equ $703a
misc240         equ $703b
misc241         equ $703c
misc242         equ $703d
misc243         equ $703e
misc244         equ $703f
misc245         equ $7040
misc246         equ $706a
misc247         equ $70ff
misc248         equ $716b
misc249         equ $7170
misc250         equ $71ff
misc251         equ $7200
misc252         equ $725a
misc253         equ $7260
misc254         equ $726b
misc255         equ $7289
misc256         equ $72c0
misc257         equ $7364
misc258         equ $7400
misc259         equ $7420
misc260         equ $7464
misc261         equ $746b
misc262         equ $7500
misc263         equ $750c
misc264         equ $7563
misc265         equ $7574
misc266         equ $75a4
misc267         equ $75ff
misc268         equ $7600
misc269         equ $7601
misc270         equ $7608
misc271         equ $76ac
misc272         equ $7761
misc273         equ $7820
misc274         equ $78ff
misc275         equ $7964
misc276         equ $796e
misc277         equ $7a78
misc278         equ $7b0d
misc279         equ $7b8c
misc280         equ $7e20
misc281         equ $7e61
misc282         equ $7e6b
misc283         equ $7e74
misc284         equ $7ea4
misc285         equ $7eff
misc286         equ $7f00

; --- PRG ROM (CPU $8000-$ffff) -----------------------------------------------

; labels: 'sub' = subroutine, 'cod' = code, 'dat' = data

                org $8000

cod1            jmp cod2                     ; 8000: 4c ad 80
sub1            jmp sub206                   ; 8003: 4c 88 af
dat1            ldx misc119                  ; 8006: ae 0e 4e
                asl ram228                   ; 8009: 0e f3 0d

                hex 9e                       ; 800c

dat2            ora ram222                   ; 800d: 0d 4d 0d
                ora (arr8,x)                 ; 8010: 01 0d
                lda misc263,y                ; 8012: b9 0c 75

                hex 0c                       ; 8015

                and arr7,x                   ; 8016: 35 0c
                sed                          ; 8018: f8

                hex 0b bf 0b 89 0b 57 0b 27  ; 8019
                hex 0b                       ; 8021

                sbc dat110,y                 ; 8022: f9 0a cf
                asl a                        ; 8025: 0a
                ldx ram5                     ; 8026: a6 0a

                hex 80                       ; 8028

                asl a                        ; 8029: 0a

                hex 5c                       ; 802a

                asl a                        ; 802b: 0a

                hex 3a                       ; 802c

                asl a                        ; 802d: 0a

                hex 1a                       ; 802e

                asl a                        ; 802f: 0a

                hex fc                       ; 8030

                ora #%11011111               ; 8031: 09 df
                ora #%11000100               ; 8033: 09 c4
                ora #%10101011               ; 8035: 09 ab
                ora #%10010011               ; 8037: 09 93
                ora #%01111100               ; 8039: 09 7c
                ora #%01100111               ; 803b: 09 67
                ora #%01010010               ; 803d: 09 52
                ora #%00111111               ; 803f: 09 3f
                ora #%00101101               ; 8041: 09 2d
                ora #%00011100               ; 8043: 09 1c
                ora #%00001100               ; 8045: 09 0c
                ora #%11111101               ; 8047: 09 fd
                php                          ; 8049: 08
                inc $e108                    ; 804a: ee 08 e1
                php                          ; 804d: 08

                hex d4                       ; 804e

                php                          ; 804f: 08
                iny                          ; 8050: c8
                php                          ; 8051: 08
                lda $b208,x                  ; 8052: bd 08 b2
                php                          ; 8055: 08
                tay                          ; 8056: a8
                php                          ; 8057: 08

                hex 9f                       ; 8058

                php                          ; 8059: 08
                stx arr6,y                   ; 805a: 96 08
                sta $8508                    ; 805c: 8d 08 85
                php                          ; 805f: 08
                ror misc270,x                ; 8060: 7e 08 76
                php                          ; 8063: 08
                bvs +                        ; 8064: 70 08
                adc #8                       ; 8066: 69 08

                hex 63                       ; 8068

                php                          ; 8069: 08
                lsr misc156,x                ; 806a: 5e 08 58
                php                          ; 806d: 08

+               hex 53                       ; 806e

                php                          ; 806f: 08

                hex 4f                       ; 8070

                php                          ; 8071: 08
                lsr a                        ; 8072: 4a
                php                          ; 8073: 08
                lsr arr6                     ; 8074: 46 08

                hex 42                       ; 8076

                php                          ; 8077: 08
                rol misc58,x                 ; 8078: 3e 08 3a
                php                          ; 807b: 08

                hex 37                       ; 807c

                php                          ; 807d: 08

                hex 34                       ; 807e

                php                          ; 807f: 08
                and (arr6),y                 ; 8080: 31 08
                rol misc34                   ; 8082: 2e 08 2b
                php                          ; 8085: 08
                and #%00001000               ; 8086: 29 08

                hex 27                       ; 8088

                php                          ; 8089: 08
                bit arr6                     ; 808a: 24 08

                hex 22                       ; 808c

                php                          ; 808d: 08
                jsr ram247                   ; 808e: 20 08 1e
                php                          ; 8091: 08

                hex 1c                       ; 8092

                php                          ; 8093: 08

                hex 1b                       ; 8094

                php                          ; 8095: 08
dat3            ora (arr3,x)                 ; 8096: 01 02

                hex 03 04                    ; 8098

                asl arr6                     ; 809a: 06 08

                hex 0c                       ; 809c

                bpl cod3                     ; 809d: 10 18
                jsr ram238                   ; 809f: 20 12 16
                brk                          ; 80a2: 00

                hex 04                       ; 80a3

                php                          ; 80a4: 08
                asl a                        ; 80a5: 0a
                asl ram241                   ; 80a6: 0e 00 18
                bmi cod5                     ; 80a9: 30 48
                rts                          ; 80ab: 60
                sei                          ; 80ac: 78
cod2            lda #$4c                     ; 80ad: a9 4c
                sta arr98                    ; 80af: 85 ed
                lda #$0f                     ; 80b1: a9 0f
                sta arr99                    ; 80b3: 85 ee
                lda #$88                     ; 80b5: a9 88
cod3            sta ram133                   ; 80b7: 85 ef
                jsr $aa82                    ; 80b9: 20 82 aa
                jsr sub2                     ; 80bc: 20 31 81
-               jsr sub204                   ; 80bf: 20 a9 ad
                jsr sub206                   ; 80c2: 20 88 af
                cmp #$31                     ; 80c5: c9 31
                beq cod4                     ; 80c7: f0 27
                cmp #$32                     ; 80c9: c9 32
                beq +                        ; 80cb: f0 07
                cmp #$33                     ; 80cd: c9 33
                bne -                        ; 80cf: d0 ee
                jmp $c400                    ; 80d1: 4c 00 c4
+               jmp cod351                   ; 80d4: 4c af b5
                lda #$5a                     ; 80d7: a9 5a
                sta misc239                  ; 80d9: 8d 3a 70
                lda #$33                     ; 80dc: a9 33
                sta misc240                  ; 80de: 8d 3b 70
                sta arr1                     ; 80e1: 85 00
                lda ram3                     ; 80e3: a5 07
                sta misc241                  ; 80e5: 8d 3c 70
                lda arr6                     ; 80e8: a5 08
                sta misc242                  ; 80ea: 8d 3d 70
                jmp cod2                     ; 80ed: 4c ad 80 JMP $80AD 
cod4            jsr sub206                   ; 80f0: 20 88 af
cod5            bne cod4                     ; 80f3: d0 fb
                lda arr1                     ; 80f5: a5 00
                cmp #$59                     ; 80f7: c9 59
                beq +                        ; 80f9: f0 26
                lda misc239                  ; 80fb: ad 3a 70
                cmp #$5a                     ; 80fe: c9 5a
                bne cod6                     ; 8100: d0 25
                lda misc240                  ; 8102: ad 3b 70
                cmp #$33                     ; 8105: c9 33
                bne cod6                     ; 8107: d0 1e
                lda misc241                  ; 8109: ad 3c 70
                sta ram3                     ; 810c: 85 07
                lda misc242                  ; 810e: ad 3d 70
                sta arr6                     ; 8111: 85 08
                lda #$3e                     ; 8113: a9 3e
                sta arr4                     ; 8115: 85 05
                lda #$70                     ; 8117: a9 70
                sta arr5                     ; 8119: 85 06
                jsr sub95                    ; 811b: 20 28 92
                jsr sub3                     ; 811e: 20 4b 81
+               jsr sub20                    ; 8121: 20 2e 85
                jmp cod9                     ; 8124: 4c 0b 82
cod6            jsr sub3                     ; 8127: 20 4b 81
                lda #$59                     ; 812a: a9 59
                sta arr1                     ; 812c: 85 00
                jmp cod8                     ; 812e: 4c ff 81
sub2            jsr sub206                   ; 8131: 20 88 af
                bne sub2                     ; 8134: d0 fb
                jsr sub5                     ; 8136: 20 9c 81
                lda #0                       ; 8139: a9 00
                sta arr31                    ; 813b: 85 44
-               lda arr31                    ; 813d: a5 44
                cmp #5                       ; 813f: c9 05
                beq cod7                     ; 8141: f0 07
                jsr sub4                     ; 8143: 20 54 81
                inc arr31                    ; 8146: e6 44
                bne -                        ; 8148: d0 f3
cod7            rts                          ; 814a: 60
sub3            lda ram89                    ; 814b: a5 9e
                cmp #$81                     ; 814d: c9 81
                beq cod7                     ; 814f: f0 f9
                jmp sub185                   ; 8151: 4c 71 ab
sub4            asl a                        ; 8154: 0a
                asl a                        ; 8155: 0a
                tax                          ; 8156: aa
                lda $c391,x                  ; 8157: bd 91 c3
                sta arr34                    ; 815a: 85 48
                lda dat74,x                  ; 815c: bd 92 c3
                sta arr35                    ; 815f: 85 49
                lda dat75,x                  ; 8161: bd 93 c3
                sta arr41                    ; 8164: 85 52
                lda $c394,x                  ; 8166: bd 94 c3
                sta arr42                    ; 8169: 85 53
                jmp sub32                    ; 816b: 4c f8 87
                and (arr19),y                ; 816e: 31 2d
                and misc72                   ; 8170: 2d 42 41

                hex 53                       ; 8173

                eor #%01000011               ; 8174: 49 43
                brk                          ; 8176: 00

                hex 32                       ; 8177

                and misc81                   ; 8178: 2d 2d 42

                hex 47                       ; 817b

                jsr misc138                  ; 817c: 20 47 52
                eor (arr39,x)                ; 817f: 41 50
                pha                          ; 8181: 48
                eor #%01000011               ; 8182: 49 43
                brk                          ; 8184: 00

                hex 33                       ; 8185

                and misc93                   ; 8186: 2d 2d 45
                lsr_abs arr31                ; 8189: 4e 44 00
                and (arr18),y                ; 818c: 31 2c

                hex 32                       ; 818e

                bit misc4                    ; 818f: 2c 33 20

                hex 4b                       ; 8192

                eor ram44                    ; 8193: 45 59
                jsr misc121                  ; 8195: 20 49 4e
                jsr misc20                   ; 8198: 20 21 21
                brk                          ; 819b: 00
sub5            jsr sub191                   ; 819c: 20 f1 ab
                lda #$de                     ; 819f: a9 de
                sta arr76                    ; 81a1: 85 ad
                lda #$20                     ; 81a3: a9 20
                ldx #$c5                     ; 81a5: a2 c5
                jsr sub6                     ; 81a7: 20 d3 81
                lda #$e0                     ; 81aa: a9 e0
                sta arr76                    ; 81ac: 85 ad
                lda #$22                     ; 81ae: a9 22
                ldx #$e5                     ; 81b0: a2 e5
                jsr sub6                     ; 81b2: 20 d3 81
                lda arr21                    ; 81b5: a5 32
                ora #%00000100               ; 81b7: 09 04
                sta ppu_ctrl                 ; 81b9: 8d 00 20
                lda #$20                     ; 81bc: a9 20
                ldx #$e5                     ; 81be: a2 e5
                jsr sub7                     ; 81c0: 20 ea 81
                lda #$20                     ; 81c3: a9 20
                ldx #$fa                     ; 81c5: a2 fa
                jsr sub7                     ; 81c7: 20 ea 81
                jsr sub190                   ; 81ca: 20 e6 ab
                jsr sub220                   ; 81cd: 20 f1 b3
                jmp sub192                   ; 81d0: 4c fa ab
sub6            jsr sub9                     ; 81d3: 20 f8 81
                lda arr76                    ; 81d6: a5 ad
                sta ppu_data                 ; 81d8: 8d 07 20
                lda #$e3                     ; 81db: a9 e3
                ldy #$14                     ; 81dd: a0 14
                jsr sub8                     ; 81df: 20 f1 81
                inc arr76                    ; 81e2: e6 ad
                lda arr76                    ; 81e4: a5 ad
                sta ppu_data                 ; 81e6: 8d 07 20
                rts                          ; 81e9: 60
sub7            jsr sub9                     ; 81ea: 20 f8 81
                lda #$e2                     ; 81ed: a9 e2
                ldy #$10                     ; 81ef: a0 10
sub8            sta ppu_data                 ; 81f1: 8d 07 20
                dey                          ; 81f4: 88
                bne sub8                     ; 81f5: d0 fa
                rts                          ; 81f7: 60
sub9            sta ppu_addr                 ; 81f8: 8d 06 20
                stx ppu_addr                 ; 81fb: 8e 06 20
                rts                          ; 81fe: 60
cod8            ldx #$ff                     ; 81ff: a2 ff
                txs                          ; 8201: 9a
                jsr sub20                    ; 8202: 20 2e 85
                jsr sub14                    ; 8205: 20 88 83
                jsr sub180                   ; 8208: 20 09 aa
cod9            jsr sub28                    ; 820b: 20 3b 87
                sta misc239                  ; 820e: 8d 3a 70
                sta misc240                  ; 8211: 8d 3b 70
cod10           ldx #$ff                     ; 8214: a2 ff
                txs                          ; 8216: 9a
                txa                          ; 8217: 8a
                pha                          ; 8218: 48
                pha                          ; 8219: 48
                jsr sub204                   ; 821a: 20 a9 ad
cod11           tsx                          ; 821d: ba
                stx ram13                    ; 821e: 86 17
                cli                          ; 8220: 58
cod12           ldx ram13                    ; 8221: a6 17
                txs                          ; 8223: 9a
                jsr sub193                   ; 8224: 20 03 ac
                jsr sub179                   ; 8227: 20 ff a9
                lda ram21                    ; 822a: a5 24
                beq +                        ; 822c: f0 05
                lda #$2e                     ; 822e: a9 2e
                jsr sub195                   ; 8230: 20 0d ac
+               jsr sub193                   ; 8233: 20 03 ac
-               jsr sub213                   ; 8236: 20 43 b3
                jsr sub36                    ; 8239: 20 32 8a
                jsr sub63                    ; 823c: 20 c7 8c
                cmp #3                       ; 823f: c9 03
                beq -                        ; 8241: f0 f3
                jsr sub64                    ; 8243: 20 d4 8c
                and #%11111111               ; 8246: 29 ff
                beq -                        ; 8248: f0 ec
                jsr sub65                    ; 824a: 20 dd 8c
                bcs cod13                    ; 824d: b0 10
                jsr sub15                    ; 824f: 20 b1 83
                jsr sub95                    ; 8252: 20 28 92
                jmp -                        ; 8255: 4c 36 82
sub10           lda #$ff                     ; 8258: a9 ff
                sta ram6                     ; 825a: 85 0b
                sta arr7                     ; 825c: 85 0c
                rts                          ; 825e: 60
cod13           jsr sub84                    ; 825f: 20 59 8e
                lda #$44                     ; 8262: a9 44
                sta arr8                     ; 8264: 85 0d
                lda #$b1                     ; 8266: a9 b1
                sta ram7                     ; 8268: 85 0e
                lda #0                       ; 826a: a9 00
                sta ram4                     ; 826c: 85 09
                lda #3                       ; 826e: a9 03
                sta ram5                     ; 8270: 85 0a
                jsr sub10                    ; 8272: 20 58 82
cod14           jsr sub27                    ; 8275: 20 d4 86
                jsr sub39                    ; 8278: 20 5b 8a
                jsr sub64                    ; 827b: 20 d4 8c
                pha                          ; 827e: 48
                lda ram4                     ; 827f: a5 09
                sta arr46                    ; 8281: 85 58
                lda ram5                     ; 8283: a5 0a
                sta ram44                    ; 8285: 85 59
                jsr sub60                    ; 8287: 20 a1 8c
                pla                          ; 828a: 68
                beq cod15                    ; 828b: f0 4d
                cmp #$3a                     ; 828d: c9 3a
                beq cod14                    ; 828f: f0 e4
                cmp #$27                     ; 8291: c9 27
                beq cod15                    ; 8293: f0 45
                cmp #$80                     ; 8295: c9 80
                bcs cod16                    ; 8297: b0 44
                jsr sub143                   ; 8299: 20 c3 a1
                bcs +                        ; 829c: b0 39
                pha                          ; 829e: 48
                jsr sub62                    ; 829f: 20 bb 8c
                pla                          ; 82a2: 68
                jsr sub135                   ; 82a3: 20 75 9f
                lda ram79                    ; 82a6: a5 90
                pha                          ; 82a8: 48
                lda arr64                    ; 82a9: a5 8c
                pha                          ; 82ab: 48
                lda arr65                    ; 82ac: a5 8d
                pha                          ; 82ae: 48
                jsr sub21                    ; 82af: 20 a2 85
                jsr sub122                   ; 82b2: 20 82 9c
                pla                          ; 82b5: 68
                sta arr65                    ; 82b6: 85 8d
                pla                          ; 82b8: 68
                sta arr64                    ; 82b9: 85 8c
                pla                          ; 82bb: 68
                sta ram79                    ; 82bc: 85 90
                ldy #0                       ; 82be: a0 00
                and #%00001111               ; 82c0: 29 0f
                cmp #3                       ; 82c2: c9 03
                beq cod18                    ; 82c4: f0 1d
                jsr sub158                   ; 82c6: 20 ef a3
                lda arr144                   ; 82c9: ad 00 04
                sta (arr64),y                ; 82cc: 91 8c
                lda arr145                   ; 82ce: ad 01 04
                iny                          ; 82d1: c8
                sta (arr64),y                ; 82d2: 91 8c
                jmp cod14                    ; 82d4: 4c 75 82
+               jmp cod24                    ; 82d7: 4c 6d 83
cod15           jmp cod22                    ; 82da: 4c 45 83
cod16           jmp cod20                    ; 82dd: 4c 21 83
cod17           jmp $8370                    ; 82e0: 4c 70 83
cod18           jsr $a3f2                    ; 82e3: 20 f2 a3
                jsr sub11                    ; 82e6: 20 ef 82
                jmp cod14                    ; 82e9: 4c 75 82
cod19           sta (arr64),y                ; 82ec: 91 8c
                rts                          ; 82ee: 60
sub11           ldy #0                       ; 82ef: a0 00
                lda arr144                   ; 82f1: ad 00 04
                beq cod19                    ; 82f4: f0 f6
                cmp #$20                     ; 82f6: c9 20
                bcs cod17                    ; 82f8: b0 e6
                sta (arr64),y                ; 82fa: 91 8c
                lda arr145                   ; 82fc: ad 01 04
                sta ram14                    ; 82ff: 85 19
                lda arr146                   ; 8301: ad 02 04
                sta ram15                    ; 8304: 85 1a
                iny                          ; 8306: c8
                tya                          ; 8307: 98
                clc                          ; 8308: 18
                adc arr64                    ; 8309: 65 8c
                sta arr64                    ; 830b: 85 8c
                lda #0                       ; 830d: a9 00
                adc arr65                    ; 830f: 65 8d
                sta arr65                    ; 8311: 85 8d
                ldx arr144                   ; 8313: ae 00 04
                ldy #0                       ; 8316: a0 00
-               lda (ram14),y                ; 8318: b1 19
                sta (arr64),y                ; 831a: 91 8c
                iny                          ; 831c: c8
                dex                          ; 831d: ca
                bne -                        ; 831e: d0 f8
                rts                          ; 8320: 60
cod20           sec                          ; 8321: 38
                sbc #$80                     ; 8322: e9 80
                cmp #$44                     ; 8324: c9 44
                bcs cod24                    ; 8326: b0 45
                asl a                        ; 8328: 0a
                tax                          ; 8329: aa
                lda dat72,x                  ; 832a: bd c6 c2
                sta ram14                    ; 832d: 85 19
                lda $c2c7,x                  ; 832f: bd c7 c2
                sta ram15                    ; 8332: 85 1a
                tsx                          ; 8334: ba
                stx ram13                    ; 8335: 86 17
                jsr sub13                    ; 8337: 20 78 83
                jsr sub127                   ; 833a: 20 4b 9d
                jmp cod14                    ; 833d: 4c 75 82
cod21           jmp cod11                    ; 8340: 4c 1d 82
                pla                          ; 8343: 68
                pla                          ; 8344: 68
cod22           lda arr8                     ; 8345: a5 0d
                sta ram4                     ; 8347: 85 09
                lda ram7                     ; 8349: a5 0e
                sta ram5                     ; 834b: 85 0a
cod23           jsr sub63                    ; 834d: 20 c7 8c
                beq cod21                    ; 8350: f0 ee
                clc                          ; 8352: 18
                adc ram4                     ; 8353: 65 09
                sta arr8                     ; 8355: 85 0d
                lda #0                       ; 8357: a9 00
                adc ram5                     ; 8359: 65 0a
                sta ram7                     ; 835b: 85 0e
                iny                          ; 835d: c8
                lda (ram4),y                 ; 835e: b1 09
                sta ram6                     ; 8360: 85 0b
                iny                          ; 8362: c8
                lda (ram4),y                 ; 8363: b1 09
                sta arr7                     ; 8365: 85 0c
                jsr sub113                   ; 8367: 20 27 99
                jmp cod14                    ; 836a: 4c 75 82
cod24           lda #1                       ; 836d: a9 01
                ldx ram198                   ; 836f: ae a9 04
                jmp cod287                   ; 8372: 4c 8f a9
sub12           jsr sub60                    ; 8375: 20 a1 8c
sub13           jsr sub64                    ; 8378: 20 d4 8c
                and #%11111111               ; 837b: 29 ff
                beq +                        ; 837d: f0 02
                cmp #$3a                     ; 837f: c9 3a
+               rts                          ; 8381: 60
                jsr sub14                    ; 8382: 20 88 83
                jmp cod10                    ; 8385: 4c 14 82
sub14           jsr sub28                    ; 8388: 20 3b 87
                sta misc243                  ; 838b: 8d 3e 70
                sta misc244                  ; 838e: 8d 3f 70
                sta misc245                  ; 8391: 8d 40 70
                ldx #$3e                     ; 8394: a2 3e
                stx arr4                     ; 8396: 86 05
                inx                          ; 8398: e8
                stx ram3                     ; 8399: 86 07
                inx                          ; 839b: e8
                stx ram18                    ; 839c: 86 1d
                inx                          ; 839e: e8
                stx arr13                    ; 839f: 86 1f
                inx                          ; 83a1: e8
                stx arr15                    ; 83a2: 86 21
                lda #$70                     ; 83a4: a9 70
                sta arr5                     ; 83a6: 85 06
                sta arr6                     ; 83a8: 85 08
                sta ram19                    ; 83aa: 85 1e
                sta arr14                    ; 83ac: 85 20
                sta ram20                    ; 83ae: 85 22
                rts                          ; 83b0: 60
sub15           jsr sub28                    ; 83b1: 20 3b 87
                jsr sub10                    ; 83b4: 20 58 82
                jsr sub68                    ; 83b7: 20 09 8d
                lda #$ff                     ; 83ba: a9 ff
                cmp ram24                    ; 83bc: c5 28
                bne +                        ; 83be: d0 06
                cmp ram25                    ; 83c0: c5 29
                bne +                        ; 83c2: d0 02
                beq $8370                    ; 83c4: f0 aa
+               jsr sub63                    ; 83c6: 20 c7 8c
                cmp #$20                     ; 83c9: c9 20
                bne +                        ; 83cb: d0 03
                jsr sub61                    ; 83cd: 20 ad 8c
+               and #%11111111               ; 83d0: 29 ff
                beq +                        ; 83d2: f0 2d
                lda ram24                    ; 83d4: a5 28
                sta arr31                    ; 83d6: 85 44
                lda ram25                    ; 83d8: a5 29
                sta arr32                    ; 83da: 85 45
                jsr sub84                    ; 83dc: 20 59 8e
                sec                          ; 83df: 38
                lda ram42                    ; 83e0: a5 4d
                sbc #0                       ; 83e2: e9 00
                sta ram24                    ; 83e4: 85 28
                lda arr37                    ; 83e6: a5 4e
                sbc #3                       ; 83e8: e9 03
                sta ram25                    ; 83ea: 85 29
                lda #2                       ; 83ec: a9 02
                clc                          ; 83ee: 18
                adc ram24                    ; 83ef: 65 28
                sta ram45                    ; 83f1: 85 5a
                lda arr31                    ; 83f3: a5 44
                sta arr9                     ; 83f5: 85 0f
                lda arr32                    ; 83f7: a5 45
                sta ram8                     ; 83f9: 85 10
                jsr sub17                    ; 83fb: 20 48 84
                jmp cod29                    ; 83fe: 4c 8a 84
+               jmp cod28                    ; 8401: 4c 40 84
sub16           lda arr4                     ; 8404: a5 05
                sta ram46                    ; 8406: 85 5b
                lda arr5                     ; 8408: a5 06
                sta ram47                    ; 840a: 85 5c
cod25           ldy #0                       ; 840c: a0 00
                lda (ram46),y                ; 840e: b1 5b
                bne cod27                    ; 8410: d0 03
                lda #$ff                     ; 8412: a9 ff
cod26           rts                          ; 8414: 60
cod27           iny                          ; 8415: c8
                lda (ram46),y                ; 8416: b1 5b
                sta arr18                    ; 8418: 85 2c
                iny                          ; 841a: c8
                lda (ram46),y                ; 841b: b1 5b
                sta arr19                    ; 841d: 85 2d
                lda arr31                    ; 841f: a5 44
                sta ram24                    ; 8421: 85 28
                lda arr32                    ; 8423: a5 45
                sta ram25                    ; 8425: 85 29
                jsr sub56                    ; 8427: 20 f7 8b
                beq cod26                    ; 842a: f0 e8
                bcc cod26                    ; 842c: 90 e6
                ldy #0                       ; 842e: a0 00
                clc                          ; 8430: 18
                lda (ram46),y                ; 8431: b1 5b
                adc ram46                    ; 8433: 65 5b
                sta ram46                    ; 8435: 85 5b
                lda ram47                    ; 8437: a5 5c
                adc #0                       ; 8439: 69 00
                sta ram47                    ; 843b: 85 5c
                jmp cod25                    ; 843d: 4c 0c 84
cod28           lda ram24                    ; 8440: a5 28
                sta arr31                    ; 8442: 85 44
                lda ram25                    ; 8444: a5 29
                sta arr32                    ; 8446: 85 45
sub17           jsr sub16                    ; 8448: 20 04 84
                bne cod26                    ; 844b: d0 c7
                ldy #0                       ; 844d: a0 00
                lda (ram46),y                ; 844f: b1 5b
                sta ram36                    ; 8451: 85 3c
                clc                          ; 8453: 18
                adc ram46                    ; 8454: 65 5b
                sta ram6                     ; 8456: 85 0b
                lda ram47                    ; 8458: a5 5c
                adc #0                       ; 845a: 69 00
                sta arr7                     ; 845c: 85 0c
-               ldy #0                       ; 845e: a0 00
                lda (ram6),y                 ; 8460: b1 0b
                sta (ram46),y                ; 8462: 91 5b
                inc ram6                     ; 8464: e6 0b
                bne +                        ; 8466: d0 02
                inc arr7                     ; 8468: e6 0c
+               inc ram46                    ; 846a: e6 5b
                bne +                        ; 846c: d0 02
                inc ram47                    ; 846e: e6 5c
+               lda ram47                    ; 8470: a5 5c
                cmp arr6                     ; 8472: c5 08
                bne -                        ; 8474: d0 e8
                lda ram46                    ; 8476: a5 5b
                cmp ram3                     ; 8478: c5 07
                bne -                        ; 847a: d0 e2
                sec                          ; 847c: 38
                lda ram3                     ; 847d: a5 07
                sbc ram36                    ; 847f: e5 3c
                sta ram3                     ; 8481: 85 07
                lda arr6                     ; 8483: a5 08
                sbc #0                       ; 8485: e9 00
                sta arr6                     ; 8487: 85 08
                rts                          ; 8489: 60
cod29           lda ram3                     ; 848a: a5 07
                clc                          ; 848c: 18
                adc ram45                    ; 848d: 65 5a
                sta ram24                    ; 848f: 85 28
                lda arr6                     ; 8491: a5 08
                adc #0                       ; 8493: 69 00
                sta ram25                    ; 8495: 85 29
                jsr sub38                    ; 8497: 20 44 8a
                jsr sub16                    ; 849a: 20 04 84
                lda ram3                     ; 849d: a5 07
                sta ram6                     ; 849f: 85 0b
                clc                          ; 84a1: 18
                adc ram45                    ; 84a2: 65 5a
                sta ram14                    ; 84a4: 85 19
                lda arr6                     ; 84a6: a5 08
                sta arr7                     ; 84a8: 85 0c
                adc #0                       ; 84aa: 69 00
                sta ram15                    ; 84ac: 85 1a
-               ldy #0                       ; 84ae: a0 00
                lda (ram6),y                 ; 84b0: b1 0b
                sta (ram14),y                ; 84b2: 91 19
                jsr sub18                    ; 84b4: 20 16 85
                jsr sub19                    ; 84b7: 20 22 85
                lda ram46                    ; 84ba: a5 5b
                cmp ram6                     ; 84bc: c5 0b
                bne -                        ; 84be: d0 ee
                lda ram47                    ; 84c0: a5 5c
                cmp arr7                     ; 84c2: c5 0c
                bne -                        ; 84c4: d0 e8
                lda (ram6),y                 ; 84c6: b1 0b
                sta (ram14),y                ; 84c8: 91 19
                ldy #0                       ; 84ca: a0 00
                lda ram45                    ; 84cc: a5 5a
                sta (ram46),y                ; 84ce: 91 5b
                iny                          ; 84d0: c8
                lda arr9                     ; 84d1: a5 0f
                sta (ram46),y                ; 84d3: 91 5b
                iny                          ; 84d5: c8
                lda ram8                     ; 84d6: a5 10
                sta (ram46),y                ; 84d8: 91 5b
                iny                          ; 84da: c8
                clc                          ; 84db: 18
                lda #3                       ; 84dc: a9 03
                adc ram46                    ; 84de: 65 5b
                sta ram46                    ; 84e0: 85 5b
                lda #0                       ; 84e2: a9 00
                adc ram47                    ; 84e4: 65 5c
                sta ram47                    ; 84e6: 85 5c
                lda ram45                    ; 84e8: a5 5a
                sec                          ; 84ea: 38
                sbc #3                       ; 84eb: e9 03
                tax                          ; 84ed: aa
                ldy #0                       ; 84ee: a0 00
                lda #0                       ; 84f0: a9 00
                sta ram42                    ; 84f2: 85 4d
                lda #3                       ; 84f4: a9 03
                sta arr37                    ; 84f6: 85 4e
-               lda (ram42),y                ; 84f8: b1 4d
                sta (ram46),y                ; 84fa: 91 5b
                iny                          ; 84fc: c8
                dex                          ; 84fd: ca
                bne -                        ; 84fe: d0 f8
                clc                          ; 8500: 18
                lda ram3                     ; 8501: a5 07
                adc ram45                    ; 8503: 65 5a
                sta ram3                     ; 8505: 85 07
                lda #0                       ; 8507: a9 00
                adc arr6                     ; 8509: 65 08
                sta arr6                     ; 850b: 85 08
                ldy #0                       ; 850d: a0 00
                tya                          ; 850f: 98
                sta (ram3),y                 ; 8510: 91 07
                iny                          ; 8512: c8
                sta (ram3),y                 ; 8513: 91 07
                rts                          ; 8515: 60
sub18           lda ram6                     ; 8516: a5 0b
                beq +                        ; 8518: f0 03
                dec ram6                     ; 851a: c6 0b
                rts                          ; 851c: 60
+               dec ram6                     ; 851d: c6 0b
                dec arr7                     ; 851f: c6 0c
                rts                          ; 8521: 60
sub19           lda ram14                    ; 8522: a5 19
                beq +                        ; 8524: f0 03
                dec ram14                    ; 8526: c6 19
                rts                          ; 8528: 60
+               dec ram14                    ; 8529: c6 19
                dec ram15                    ; 852b: c6 1a
                rts                          ; 852d: 60
sub20           lda #4                       ; 852e: a9 04
                sta arr78                    ; 8530: 85 b9
                sta ram109                   ; 8532: 85 ba
                sta ram110                   ; 8534: 85 bb
                lda #8                       ; 8536: a9 08
                sta arr82                    ; 8538: 85 c3
                sta ram115                   ; 853a: 85 c4
                sta arr83                    ; 853c: 85 c5
                lda #3                       ; 853e: a9 03
                sta arr81                    ; 8540: 85 bf
                sta ram112                   ; 8542: 85 c0
                sta ram113                   ; 8544: 85 c1
                lda #$0f                     ; 8546: a9 0f
                sta arr79                    ; 8548: 85 bc
                sta arr80                    ; 854a: 85 bd
                sta ram111                   ; 854c: 85 be
                lda #$30                     ; 854e: a9 30
                sta arr88                    ; 8550: 85 cf
                sta arr89                    ; 8552: 85 d0
                sta ram121                   ; 8554: 85 d1
                lda #2                       ; 8556: a9 02
                sta arr90                    ; 8558: 85 d2
                sta ram122                   ; 855a: 85 d3
                sta arr91                    ; 855c: 85 d4
                jsr sub28                    ; 855e: 20 3b 87
                sta arr36                    ; 8561: 85 4c
                sta ram43                    ; 8563: 85 57
                sta arr70                    ; 8565: 85 97
                lda #$ff                     ; 8567: a9 ff
                sta ram1                     ; 8569: 85 03
                lda #3                       ; 856b: a9 03
                sta arr45                    ; 856d: 85 56
                lda #$77                     ; 856f: a9 77
                sta ram2                     ; 8571: 85 04
                jsr sub170                   ; 8573: 20 df a6
                jsr sub176                   ; 8576: 20 6e a9
                jmp $aa82                    ; 8579: 4c 82 aa
                jsr sub95                    ; 857c: 20 28 92
                jsr sub28                    ; 857f: 20 3b 87
                jsr sub176                   ; 8582: 20 6e a9
                jsr sub170                   ; 8585: 20 df a6
                jsr sub13                    ; 8588: 20 78 83
                bne +                        ; 858b: d0 12
                ldx #0                       ; 858d: a2 00
                txs                          ; 858f: 9a
                lda #$ff                     ; 8590: a9 ff
                pha                          ; 8592: 48
                pha                          ; 8593: 48
                lda arr4                     ; 8594: a5 05
                sta ram4                     ; 8596: 85 09
                lda arr5                     ; 8598: a5 06
                sta ram5                     ; 859a: 85 0a
                jmp cod23                    ; 859c: 4c 4d 83
+               jmp cod130                   ; 859f: 4c 46 91
sub21           jsr sub64                    ; 85a2: 20 d4 8c
                cmp #$f6                     ; 85a5: c9 f6
                bne cod30                    ; 85a7: d0 03
                jmp sub60                    ; 85a9: 4c a1 8c
cod30           jmp cod24                    ; 85ac: 4c 6d 83
                php                          ; 85af: 08
                ldx #0                       ; 85b0: a2 00
                stx ram72                    ; 85b2: 86 86
                stx ram73                    ; 85b4: 86 87
                dex                          ; 85b6: ca
                stx ram74                    ; 85b7: 86 88
                stx ram75                    ; 85b9: 86 89
                plp                          ; 85bb: 28
                beq cod31                    ; 85bc: f0 46
                cmp #$2c                     ; 85be: c9 2c
                beq +                        ; 85c0: f0 23
                cmp #$2d                     ; 85c2: c9 2d
                beq +                        ; 85c4: f0 1f
                cmp #$0b                     ; 85c6: c9 0b
                bne cod30                    ; 85c8: d0 e2
                jsr sub61                    ; 85ca: 20 ad 8c
                sta ram72                    ; 85cd: 85 86
                sta ram74                    ; 85cf: 85 88
                jsr sub61                    ; 85d1: 20 ad 8c
                sta ram73                    ; 85d4: 85 87
                sta ram75                    ; 85d6: 85 89
                jsr sub12                    ; 85d8: 20 75 83
                beq cod31                    ; 85db: f0 27
                cmp #$2c                     ; 85dd: c9 2c
                beq +                        ; 85df: f0 04
                cmp #$2d                     ; 85e1: c9 2d
                bne cod30                    ; 85e3: d0 c7
+               jsr sub12                    ; 85e5: 20 75 83
                beq +                        ; 85e8: f0 14
                cmp #$0b                     ; 85ea: c9 0b
                bne cod30                    ; 85ec: d0 be
                jsr sub61                    ; 85ee: 20 ad 8c
                sta ram74                    ; 85f1: 85 88
                jsr sub61                    ; 85f3: 20 ad 8c
                sta ram75                    ; 85f6: 85 89
                jsr sub60                    ; 85f8: 20 a1 8c
                jmp cod31                    ; 85fb: 4c 04 86
+               lda #$ff                     ; 85fe: a9 ff
                sta ram74                    ; 8600: 85 88
                sta ram75                    ; 8602: 85 89
cod31           jsr sub89                    ; 8604: 20 f8 8f
                lda ram72                    ; 8607: a5 86
                sta arr31                    ; 8609: 85 44
                lda ram73                    ; 860b: a5 87
                sta arr32                    ; 860d: 85 45
                jsr sub16                    ; 860f: 20 04 84
                ldy #0                       ; 8612: a0 00
                lda (ram46),y                ; 8614: b1 5b
                beq cod33                    ; 8616: f0 44
                lda ram46                    ; 8618: a5 5b
                sta ram4                     ; 861a: 85 09
                lda ram47                    ; 861c: a5 5c
                sta ram5                     ; 861e: 85 0a
cod32           ldy #0                       ; 8620: a0 00
                lda (ram4),y                 ; 8622: b1 09
                beq cod33                    ; 8624: f0 36
                iny                          ; 8626: c8
                lda (ram4),y                 ; 8627: b1 09
                sta ram24                    ; 8629: 85 28
                iny                          ; 862b: c8
                lda (ram4),y                 ; 862c: b1 09
                sta ram25                    ; 862e: 85 29
                lda ram74                    ; 8630: a5 88
                sta arr18                    ; 8632: 85 2c
                lda ram75                    ; 8634: a5 89
                sta arr19                    ; 8636: 85 2d
                jsr sub56                    ; 8638: 20 f7 8b
                beq +                        ; 863b: f0 02
                bcs cod33                    ; 863d: b0 1d
+               jsr sub25                    ; 863f: 20 6d 86
                jsr sub22                    ; 8642: 20 56 86
                beq cod32                    ; 8645: f0 d9
                cmp #$1b                     ; 8647: c9 1b
                bne cod32                    ; 8649: d0 d5
-               jsr sub22                    ; 864b: 20 56 86
                beq -                        ; 864e: f0 fb
                cmp #$1b                     ; 8650: c9 1b
                beq -                        ; 8652: f0 f7
                bne cod32                    ; 8654: d0 ca
sub22           jsr sub27                    ; 8656: 20 d4 86
                jmp sub206                   ; 8659: 4c 88 af
cod33           jmp sub90                    ; 865c: 4c 01 90
sub23           lda #$3d                     ; 865f: a9 3d
dat4            clc                          ; 8661: 18
sub24           adc arr33                    ; 8662: 65 46
                sta arr41                    ; 8664: 85 52
                lda #0                       ; 8666: a9 00
                sta arr42                    ; 8668: 85 53
                jmp sub29                    ; 866a: 4c b7 87
sub25           lda #0                       ; 866d: a9 00
                sta arr48                    ; 866f: 85 62
                ldy #1                       ; 8671: a0 01
                lda (ram4),y                 ; 8673: b1 09
                sta ram24                    ; 8675: 85 28
                iny                          ; 8677: c8
                lda (ram4),y                 ; 8678: b1 09
                sta ram25                    ; 867a: 85 29
                jsr sub69                    ; 867c: 20 3c 8d
                jsr sub66                    ; 867f: 20 eb 8c
                jsr sub23                    ; 8682: 20 5f 86
                lda #$20                     ; 8685: a9 20
                jsr sub31                    ; 8687: 20 f0 87
                lda #3                       ; 868a: a9 03
                clc                          ; 868c: 18
                adc ram4                     ; 868d: 65 09
                sta ram42                    ; 868f: 85 4d
                lda #0                       ; 8691: a9 00
                adc ram5                     ; 8693: 65 0a
                sta arr37                    ; 8695: 85 4e
                jsr sub91                    ; 8697: 20 0a 90
                jsr sub37                    ; 869a: 20 3b 8a
                jsr sub32                    ; 869d: 20 f8 87
                lda ram42                    ; 86a0: a5 4d
                sta ram4                     ; 86a2: 85 09
                lda arr37                    ; 86a4: a5 4e
                sta ram5                     ; 86a6: 85 0a
                jsr sub194                   ; 86a8: 20 07 ac
                lda #1                       ; 86ab: a9 01
                clc                          ; 86ad: 18
                adc ram42                    ; 86ae: 65 4d
                sta ram4                     ; 86b0: 85 09
                lda #0                       ; 86b2: a9 00
                adc arr37                    ; 86b4: 65 4e
                sta ram5                     ; 86b6: 85 0a
                rts                          ; 86b8: 60
sub26           lda #5                       ; 86b9: a9 05
                sta joypad1                  ; 86bb: 8d 16 40
                pha                          ; 86be: 48
                pla                          ; 86bf: 68
                pha                          ; 86c0: 48
                pla                          ; 86c1: 68
                pha                          ; 86c2: 48
                pla                          ; 86c3: 68
                lda #4                       ; 86c4: a9 04
                sta joypad1                  ; 86c6: 8d 16 40
                lda #6                       ; 86c9: a9 06
                sta joypad1                  ; 86cb: 8d 16 40
                lda joypad2                  ; 86ce: ad 17 40
                and #%00010000               ; 86d1: 29 10
                rts                          ; 86d3: 60
sub27           jsr sub26                    ; 86d4: 20 b9 86
                beq cod34                    ; 86d7: f0 03
                rts                          ; 86d9: 60
                pla                          ; 86da: 68
                pla                          ; 86db: 68
cod34           lda #0                       ; 86dc: a9 00
                sta ram52                    ; 86de: 85 63
                jsr sub206                   ; 86e0: 20 88 af
                bne cod34                    ; 86e3: d0 f7
                jsr sub220                   ; 86e5: 20 f1 b3
                lda ram6                     ; 86e8: a5 0b
                sta ram9                     ; 86ea: 85 11
                lda arr7                     ; 86ec: a5 0c
                sta ram10                    ; 86ee: 85 12
                lda arr8                     ; 86f0: a5 0d
                sta ram11                    ; 86f2: 85 13
                lda ram7                     ; 86f4: a5 0e
                sta arr10                    ; 86f6: 85 14
                lda arr46                    ; 86f8: a5 58
                sta ram12                    ; 86fa: 85 15
                lda ram44                    ; 86fc: a5 59
                sta arr11                    ; 86fe: 85 16
                lda #$ff                     ; 8700: a9 ff
                sta ram21                    ; 8702: 85 24
                cmp ram6                     ; 8704: c5 0b
                bne +                        ; 8706: d0 07
                cmp arr7                     ; 8708: c5 0c
                bne +                        ; 870a: d0 03
                jsr sub28                    ; 870c: 20 3b 87
+               jmp cod290                   ; 870f: 4c ea a9
-               lda #$0e                     ; 8712: a9 0e
                jmp cod287                   ; 8714: 4c 8f a9
                lda ram21                    ; 8717: a5 24
                beq -                        ; 8719: f0 f7
                lda ram12                    ; 871b: a5 15
                sta ram4                     ; 871d: 85 09
                lda arr11                    ; 871f: a5 16
                sta ram5                     ; 8721: 85 0a
-               jsr sub112                   ; 8723: 20 08 99
                jsr sub13                    ; 8726: 20 78 83
                bne -                        ; 8729: d0 f8
                lda ram11                    ; 872b: a5 13
                sta arr8                     ; 872d: 85 0d
                lda arr10                    ; 872f: a5 14
                sta ram7                     ; 8731: 85 0e
                lda ram9                     ; 8733: a5 11
                sta ram6                     ; 8735: 85 0b
                lda ram10                    ; 8737: a5 12
                sta arr7                     ; 8739: 85 0c
sub28           lda #0                       ; 873b: a9 00
                sta ram21                    ; 873d: 85 24
                rts                          ; 873f: 60
cod35           beq cod43                    ; 8740: f0 72
                jsr sub122                   ; 8742: 20 82 9c
                lda ram23                    ; 8745: a5 27
                cmp #3                       ; 8747: c9 03
                beq cod37                    ; 8749: f0 16
                lda arr144                   ; 874b: ad 00 04
                sta ram24                    ; 874e: 85 28
                lda arr145                   ; 8750: ad 01 04
                sta ram25                    ; 8753: 85 29
                jsr sub73                    ; 8755: 20 96 8d
                jsr sub23                    ; 8758: 20 5f 86
cod36           jsr sub33                    ; 875b: 20 fb 87
                jmp cod39                    ; 875e: 4c 94 87
cod37           lda arr144                   ; 8761: ad 00 04
                beq cod39                    ; 8764: f0 2e
                ldy #0                       ; 8766: a0 00
                lda arr145                   ; 8768: ad 01 04
                sta ram14                    ; 876b: 85 19
                lda arr146                   ; 876d: ad 02 04
                sta ram15                    ; 8770: 85 1a
cod38           lda (ram14),y                ; 8772: b1 19
dat5            cmp #$20                     ; 8774: c9 20
                bcs +                        ; 8776: b0 02
                lda #0                       ; 8778: a9 00
+               sta arr160,y                 ; 877a: 99 00 05
                iny                          ; 877d: c8
                dec arr144                   ; 877e: ce 00 04
                bne cod38                    ; 8781: d0 ef
                lda #0                       ; 8783: a9 00
                sta arr160,y                 ; 8785: 99 00 05
                jsr sub37                    ; 8788: 20 3b 8a
                jsr sub29                    ; 878b: 20 b7 87
                jmp cod36                    ; 878e: 4c 5b 87
                jsr sub60                    ; 8791: 20 a1 8c
cod39           jsr sub13                    ; 8794: 20 78 83
                beq cod43                    ; 8797: f0 1b
                cmp #$3b                     ; 8799: c9 3b
                beq cod40                    ; 879b: f0 09
                cmp #$2c                     ; 879d: c9 2c
                bne cod41                    ; 879f: d0 0d
                lda #9                       ; 87a1: a9 09
                jsr sub195                   ; 87a3: 20 0d ac
cod40           jsr sub12                    ; 87a6: 20 75 83
                beq cod42                    ; 87a9: f0 08
                jmp cod39                    ; 87ab: 4c 94 87
cod41           jsr sub13                    ; 87ae: 20 78 83
                bne cod35                    ; 87b1: d0 8d
cod42           rts                          ; 87b3: 60
cod43           jmp sub194                   ; 87b4: 4c 07 ac
sub29           ldy #0                       ; 87b7: a0 00
                ldx arr48                    ; 87b9: a6 62
cod44           lda (arr41),y                ; 87bb: b1 52
                beq cod45                    ; 87bd: f0 10
                cmp #$20                     ; 87bf: c9 20
                bcc cod46                    ; 87c1: 90 0f
                sta arr191,x                 ; 87c3: 9d 00 07
                iny                          ; 87c6: c8
                inx                          ; 87c7: e8
                beq +                        ; 87c8: f0 03
                jmp cod44                    ; 87ca: 4c bb 87
+               dex                          ; 87cd: ca
                dex                          ; 87ce: ca
cod45           stx arr48                    ; 87cf: 86 62
                rts                          ; 87d1: 60
cod46           pha                          ; 87d2: 48
cod47           sty ram39                    ; 87d3: 84 47
                cpx #0                       ; 87d5: e0 00
                beq cod49                    ; 87d7: f0 05
                stx arr48                    ; 87d9: 86 62
cod48           jsr sub33                    ; 87db: 20 fb 87
cod49           pla                          ; 87de: 68
                jsr sub195                   ; 87df: 20 0d ac
                lda #0                       ; 87e2: a9 00
                sta arr48                    ; 87e4: 85 62
                ldy ram39                    ; 87e6: a4 47
                iny                          ; 87e8: c8
                ldx arr48                    ; 87e9: a6 62
                jmp cod44                    ; 87eb: 4c bb 87
sub30           lda #0                       ; 87ee: a9 00
sub31           ldx arr48                    ; 87f0: a6 62
                sta arr191,x                 ; 87f2: 9d 00 07
                inc arr48                    ; 87f5: e6 62
dat6            rts                          ; 87f7: 60
sub32           jsr sub29                    ; 87f8: 20 b7 87
sub33           jsr sub30                    ; 87fb: 20 ee 87
                lda arr48                    ; 87fe: a5 62
                beq cod50                    ; 8800: f0 0c
                lda #1                       ; 8802: a9 01
                ldx #0                       ; 8804: a2 00
                stx arr49                    ; 8806: 86 64
sub34           sta ram52                    ; 8808: 85 63
-               lda ram52                    ; 880a: a5 63
                bne -                        ; 880c: d0 fc
cod50           rts                          ; 880e: 60
                pha                          ; 880f: 48
                lda #0                       ; 8810: a9 00
                sta oam_addr                 ; 8812: 8d 03 20
                lda #2                       ; 8815: a9 02
                sta oam_dma                  ; 8817: 8d 14 40
                lda arr75                    ; 881a: a5 ab
                bne cod51                    ; 881c: d0 0e
                lda ram98                    ; 881e: a5 ac
                beq +                        ; 8820: f0 04
                lda #$ff                     ; 8822: a9 ff
                sta arr75                    ; 8824: 85 ab
+               lda ram52                    ; 8826: a5 63
                bne cod52                    ; 8828: d0 05
                pla                          ; 882a: 68
                rti                          ; 882b: 40
cod51           jmp cod389                   ; 882c: 4c 33 be
cod52           tax                          ; 882f: aa
                dex                          ; 8830: ca
                txa                          ; 8831: 8a
                asl a                        ; 8832: 0a
                tax                          ; 8833: aa
                lda dat7,x                   ; 8834: bd 41 88
                sta ram16                    ; 8837: 85 1b
                lda dat8,x                   ; 8839: bd 42 88
                sta ram17                    ; 883c: 85 1c
                jmp (ram16)                  ; 883e: 6c 1b 00
dat7            tax                          ; 8841: aa
dat8            dey                          ; 8842: 88
                and ram75                    ; 8843: 25 89
                adc (ram75,x)                ; 8845: 61 89
                tya                          ; 8847: 98
                dey                          ; 8848: 88
                bvs cod47                    ; 8849: 70 88
                bcc $87d6                    ; 884b: 90 89
                ldx $8289,y                  ; 884d: be 89 82
                dey                          ; 8850: 88
                bcc cod48                    ; 8851: 90 88
                bcc $87ef                    ; 8853: 90 9a

                hex 62                       ; 8855

                dey                          ; 8856: 88

                hex 5f                       ; 8857

                dey                          ; 8858: 88
                cpy arr122                   ; 8859: cc 89 02
                txa                          ; 885c: 8a

                hex 1a                       ; 885d

                txa                          ; 885e: 8a
                lda #0                       ; 885f: a9 00
dat9            ldx misc51                   ; 8861: ae a5 33
                sta ppu_mask                 ; 8864: 8d 01 20
cod53           lda #0                       ; 8867: a9 00
                sta ram52                    ; 8869: 85 63
                jsr sub190                   ; 886b: 20 e6 ab
                pla                          ; 886e: 68
                rti                          ; 886f: 40
                jsr sub35                    ; 8870: 20 76 88
                jmp cod53                    ; 8873: 4c 67 88
sub35           jsr sub188                   ; 8876: 20 d8 ab
                lda ppu_data                 ; 8879: ad 07 20
                lda ppu_data                 ; 887c: ad 07 20
                sta arr56                    ; 887f: 85 73
                rts                          ; 8881: 60
                jsr sub35                    ; 8882: 20 76 88
                jsr sub188                   ; 8885: 20 d8 ab
                lda ram51                    ; 8888: a5 61
-               sta ppu_data                 ; 888a: 8d 07 20
                jmp cod53                    ; 888d: 4c 67 88
                jsr sub188                   ; 8890: 20 d8 ab
                lda arr56                    ; 8893: a5 73
                jmp -                        ; 8895: 4c 8a 88
                jsr sub188                   ; 8898: 20 d8 ab
                ldx arr34                    ; 889b: a6 48
                lda #$20                     ; 889d: a9 20
-               sta ppu_data                 ; 889f: 8d 07 20
                inx                          ; 88a2: e8
                cpx #$1c                     ; 88a3: e0 1c
                bne -                        ; 88a5: d0 f8
                jmp cod56                    ; 88a7: 4c 58 89
                jsr sub187                   ; 88aa: 20 a6 ab
                ldx arr49                    ; 88ad: a6 64
                jsr sub188                   ; 88af: 20 d8 ab
-               lda arr191,x                 ; 88b2: bd 00 07
                beq cod55                    ; 88b5: f0 66
                sta ppu_data                 ; 88b7: 8d 07 20
                inc arr34                    ; 88ba: e6 48
                lda #$1c                     ; 88bc: a9 1c
                cmp arr34                    ; 88be: c5 48
                beq cod54                    ; 88c0: f0 0f
                lda #$0e                     ; 88c2: a9 0e
                cmp arr34                    ; 88c4: c5 48
                beq +                        ; 88c6: f0 03
                inx                          ; 88c8: e8
                bne -                        ; 88c9: d0 e7
+               inx                          ; 88cb: e8
                stx arr49                    ; 88cc: 86 64
                jmp cod58                    ; 88ce: 4c 5c 89
cod54           lda #0                       ; 88d1: a9 00
                sta arr34                    ; 88d3: 85 48
                txa                          ; 88d5: 8a
                pha                          ; 88d6: 48
                ldx arr35                    ; 88d7: a6 49
                lda #$ff                     ; 88d9: a9 ff
                sta arr169,x                 ; 88db: 9d 01 06
                pla                          ; 88de: 68
                tax                          ; 88df: aa
                inc arr35                    ; 88e0: e6 49
                lda #$18                     ; 88e2: a9 18
                cmp arr35                    ; 88e4: c5 49
                beq +                        ; 88e6: f0 06
                inx                          ; 88e8: e8
                stx arr49                    ; 88e9: 86 64
                jmp cod58                    ; 88eb: 4c 5c 89
+               inx                          ; 88ee: e8
                stx arr49                    ; 88ef: 86 64
                jsr sub200                   ; 88f1: 20 8b ad
                jsr sub190                   ; 88f4: 20 e6 ab
                lda arr21                    ; 88f7: a5 32
                sta ppu_ctrl                 ; 88f9: 8d 00 20
                jsr sub187                   ; 88fc: 20 a6 ab
                jsr sub182                   ; 88ff: 20 fe aa
                jsr sub188                   ; 8902: 20 d8 ab
                ldx #$1c                     ; 8905: a2 1c
                lda #$20                     ; 8907: a9 20
-               sta ppu_data                 ; 8909: 8d 07 20
                dex                          ; 890c: ca
                bne -                        ; 890d: d0 fa
                stx ram52                    ; 890f: 86 63
                jsr sub190                   ; 8911: 20 e6 ab
                jsr sub197                   ; 8914: 20 6a ac
                lda #1                       ; 8917: a9 01
                sta ram52                    ; 8919: 85 63
                pla                          ; 891b: 68
                rti                          ; 891c: 40
cod55           sta ram52                    ; 891d: 85 63
                sta arr48                    ; 891f: 85 62
                sta arr49                    ; 8921: 85 64
                beq cod58                    ; 8923: f0 37
                lda #0                       ; 8925: a9 00
                sta arr34                    ; 8927: 85 48
                jsr sub187                   ; 8929: 20 a6 ab
                jsr sub188                   ; 892c: 20 d8 ab
                ldy #$1c                     ; 892f: a0 1c
                lda ppu_data                 ; 8931: ad 07 20
                ldx arr58                    ; 8934: a6 76
-               lda ppu_data                 ; 8936: ad 07 20
                sta arr160,x                 ; 8939: 9d 00 05
                inx                          ; 893c: e8
                cpx #$ff                     ; 893d: e0 ff
                beq +                        ; 893f: f0 10
                dey                          ; 8941: 88
                bne -                        ; 8942: d0 f2
                stx arr58                    ; 8944: 86 76
                ldx arr35                    ; 8946: a6 49
                lda arr169,x                 ; 8948: bd 01 06
                beq +                        ; 894b: f0 04
                inc arr35                    ; 894d: e6 49
                bne cod58                    ; 894f: d0 0b
+               lda #$ff                     ; 8951: a9 ff
                ldx_abs ram97                ; 8953: ae a9 00
                sta arr49                    ; 8956: 85 64
cod56           lda #0                       ; 8958: a9 00
cod57           sta ram52                    ; 895a: 85 63
cod58           jsr sub190                   ; 895c: 20 e6 ab
                pla                          ; 895f: 68
                rti                          ; 8960: 40
                jsr sub188                   ; 8961: 20 d8 ab
                lda ppu_data                 ; 8964: ad 07 20
                ldx #0                       ; 8967: a2 00
                ldy arr34                    ; 8969: a4 48
-               lda ppu_data                 ; 896b: ad 07 20
                sta arr160,x                 ; 896e: 9d 00 05
                inx                          ; 8971: e8
                iny                          ; 8972: c8
                cpy #$1c                     ; 8973: c0 1c
                bne -                        ; 8975: d0 f4
                lda ram15                    ; 8977: a5 1a
                ldx ram14                    ; 8979: a6 19
                jsr sub9                     ; 897b: 20 f8 81
                ldx #0                       ; 897e: a2 00
                ldy arr34                    ; 8980: a4 48
-               lda arr160,x                 ; 8982: bd 00 05
                sta ppu_data                 ; 8985: 8d 07 20
                inx                          ; 8988: e8
                iny                          ; 8989: c8
                cpy #$1c                     ; 898a: c0 1c
                bne -                        ; 898c: d0 f4
                beq cod56                    ; 898e: f0 c8
                lda #$3f                     ; 8990: a9 3f
                sta ppu_addr                 ; 8992: 8d 06 20
                lda arr191                   ; 8995: ad 00 07
                asl a                        ; 8998: 0a
                asl a                        ; 8999: 0a
-               sta ppu_addr                 ; 899a: 8d 06 20
                lda ram212                   ; 899d: ad 01 07
                sta ppu_data                 ; 89a0: 8d 07 20
                lda ram213                   ; 89a3: ad 02 07
                sta ppu_data                 ; 89a6: 8d 07 20
                lda ram214                   ; 89a9: ad 03 07
                sta ppu_data                 ; 89ac: 8d 07 20
                lda ram215                   ; 89af: ad 04 07
                sta ppu_data                 ; 89b2: 8d 07 20
                jsr sub190                   ; 89b5: 20 e6 ab
                jsr sub220                   ; 89b8: 20 f1 b3
                jmp cod53                    ; 89bb: 4c 67 88
                lda #$3f                     ; 89be: a9 3f
                sta ppu_addr                 ; 89c0: 8d 06 20
                lda arr191                   ; 89c3: ad 00 07
                asl a                        ; 89c6: 0a
                asl a                        ; 89c7: 0a
                ora #%00010000               ; 89c8: 09 10
                bne -                        ; 89ca: d0 ce
                jsr sub188                   ; 89cc: 20 d8 ab
                ldy arr34                    ; 89cf: a4 48
                ldx #1                       ; 89d1: a2 01
                lda arr77                    ; 89d3: a5 b0
                sta arr160                   ; 89d5: 8d 00 05
                lda ppu_data                 ; 89d8: ad 07 20
-               lda ppu_data                 ; 89db: ad 07 20
                sta arr160,x                 ; 89de: 9d 00 05
                inx                          ; 89e1: e8
                iny                          ; 89e2: c8
                cpy #$1c                     ; 89e3: c0 1c
                bne -                        ; 89e5: d0 f4
                sta arr77                    ; 89e7: 85 b0
                jsr sub188                   ; 89e9: 20 d8 ab
                ldx #0                       ; 89ec: a2 00
                ldy arr34                    ; 89ee: a4 48
-               lda arr160,x                 ; 89f0: bd 00 05
                sta ppu_data                 ; 89f3: 8d 07 20
                inx                          ; 89f6: e8
                iny                          ; 89f7: c8
                cpy #$1c                     ; 89f8: c0 1c
                bne -                        ; 89fa: d0 f4
cod59           jsr sub190                   ; 89fc: 20 e6 ab
                jmp cod53                    ; 89ff: 4c 67 88
                jsr sub188                   ; 8a02: 20 d8 ab
                ldx #0                       ; 8a05: a2 00
                lda ppu_data                 ; 8a07: ad 07 20
-               lda ppu_data                 ; 8a0a: ad 07 20
                sta arr160,x                 ; 8a0d: 9d 00 05
                inx                          ; 8a10: e8
                cpx #$1c                     ; 8a11: e0 1c
                bne -                        ; 8a13: d0 f5
                lda #$0f                     ; 8a15: a9 0f
                jmp cod57                    ; 8a17: 4c 5a 89
                inc arr35                    ; 8a1a: e6 49
                jsr sub187                   ; 8a1c: 20 a6 ab
                jsr sub188                   ; 8a1f: 20 d8 ab
                ldx #0                       ; 8a22: a2 00
-               lda arr160,x                 ; 8a24: bd 00 05
                sta ppu_data                 ; 8a27: 8d 07 20
                inx                          ; 8a2a: e8
                cpx #$1c                     ; 8a2b: e0 1c
                bne -                        ; 8a2d: d0 f5
                jmp cod59                    ; 8a2f: 4c fc 89
sub36           lda #0                       ; 8a32: a9 00
                sta ram4                     ; 8a34: 85 09
                lda #5                       ; 8a36: a9 05
                sta ram5                     ; 8a38: 85 0a
                rts                          ; 8a3a: 60
sub37           lda #0                       ; 8a3b: a9 00
                sta arr41                    ; 8a3d: 85 52
                lda #5                       ; 8a3f: a9 05
                sta arr42                    ; 8a41: 85 53
cod60           rts                          ; 8a43: 60
sub38           lda ram1                     ; 8a44: a5 03
                sec                          ; 8a46: 38
                sbc #4                       ; 8a47: e9 04
                sta arr18                    ; 8a49: 85 2c
                lda ram2                     ; 8a4b: a5 04
                sbc #0                       ; 8a4d: e9 00
                sta arr19                    ; 8a4f: 85 2d
                jsr sub56                    ; 8a51: 20 f7 8b
                bcc cod60                    ; 8a54: 90 ed
cod61           lda #6                       ; 8a56: a9 06
                jmp cod287                   ; 8a58: 4c 8f a9
sub39           tsx                          ; 8a5b: ba
                cpx #$14                     ; 8a5c: e0 14
                bcc cod61                    ; 8a5e: 90 f6
                rts                          ; 8a60: 60
sub40           sec                          ; 8a61: 38
                lda #0                       ; 8a62: a9 00
                sbc arr18                    ; 8a64: e5 2c
                sta arr18                    ; 8a66: 85 2c
                lda #0                       ; 8a68: a9 00
                sbc arr19                    ; 8a6a: e5 2d
                sta arr19                    ; 8a6c: 85 2d
                rts                          ; 8a6e: 60
sub41           lda #2                       ; 8a6f: a9 02
                sta ram23                    ; 8a71: 85 27
sub42           jsr sub158                   ; 8a73: 20 ef a3
                jsr sub43                    ; 8a76: 20 7c 8a
                jsr sub45                    ; 8a79: 20 ec 8a
sub43           sec                          ; 8a7c: 38
                lda #0                       ; 8a7d: a9 00
                sbc ram24                    ; 8a7f: e5 28
                sta ram24                    ; 8a81: 85 28
                lda #0                       ; 8a83: a9 00
                sbc ram25                    ; 8a85: e5 29
                sta ram25                    ; 8a87: 85 29
                rts                          ; 8a89: 60
cod62           jmp cod68                    ; 8a8a: 4c 34 8b
cod63           lda arr18                    ; 8a8d: a5 2c
                sta ram24                    ; 8a8f: 85 28
                lda arr19                    ; 8a91: a5 2d
                sta ram25                    ; 8a93: 85 29
                lda ram28                    ; 8a95: a5 2e
                sta ram26                    ; 8a97: 85 2a
cod64           rts                          ; 8a99: 60
cod65           ldx arr15                    ; 8a9a: a6 21
                stx ram40                    ; 8a9c: 86 4a
                lda ram24                    ; 8a9e: a5 28
                beq cod63                    ; 8aa0: f0 eb
                clc                          ; 8aa2: 18
                ldy arr18                    ; 8aa3: a4 2c
                beq cod64                    ; 8aa5: f0 f2
                adc arr18                    ; 8aa7: 65 2c
                cmp #$20                     ; 8aa9: c9 20
                bcs cod62                    ; 8aab: b0 dd
                sta ram41                    ; 8aad: 85 4b
                lda ram25                    ; 8aaf: a5 29
                sta ram14                    ; 8ab1: 85 19
                lda ram26                    ; 8ab3: a5 2a
                sta ram15                    ; 8ab5: 85 1a
                ldy #0                       ; 8ab7: a0 00
-               lda (ram14),y                ; 8ab9: b1 19
                sta arr191,x                 ; 8abb: 9d 00 07
                inx                          ; 8abe: e8
                iny                          ; 8abf: c8
                dec ram24                    ; 8ac0: c6 28
                bne -                        ; 8ac2: d0 f5
                lda arr19                    ; 8ac4: a5 2d
                sta ram14                    ; 8ac6: 85 19
                lda ram28                    ; 8ac8: a5 2e
                sta ram15                    ; 8aca: 85 1a
                ldy #0                       ; 8acc: a0 00
-               lda (ram14),y                ; 8ace: b1 19
                sta arr191,x                 ; 8ad0: 9d 00 07
                iny                          ; 8ad3: c8
                inx                          ; 8ad4: e8
                dec arr18                    ; 8ad5: c6 2c
                bne -                        ; 8ad7: d0 f5
                stx arr15                    ; 8ad9: 86 21
                lda ram41                    ; 8adb: a5 4b
                sta ram24                    ; 8add: 85 28
                lda ram40                    ; 8adf: a5 4a
                sta ram25                    ; 8ae1: 85 29
                lda #7                       ; 8ae3: a9 07
                sta ram26                    ; 8ae5: 85 2a
                rts                          ; 8ae7: 60
sub44           lda #2                       ; 8ae8: a9 02
                sta ram23                    ; 8aea: 85 27
sub45           lda ram23                    ; 8aec: a5 27
                cmp #3                       ; 8aee: c9 03
                beq cod65                    ; 8af0: f0 a8
                lda ram25                    ; 8af2: a5 29
                bmi cod67                    ; 8af4: 30 25
                lda arr19                    ; 8af6: a5 2d
                bmi cod66                    ; 8af8: 30 10
sub46           clc                          ; 8afa: 18
                lda arr18                    ; 8afb: a5 2c
                adc ram24                    ; 8afd: 65 28
                sta ram24                    ; 8aff: 85 28
                lda arr19                    ; 8b01: a5 2d
                adc ram25                    ; 8b03: 65 29
                sta ram25                    ; 8b05: 85 29
                bmi cod68                    ; 8b07: 30 2b
                rts                          ; 8b09: 60
cod66           jsr sub40                    ; 8b0a: 20 61 8a
sub47           sec                          ; 8b0d: 38
                lda ram24                    ; 8b0e: a5 28
                sbc arr18                    ; 8b10: e5 2c
                sta ram24                    ; 8b12: 85 28
                lda ram25                    ; 8b14: a5 29
                sbc arr19                    ; 8b16: e5 2d
                sta ram25                    ; 8b18: 85 29
                rts                          ; 8b1a: 60
cod67           lda arr19                    ; 8b1b: a5 2d
                bmi +                        ; 8b1d: 30 09
                jsr sub43                    ; 8b1f: 20 7c 8a
                jsr sub47                    ; 8b22: 20 0d 8b
                jmp sub43                    ; 8b25: 4c 7c 8a
+               jsr sub43                    ; 8b28: 20 7c 8a
                jsr sub40                    ; 8b2b: 20 61 8a
                jsr sub46                    ; 8b2e: 20 fa 8a
                jmp sub43                    ; 8b31: 4c 7c 8a
cod68           lda #5                       ; 8b34: a9 05
                jmp cod287                   ; 8b36: 4c 8f a9
sub48           clc                          ; 8b39: 18
                lda arr18                    ; 8b3a: a5 2c
                adc ram24                    ; 8b3c: 65 28
                sta ram24                    ; 8b3e: 85 28
                lda arr19                    ; 8b40: a5 2d
                adc ram25                    ; 8b42: 65 29
                sta ram25                    ; 8b44: 85 29
                rts                          ; 8b46: 60
sub49           lda #0                       ; 8b47: a9 00
                ldx #8                       ; 8b49: a2 08
-               sta arr22,x                  ; 8b4b: 95 34
                dex                          ; 8b4d: ca
                bne -                        ; 8b4e: d0 fb
                rts                          ; 8b50: 60
sub50           jsr sub51                    ; 8b51: 20 59 8b
                lda ram33                    ; 8b54: a5 36
                bne cod68                    ; 8b56: d0 dc
                rts                          ; 8b58: 60
sub51           jsr sub158                   ; 8b59: 20 ef a3
sub52           jsr sub49                    ; 8b5c: 20 47 8b
                jsr sub53                    ; 8b5f: 20 92 8b
                pha                          ; 8b62: 48
                ldx #$10                     ; 8b63: a2 10
                clc                          ; 8b65: 18
-               ror ram25                    ; 8b66: 66 29
                ror ram24                    ; 8b68: 66 28
                bcc +                        ; 8b6a: 90 0d
                clc                          ; 8b6c: 18
                lda ram33                    ; 8b6d: a5 36
                adc arr18                    ; 8b6f: 65 2c
                sta ram33                    ; 8b71: 85 36
                lda arr23                    ; 8b73: a5 37
                adc arr19                    ; 8b75: 65 2d
                sta arr23                    ; 8b77: 85 37
+               ror arr23                    ; 8b79: 66 37
                ror ram33                    ; 8b7b: 66 36
                ror ram32                    ; 8b7d: 66 35
                ror arr22                    ; 8b7f: 66 34
                dex                          ; 8b81: ca
                bne -                        ; 8b82: d0 e2
                lda arr22                    ; 8b84: a5 34
                sta ram24                    ; 8b86: 85 28
                lda ram32                    ; 8b88: a5 35
                sta ram25                    ; 8b8a: 85 29
cod69           pla                          ; 8b8c: 68
                beq cod70                    ; 8b8d: f0 22
                jmp sub43                    ; 8b8f: 4c 7c 8a
sub53           lda #0                       ; 8b92: a9 00
                sta arr22                    ; 8b94: 85 34
                lda ram25                    ; 8b96: a5 29
                bpl +                        ; 8b98: 10 07
                jsr sub43                    ; 8b9a: 20 7c 8a
                lda #$ff                     ; 8b9d: a9 ff
                sta arr22                    ; 8b9f: 85 34
+               lda arr19                    ; 8ba1: a5 2d
                bpl +                        ; 8ba3: 10 0a
                jsr sub40                    ; 8ba5: 20 61 8a
                lda #$ff                     ; 8ba8: a9 ff
                sec                          ; 8baa: 38
                sbc arr22                    ; 8bab: e5 34
                sta arr22                    ; 8bad: 85 34
+               lda arr22                    ; 8baf: a5 34
cod70           rts                          ; 8bb1: 60
sub54           jsr sub158                   ; 8bb2: 20 ef a3
                jsr sub53                    ; 8bb5: 20 92 8b
                pha                          ; 8bb8: 48
                lda #0                       ; 8bb9: a9 00
                sta ram26                    ; 8bbb: 85 2a
                sta ram27                    ; 8bbd: 85 2b
                ldx #$10                     ; 8bbf: a2 10
-               asl ram24                    ; 8bc1: 06 28
                rol ram25                    ; 8bc3: 26 29
                rol ram26                    ; 8bc5: 26 2a
                rol ram27                    ; 8bc7: 26 2b
                lda ram26                    ; 8bc9: a5 2a
                sec                          ; 8bcb: 38
                sbc arr18                    ; 8bcc: e5 2c
                lda ram27                    ; 8bce: a5 2b
                sbc arr19                    ; 8bd0: e5 2d
                bcc +                        ; 8bd2: 90 0f
                lda ram26                    ; 8bd4: a5 2a
                sec                          ; 8bd6: 38
                sbc arr18                    ; 8bd7: e5 2c
                sta ram26                    ; 8bd9: 85 2a
                lda ram27                    ; 8bdb: a5 2b
                sbc arr19                    ; 8bdd: e5 2d
                sta ram27                    ; 8bdf: 85 2b
                inc ram24                    ; 8be1: e6 28
+               dex                          ; 8be3: ca
                bne -                        ; 8be4: d0 db
                jmp cod69                    ; 8be6: 4c 8c 8b
sub55           sec                          ; 8be9: 38
                lda ram24                    ; 8bea: a5 28
                sbc arr18                    ; 8bec: e5 2c
                sta ram24                    ; 8bee: 85 28
                lda ram25                    ; 8bf0: a5 29
                sbc arr19                    ; 8bf2: e5 2d
                sta ram25                    ; 8bf4: 85 29
                rts                          ; 8bf6: 60
sub56           lda ram25                    ; 8bf7: a5 29
                cmp arr19                    ; 8bf9: c5 2d
                beq +                        ; 8bfb: f0 01
                rts                          ; 8bfd: 60
+               lda ram24                    ; 8bfe: a5 28
                cmp arr18                    ; 8c00: c5 2c
                rts                          ; 8c02: 60
sub57           lda ram23                    ; 8c03: a5 27
                cmp #3                       ; 8c05: c9 03
                beq cod76                    ; 8c07: f0 41
                lda ram25                    ; 8c09: a5 29
                bmi cod75                    ; 8c0b: 30 23
                lda arr19                    ; 8c0d: a5 2d
                bmi cod72                    ; 8c0f: 30 0c
                lda ram25                    ; 8c11: a5 29
                cmp arr19                    ; 8c13: c5 2d
                beq cod73                    ; 8c15: f0 0a
                bcs cod72                    ; 8c17: b0 04
cod71           clc                          ; 8c19: 18
                lda #$ff                     ; 8c1a: a9 ff
                rts                          ; 8c1c: 60
cod72           sec                          ; 8c1d: 38
                lda #$ff                     ; 8c1e: a9 ff
                rts                          ; 8c20: 60
cod73           lda ram24                    ; 8c21: a5 28
                cmp arr18                    ; 8c23: c5 2c
                beq cod74                    ; 8c25: f0 05
                bcs cod72                    ; 8c27: b0 f4
                jmp cod71                    ; 8c29: 4c 19 8c
cod74           sec                          ; 8c2c: 38
                lda #0                       ; 8c2d: a9 00
                rts                          ; 8c2f: 60
cod75           lda arr19                    ; 8c30: a5 2d
                bpl cod71                    ; 8c32: 10 e5
                lda ram25                    ; 8c34: a5 29
                cmp arr19                    ; 8c36: c5 2d
                beq +                        ; 8c38: f0 05
                bcs cod72                    ; 8c3a: b0 e1
                jmp cod71                    ; 8c3c: 4c 19 8c
+               lda ram24                    ; 8c3f: a5 28
                cmp arr18                    ; 8c41: c5 2c
                beq cod74                    ; 8c43: f0 e7
                bcs cod72                    ; 8c45: b0 d6
                jmp cod71                    ; 8c47: 4c 19 8c
cod76           lda ram25                    ; 8c4a: a5 29
                sta ram14                    ; 8c4c: 85 19
                lda ram26                    ; 8c4e: a5 2a
                sta ram15                    ; 8c50: 85 1a
                lda arr19                    ; 8c52: a5 2d
                sta ram16                    ; 8c54: 85 1b
                lda ram28                    ; 8c56: a5 2e
                sta ram17                    ; 8c58: 85 1c
                lda ram24                    ; 8c5a: a5 28
                beq cod78                    ; 8c5c: f0 28
                sta ram40                    ; 8c5e: 85 4a
                beq cod72                    ; 8c60: f0 bb
                lda arr18                    ; 8c62: a5 2c
                sta ram41                    ; 8c64: 85 4b
                ldy #0                       ; 8c66: a0 00
cod77           lda (ram14),y                ; 8c68: b1 19
dat10           cmp (ram16),y                ; 8c6a: d1 1b
                bcc cod71                    ; 8c6c: 90 ab
                beq +                        ; 8c6e: f0 03
                jmp cod72                    ; 8c70: 4c 1d 8c
+               iny                          ; 8c73: c8
                dec ram40                    ; 8c74: c6 4a
                beq +                        ; 8c76: f0 07
                dec ram41                    ; 8c78: c6 4b
                beq cod72                    ; 8c7a: f0 a1
                jmp cod77                    ; 8c7c: 4c 68 8c
+               dec ram41                    ; 8c7f: c6 4b
                beq cod74                    ; 8c81: f0 a9
                jmp cod71                    ; 8c83: 4c 19 8c
cod78           lda arr18                    ; 8c86: a5 2c
                beq cod74                    ; 8c88: f0 a2
                jmp cod71                    ; 8c8a: 4c 19 8c
sub58           ldy #0                       ; 8c8d: a0 00
                sta (ram4),y                 ; 8c8f: 91 09
                inc ram4                     ; 8c91: e6 09
                beq +                        ; 8c93: f0 01
                rts                          ; 8c95: 60
+               dec ram4                     ; 8c96: c6 09
                lda #0                       ; 8c98: a9 00
                sta (ram4),y                 ; 8c9a: 91 09
                rts                          ; 8c9c: 60
sub59           ldy #0                       ; 8c9d: a0 00
                lda (ram4),y                 ; 8c9f: b1 09
sub60           inc ram4                     ; 8ca1: e6 09
                beq +                        ; 8ca3: f0 03
                and #%11111111               ; 8ca5: 29 ff
                rts                          ; 8ca7: 60
+               inc ram5                     ; 8ca8: e6 0a
                and #%11111111               ; 8caa: 29 ff
                rts                          ; 8cac: 60
sub61           ldy #0                       ; 8cad: a0 00
                inc ram4                     ; 8caf: e6 09
                beq +                        ; 8cb1: f0 03
                lda (ram4),y                 ; 8cb3: b1 09
                rts                          ; 8cb5: 60
+               inc ram5                     ; 8cb6: e6 0a
                lda (ram4),y                 ; 8cb8: b1 09
                rts                          ; 8cba: 60
sub62           lda ram4                     ; 8cbb: a5 09
                beq +                        ; 8cbd: f0 03
                dec ram4                     ; 8cbf: c6 09
                rts                          ; 8cc1: 60
+               dec ram4                     ; 8cc2: c6 09
                dec ram5                     ; 8cc4: c6 0a
                rts                          ; 8cc6: 60
sub63           ldy #0                       ; 8cc7: a0 00
                lda (ram4),y                 ; 8cc9: b1 09
                rts                          ; 8ccb: 60
                ldy #0                       ; 8ccc: a0 00
                sta (ram4),y                 ; 8cce: 91 09
                rts                          ; 8cd0: 60
cod79           jsr sub60                    ; 8cd1: 20 a1 8c
sub64           ldy #0                       ; 8cd4: a0 00
                lda (ram4),y                 ; 8cd6: b1 09
                cmp #$20                     ; 8cd8: c9 20
                beq cod79                    ; 8cda: f0 f5
                rts                          ; 8cdc: 60
sub65           cmp #$30                     ; 8cdd: c9 30
                bcc +                        ; 8cdf: 90 06
                cmp #$3a                     ; 8ce1: c9 3a
                bcs +                        ; 8ce3: b0 02
                clc                          ; 8ce5: 18
                rts                          ; 8ce6: 60
+               sec                          ; 8ce7: 38
cod80           rts                          ; 8ce8: 60
cod81           inc arr33                    ; 8ce9: e6 46
sub66           ldx arr33                    ; 8ceb: a6 46
                lda arr26,x                  ; 8ced: b5 3d
                beq +                        ; 8cef: f0 05
                cmp #$30                     ; 8cf1: c9 30
                beq cod81                    ; 8cf3: f0 f4
                rts                          ; 8cf5: 60
+               dec arr33                    ; 8cf6: c6 46
                rts                          ; 8cf8: 60
sub67           jsr sub64                    ; 8cf9: 20 d4 8c
                cmp #$2d                     ; 8cfc: c9 2d
                bne sub68                    ; 8cfe: d0 09
                jsr sub60                    ; 8d00: 20 a1 8c
                jsr sub67                    ; 8d03: 20 f9 8c
                jmp sub43                    ; 8d06: 4c 7c 8a
sub68           lda #2                       ; 8d09: a9 02
                sta ram23                    ; 8d0b: 85 27
                lda #0                       ; 8d0d: a9 00
                sta ram24                    ; 8d0f: 85 28
                sta ram25                    ; 8d11: 85 29
-               lda #$0a                     ; 8d13: a9 0a
                sta arr18                    ; 8d15: 85 2c
                lda #0                       ; 8d17: a9 00
                sta arr19                    ; 8d19: 85 2d
                ldy #0                       ; 8d1b: a0 00
                lda (ram4),y                 ; 8d1d: b1 09
                jsr sub65                    ; 8d1f: 20 dd 8c
                bcs cod80                    ; 8d22: b0 c4
                pha                          ; 8d24: 48
                jsr sub50                    ; 8d25: 20 51 8b
                pla                          ; 8d28: 68
                sec                          ; 8d29: 38
                sbc #$30                     ; 8d2a: e9 30
                sta arr18                    ; 8d2c: 85 2c
                jsr sub48                    ; 8d2e: 20 39 8b
                bcs +                        ; 8d31: b0 06
                jsr sub60                    ; 8d33: 20 a1 8c
                jmp -                        ; 8d36: 4c 13 8d
+               jmp cod68                    ; 8d39: 4c 34 8b
sub69           lda #0                       ; 8d3c: a9 00
                sta arr33                    ; 8d3e: 85 46
sub70           lda arr33                    ; 8d40: a5 46
                pha                          ; 8d42: 48
                lda #$10                     ; 8d43: a9 10
                sta arr18                    ; 8d45: 85 2c
                lda #$27                     ; 8d47: a9 27
                sta arr19                    ; 8d49: 85 2d
                jsr sub72                    ; 8d4b: 20 88 8d
                lda #$e8                     ; 8d4e: a9 e8
                sta arr18                    ; 8d50: 85 2c
                lda #3                       ; 8d52: a9 03
                sta arr19                    ; 8d54: 85 2d
                jsr sub72                    ; 8d56: 20 88 8d
                lda #$64                     ; 8d59: a9 64
                sta arr18                    ; 8d5b: 85 2c
                lda #0                       ; 8d5d: a9 00
                sta arr19                    ; 8d5f: 85 2d
                jsr sub72                    ; 8d61: 20 88 8d
                lda #$0a                     ; 8d64: a9 0a
dat11           sta arr18                    ; 8d66: 85 2c
                jsr sub72                    ; 8d68: 20 88 8d
                lda ram24                    ; 8d6b: a5 28
                clc                          ; 8d6d: 18
                adc #$30                     ; 8d6e: 69 30
                jsr sub71                    ; 8d70: 20 81 8d
                lda #0                       ; 8d73: a9 00
                jsr sub71                    ; 8d75: 20 81 8d
                pla                          ; 8d78: 68
                sta arr33                    ; 8d79: 85 46
                rts                          ; 8d7b: 60
cod82           jsr sub48                    ; 8d7c: 20 39 8b
                lda ram39                    ; 8d7f: a5 47
sub71           ldx arr33                    ; 8d81: a6 46
                sta arr26,x                  ; 8d83: 95 3d
                inc arr33                    ; 8d85: e6 46
                rts                          ; 8d87: 60
sub72           lda #$30                     ; 8d88: a9 30
                sta ram39                    ; 8d8a: 85 47
-               jsr sub55                    ; 8d8c: 20 e9 8b
                bcc cod82                    ; 8d8f: 90 eb
                inc ram39                    ; 8d91: e6 47
                jmp -                        ; 8d93: 4c 8c 8d
sub73           lda #0                       ; 8d96: a9 00
                sta arr33                    ; 8d98: 85 46
                ldy #$20                     ; 8d9a: a0 20
                lda ram25                    ; 8d9c: a5 29
                bpl +                        ; 8d9e: 10 05
                jsr sub43                    ; 8da0: 20 7c 8a
                ldy #$2d                     ; 8da3: a0 2d
+               tya                          ; 8da5: 98
                pha                          ; 8da6: 48
                jsr sub70                    ; 8da7: 20 40 8d
                jsr sub66                    ; 8daa: 20 eb 8c
                dec arr33                    ; 8dad: c6 46
                pla                          ; 8daf: 68
                jsr sub71                    ; 8db0: 20 81 8d
                dec arr33                    ; 8db3: c6 46
                rts                          ; 8db5: 60
sub74           cmp #$0a                     ; 8db6: c9 0a
                bcs +                        ; 8db8: b0 03
                adc #$30                     ; 8dba: 69 30
                rts                          ; 8dbc: 60
+               clc                          ; 8dbd: 18
                adc #$37                     ; 8dbe: 69 37
                rts                          ; 8dc0: 60
sub75           pha                          ; 8dc1: 48
                and #%11110000               ; 8dc2: 29 f0
                lsr a                        ; 8dc4: 4a
                lsr a                        ; 8dc5: 4a
                lsr a                        ; 8dc6: 4a
                lsr a                        ; 8dc7: 4a
                jsr sub74                    ; 8dc8: 20 b6 8d
                sta arr26,x                  ; 8dcb: 95 3d
                inx                          ; 8dcd: e8
                pla                          ; 8dce: 68
                and #%00001111               ; 8dcf: 29 0f
                jsr sub74                    ; 8dd1: 20 b6 8d
                sta arr26,x                  ; 8dd4: 95 3d
                inx                          ; 8dd6: e8
                rts                          ; 8dd7: 60
sub76           ldx #0                       ; 8dd8: a2 00
                stx arr33                    ; 8dda: 86 46
                lda ram25                    ; 8ddc: a5 29
                jsr sub75                    ; 8dde: 20 c1 8d
                lda ram24                    ; 8de1: a5 28
                jsr sub75                    ; 8de3: 20 c1 8d
                lda #0                       ; 8de6: a9 00
                sta arr26,x                  ; 8de8: 95 3d
cod83           rts                          ; 8dea: 60
sub77           lda #2                       ; 8deb: a9 02
                sta ram23                    ; 8ded: 85 27
                ldx #0                       ; 8def: a2 00
                lda #0                       ; 8df1: a9 00
                sta ram24                    ; 8df3: 85 28
                sta ram25                    ; 8df5: 85 29
-               jsr sub63                    ; 8df7: 20 c7 8c
                sec                          ; 8dfa: 38
                sbc #$30                     ; 8dfb: e9 30
                bcc cod83                    ; 8dfd: 90 eb
                cmp #$0a                     ; 8dff: c9 0a
                bcc +                        ; 8e01: 90 0b
                sec                          ; 8e03: 38
                sbc #7                       ; 8e04: e9 07
                cmp #$0a                     ; 8e06: c9 0a
                bcc cod83                    ; 8e08: 90 e0
                cmp #$10                     ; 8e0a: c9 10
                bcs cod83                    ; 8e0c: b0 dc
+               pha                          ; 8e0e: 48
                jsr sub78                    ; 8e0f: 20 22 8e
                pla                          ; 8e12: 68
                sta arr18                    ; 8e13: 85 2c
                lda #0                       ; 8e15: a9 00
                sta arr19                    ; 8e17: 85 2d
                jsr sub48                    ; 8e19: 20 39 8b
                jsr sub60                    ; 8e1c: 20 a1 8c
                jmp -                        ; 8e1f: 4c f7 8d
sub78           txa                          ; 8e22: 8a
                pha                          ; 8e23: 48
                lda #$10                     ; 8e24: a9 10
                sta arr18                    ; 8e26: 85 2c
                lda #0                       ; 8e28: a9 00
                sta arr19                    ; 8e2a: 85 2d
                jsr sub50                    ; 8e2c: 20 51 8b
                pla                          ; 8e2f: 68
                tax                          ; 8e30: aa
                rts                          ; 8e31: 60
sub79           jsr sub82                    ; 8e32: 20 3e 8e
sub80           ldy #0                       ; 8e35: a0 00
                lda (ram42),y                ; 8e37: b1 4d
                rts                          ; 8e39: 60
sub81           ldy #0                       ; 8e3a: a0 00
                lda (ram42),y                ; 8e3c: b1 4d
sub82           inc ram42                    ; 8e3e: e6 4d
                bne cod85                    ; 8e40: d0 11
                inc arr37                    ; 8e42: e6 4e
                bne cod85                    ; 8e44: d0 0d
cod84           lda #0                       ; 8e46: a9 00
                jsr sub83                    ; 8e48: 20 4b 8e
sub83           ldy #0                       ; 8e4b: a0 00
                sta (ram42),y                ; 8e4d: 91 4d
                inc ram42                    ; 8e4f: e6 4d
                beq cod86                    ; 8e51: f0 03
cod85           and #%11111111               ; 8e53: 29 ff
                rts                          ; 8e55: 60
cod86           jmp cod68                    ; 8e56: 4c 34 8b
sub84           lda #0                       ; 8e59: a9 00
                sta ram42                    ; 8e5b: 85 4d
                lda #3                       ; 8e5d: a9 03
                sta arr37                    ; 8e5f: 85 4e
cod87           jsr sub85                    ; 8e61: 20 fa 8e
                and #%11111111               ; 8e64: 29 ff
cod88           beq cod84                    ; 8e66: f0 de
                cmp #$3f                     ; 8e68: c9 3f
                beq cod90                    ; 8e6a: f0 41
                cmp #$22                     ; 8e6c: c9 22
                beq $8eb6                    ; 8e6e: f0 46
                cmp #$27                     ; 8e70: c9 27
                beq cod92                    ; 8e72: f0 3f
                cmp #$2e                     ; 8e74: c9 2e
                beq cod89                    ; 8e76: f0 0e
                cmp #$26                     ; 8e78: c9 26
                beq cod96                    ; 8e7a: f0 59
                jsr sub65                    ; 8e7c: 20 dd 8c
                bcc cod95                    ; 8e7f: 90 4b
                jsr sub88                    ; 8e81: 20 ae 8f
                bcc cod91                    ; 8e84: 90 2a
cod89           jsr sub60                    ; 8e86: 20 a1 8c
                cmp #$80                     ; 8e89: c9 80
                bcs cod87                    ; 8e8b: b0 d4
                cmp #$20                     ; 8e8d: c9 20
                bcc cod87                    ; 8e8f: 90 d0
                cmp #$40                     ; 8e91: c9 40
                bcc +                        ; 8e93: 90 12
-               jsr sub83                    ; 8e95: 20 4b 8e
                ldy #0                       ; 8e98: a0 00
                lda (ram4),y                 ; 8e9a: b1 09
                jsr sub142                   ; 8e9c: 20 bb a1
                bcs cod87                    ; 8e9f: b0 c0
                jsr sub60                    ; 8ea1: 20 a1 8c
                jmp -                        ; 8ea4: 4c 95 8e
+               jsr sub83                    ; 8ea7: 20 4b 8e
                jmp cod87                    ; 8eaa: 4c 61 8e
cod90           jmp cod102                   ; 8ead: 4c 24 8f
cod91           jmp cod103                   ; 8eb0: 4c 2b 8f
cod92           ldy #0                       ; 8eb3: a0 00
                ldx misc23                   ; 8eb5: ae a0 22
                sty ram84                    ; 8eb8: 84 99
cod93           jsr sub83                    ; 8eba: 20 4b 8e
                jsr sub60                    ; 8ebd: 20 a1 8c
cod94           jsr sub63                    ; 8ec0: 20 c7 8c
                beq cod88                    ; 8ec3: f0 a1
                cmp ram84                    ; 8ec5: c5 99
                bne cod93                    ; 8ec7: d0 f1
                jmp cod89                    ; 8ec9: 4c 86 8e
cod95           lda #$12                     ; 8ecc: a9 12
                pha                          ; 8ece: 48
                jsr sub68                    ; 8ecf: 20 09 8d
                jmp cod97                    ; 8ed2: 4c e8 8e
cod96           jsr sub60                    ; 8ed5: 20 a1 8c
                jsr sub63                    ; 8ed8: 20 c7 8c
                cmp #$48                     ; 8edb: c9 48
                bne +                        ; 8edd: d0 03
                jsr sub60                    ; 8edf: 20 a1 8c
+               lda #$11                     ; 8ee2: a9 11
                pha                          ; 8ee4: 48
                jsr sub77                    ; 8ee5: 20 eb 8d
cod97           pla                          ; 8ee8: 68
                jsr sub83                    ; 8ee9: 20 4b 8e
                lda ram24                    ; 8eec: a5 28
                jsr sub83                    ; 8eee: 20 4b 8e
                lda ram25                    ; 8ef1: a5 29
                jsr sub83                    ; 8ef3: 20 4b 8e
                jmp cod87                    ; 8ef6: 4c 61 8e
cod98           rts                          ; 8ef9: 60
sub85           jsr sub63                    ; 8efa: 20 c7 8c
                cmp #$20                     ; 8efd: c9 20
                bne cod98                    ; 8eff: d0 f8
                jsr sub83                    ; 8f01: 20 4b 8e
                jsr sub60                    ; 8f04: 20 a1 8c
                jmp sub85                    ; 8f07: 4c fa 8e
cod99           ldy #0                       ; 8f0a: a0 00
                sta ram84                    ; 8f0c: 85 99
                jmp cod94                    ; 8f0e: 4c c0 8e
cod100          jsr sub85                    ; 8f11: 20 fa 8e
                jsr sub65                    ; 8f14: 20 dd 8c
                bcc cod104                   ; 8f17: 90 2f
                cmp #$2c                     ; 8f19: c9 2c
                beq cod106                   ; 8f1b: f0 48
                cmp #$2d                     ; 8f1d: c9 2d
                beq cod106                   ; 8f1f: f0 44
cod101          jmp cod87                    ; 8f21: 4c 61 8e
cod102          lda #$8b                     ; 8f24: a9 8b
                sta ram84                    ; 8f26: 85 99
                jsr sub60                    ; 8f28: 20 a1 8c
cod103          lda ram84                    ; 8f2b: a5 99
                jsr sub83                    ; 8f2d: 20 4b 8e
                cmp #$95                     ; 8f30: c9 95
                beq cod99                    ; 8f32: f0 d6
                cmp #$86                     ; 8f34: c9 86
                beq cod100                   ; 8f36: f0 d9
                cmp #$91                     ; 8f38: c9 91
                beq cod107                   ; 8f3a: f0 3a
                cmp #$87                     ; 8f3c: c9 87
                bcs cod101                   ; 8f3e: b0 e1
                jsr sub85                    ; 8f40: 20 fa 8e
                jsr sub65                    ; 8f43: 20 dd 8c
                bcs cod101                   ; 8f46: b0 d9
cod104          jsr sub68                    ; 8f48: 20 09 8d
                lda #$0b                     ; 8f4b: a9 0b
                jsr sub83                    ; 8f4d: 20 4b 8e
                lda ram24                    ; 8f50: a5 28
                jsr sub83                    ; 8f52: 20 4b 8e
                lda ram25                    ; 8f55: a5 29
                jsr sub83                    ; 8f57: 20 4b 8e
                jsr sub85                    ; 8f5a: 20 fa 8e
cod105          cmp #$2c                     ; 8f5d: c9 2c
                beq cod106                   ; 8f5f: f0 04
                cmp #$2d                     ; 8f61: c9 2d
                bne cod101                   ; 8f63: d0 bc
cod106          jsr sub83                    ; 8f65: 20 4b 8e
                jsr sub60                    ; 8f68: 20 a1 8c
                jsr sub85                    ; 8f6b: 20 fa 8e
                jsr sub65                    ; 8f6e: 20 dd 8c
                bcc cod104                   ; 8f71: 90 d5
                jmp cod105                   ; 8f73: 4c 5d 8f
cod107          jsr sub85                    ; 8f76: 20 fa 8e
                cmp #$3a                     ; 8f79: c9 3a
                beq cod101                   ; 8f7b: f0 a4
                and #%11111111               ; 8f7d: 29 ff
cod108          beq cod101                   ; 8f7f: f0 a0
                cmp #$22                     ; 8f81: c9 22
                beq cod110                   ; 8f83: f0 09
cod109          jsr sub83                    ; 8f85: 20 4b 8e
                jsr sub60                    ; 8f88: 20 a1 8c
                jmp cod107                   ; 8f8b: 4c 76 8f
cod110          jsr sub83                    ; 8f8e: 20 4b 8e
                jsr sub60                    ; 8f91: 20 a1 8c
                jsr sub85                    ; 8f94: 20 fa 8e
                cmp #$22                     ; 8f97: c9 22
                beq cod109                   ; 8f99: f0 ea
                and #%11111111               ; 8f9b: 29 ff
                beq cod108                   ; 8f9d: f0 e0
                jmp cod110                   ; 8f9f: 4c 8e 8f
sub86           ldy #0                       ; 8fa2: a0 00
                lda (arr43),y                ; 8fa4: b1 54
cod111          rts                          ; 8fa6: 60
sub87           inc arr43                    ; 8fa7: e6 54
                bne cod111                   ; 8fa9: d0 fb
                inc arr44                    ; 8fab: e6 55
                rts                          ; 8fad: 60
sub88           lda #$28                     ; 8fae: a9 28
                sta arr43                    ; 8fb0: 85 54
                lda #$c1                     ; 8fb2: a9 c1
                sta arr44                    ; 8fb4: 85 55
cod112          jsr sub86                    ; 8fb6: 20 a2 8f
                tax                          ; 8fb9: aa
                inx                          ; 8fba: e8
                beq cod115                   ; 8fbb: f0 36
                sta ram84                    ; 8fbd: 85 99
                jsr sub87                    ; 8fbf: 20 a7 8f
                jsr sub89                    ; 8fc2: 20 f8 8f
-               jsr sub63                    ; 8fc5: 20 c7 8c
                sta ram83                    ; 8fc8: 85 98
                jsr sub86                    ; 8fca: 20 a2 8f
                cmp ram83                    ; 8fcd: c5 98
                bne cod114                   ; 8fcf: d0 0d
                jsr sub60                    ; 8fd1: 20 a1 8c
                jsr sub87                    ; 8fd4: 20 a7 8f
                jsr sub86                    ; 8fd7: 20 a2 8f
                bpl -                        ; 8fda: 10 e9
cod113          clc                          ; 8fdc: 18
                rts                          ; 8fdd: 60
cod114          jsr sub59                    ; 8fde: 20 9d 8c
                cmp #$2e                     ; 8fe1: c9 2e
                beq cod113                   ; 8fe3: f0 f7
                jsr sub90                    ; 8fe5: 20 01 90
-               jsr sub86                    ; 8fe8: 20 a2 8f
                bmi cod112                   ; 8feb: 30 c9
                jsr sub87                    ; 8fed: 20 a7 8f
                jmp -                        ; 8ff0: 4c e8 8f
cod115          jsr sub63                    ; 8ff3: 20 c7 8c
                sec                          ; 8ff6: 38
                rts                          ; 8ff7: 60
sub89           lda ram4                     ; 8ff8: a5 09
                sta ram85                    ; 8ffa: 85 9a
                lda ram5                     ; 8ffc: a5 0a
                sta ram86                    ; 8ffe: 85 9b
                rts                          ; 9000: 60
sub90           lda ram85                    ; 9001: a5 9a
                sta ram4                     ; 9003: 85 09
                lda ram86                    ; 9005: a5 9b
                sta ram5                     ; 9007: 85 0a
                rts                          ; 9009: 60
sub91           jsr sub36                    ; 900a: 20 32 8a
cod116          jsr sub80                    ; 900d: 20 35 8e
                beq +                        ; 9010: f0 17
                cmp #$20                     ; 9012: c9 20
                bcc cod117                   ; 9014: 90 18
                cmp #$80                     ; 9016: c9 80
                bcc cod119                   ; 9018: 90 4a
                pha                          ; 901a: 48
                jsr sub93                    ; 901b: 20 94 90
                jsr sub82                    ; 901e: 20 3e 8e
                pla                          ; 9021: 68
                cmp #$95                     ; 9022: c9 95
                beq cod123                   ; 9024: f0 60
                jmp cod116                   ; 9026: 4c 0d 90
+               lda #0                       ; 9029: a9 00
                jmp sub58                    ; 902b: 4c 8d 8c
cod117          pha                          ; 902e: 48
                jsr sub79                    ; 902f: 20 32 8e
                sta ram24                    ; 9032: 85 28
                jsr sub79                    ; 9034: 20 32 8e
                sta ram25                    ; 9037: 85 29
                jsr sub82                    ; 9039: 20 3e 8e
                pla                          ; 903c: 68
                cmp #$11                     ; 903d: c9 11
                bne +                        ; 903f: d0 10
                lda #$26                     ; 9041: a9 26
                jsr sub58                    ; 9043: 20 8d 8c
                lda #$48                     ; 9046: a9 48
                jsr sub58                    ; 9048: 20 8d 8c
                jsr sub76                    ; 904b: 20 d8 8d
                jmp cod118                   ; 904e: 4c 54 90
+               jsr sub69                    ; 9051: 20 3c 8d
cod118          jsr sub66                    ; 9054: 20 eb 8c
                ldx arr33                    ; 9057: a6 46
-               lda arr26,x                  ; 9059: b5 3d
                beq cod116                   ; 905b: f0 b0
                jsr sub58                    ; 905d: 20 8d 8c
                inx                          ; 9060: e8
                jmp -                        ; 9061: 4c 59 90
cod119          cmp #$22                     ; 9064: c9 22
                bne cod121                   ; 9066: d0 17
-               jsr sub92                    ; 9068: 20 8e 90
                jsr sub80                    ; 906b: 20 35 8e
                cmp #$22                     ; 906e: c9 22
                beq cod120                   ; 9070: f0 07
                and #%11111111               ; 9072: 29 ff
                bne -                        ; 9074: d0 f2
                jmp cod116                   ; 9076: 4c 0d 90
cod120          jsr sub92                    ; 9079: 20 8e 90
                jmp cod116                   ; 907c: 4c 0d 90
cod121          cmp #$27                     ; 907f: c9 27
                bne cod120                   ; 9081: d0 f6
cod122          jsr sub92                    ; 9083: 20 8e 90
cod123          jsr sub80                    ; 9086: 20 35 8e
                bne cod122                   ; 9089: d0 f8
                jmp cod116                   ; 908b: 4c 0d 90
sub92           jsr sub81                    ; 908e: 20 3a 8e
                jmp sub58                    ; 9091: 4c 8d 8c
sub93           sta ram84                    ; 9094: 85 99
                lda #$28                     ; 9096: a9 28
                sta arr43                    ; 9098: 85 54
                lda #$c1                     ; 909a: a9 c1
                sta arr44                    ; 909c: 85 55
                jsr sub86                    ; 909e: 20 a2 8f
cod124          cmp #$ff                     ; 90a1: c9 ff
                beq cod125                   ; 90a3: f0 20
                cmp ram84                    ; 90a5: c5 99
                beq +                        ; 90a7: f0 0b
-               jsr sub87                    ; 90a9: 20 a7 8f
                jsr sub86                    ; 90ac: 20 a2 8f
                bpl -                        ; 90af: 10 f8
                jmp cod124                   ; 90b1: 4c a1 90
+               jsr sub87                    ; 90b4: 20 a7 8f
-               jsr sub86                    ; 90b7: 20 a2 8f
                bmi cod125                   ; 90ba: 30 09
                jsr sub58                    ; 90bc: 20 8d 8c
                jsr sub87                    ; 90bf: 20 a7 8f
                jmp -                        ; 90c2: 4c b7 90
cod125          rts                          ; 90c5: 60
                beq cod129                   ; 90c6: f0 5b
                tax                          ; 90c8: aa
                pla                          ; 90c9: 68
                sta ram50                    ; 90ca: 85 5f
                pla                          ; 90cc: 68
                sta arr47                    ; 90cd: 85 60
                txa                          ; 90cf: 8a
                jsr sub94                    ; 90d0: 20 72 91
                jsr sub100                   ; 90d3: 20 98 95
                lda ram4                     ; 90d6: a5 09
                pha                          ; 90d8: 48
                lda ram5                     ; 90d9: a5 0a
                pha                          ; 90db: 48
                lda ram6                     ; 90dc: a5 0b
                pha                          ; 90de: 48
                lda arr7                     ; 90df: a5 0c
                pha                          ; 90e1: 48
                lda arr8                     ; 90e2: a5 0d
                pha                          ; 90e4: 48
                lda ram7                     ; 90e5: a5 0e
                pha                          ; 90e7: 48
                lda #0                       ; 90e8: a9 00
                pha                          ; 90ea: 48
                lda #$ff                     ; 90eb: a9 ff
                pha                          ; 90ed: 48
                lda arr47                    ; 90ee: a5 60
                pha                          ; 90f0: 48
                lda ram50                    ; 90f1: a5 5f
                pha                          ; 90f3: 48
                jmp cod132                   ; 90f4: 4c 4b 91
cod126          lda #2                       ; 90f7: a9 02
                jmp cod287                   ; 90f9: 4c 8f a9
cod127          pla                          ; 90fc: 68
                sta ram50                    ; 90fd: 85 5f
                pla                          ; 90ff: 68
                sta arr47                    ; 9100: 85 60
                pla                          ; 9102: 68
                cmp #$ff                     ; 9103: c9 ff
                bne cod126                   ; 9105: d0 f0
                pla                          ; 9107: 68
                bne cod126                   ; 9108: d0 ed
                pla                          ; 910a: 68
                sta ram7                     ; 910b: 85 0e
                pla                          ; 910d: 68
                sta arr8                     ; 910e: 85 0d
                pla                          ; 9110: 68
                sta arr7                     ; 9111: 85 0c
                pla                          ; 9113: 68
                sta ram6                     ; 9114: 85 0b
                pla                          ; 9116: 68
                sta ram5                     ; 9117: 85 0a
                pla                          ; 9119: 68
                sta ram4                     ; 911a: 85 09
cod128          lda arr47                    ; 911c: a5 60
                pha                          ; 911e: 48
                lda ram50                    ; 911f: a5 5f
                pha                          ; 9121: 48
                rts                          ; 9122: 60
cod129          jmp cod24                    ; 9123: 4c 6d 83
                beq cod127                   ; 9126: f0 d4
                pla                          ; 9128: 68
                sta ram50                    ; 9129: 85 5f
                pla                          ; 912b: 68
                sta arr47                    ; 912c: 85 60
                pla                          ; 912e: 68
                cmp #$ff                     ; 912f: c9 ff
                bne cod126                   ; 9131: d0 c4
                pla                          ; 9133: 68
                bne cod126                   ; 9134: d0 c1
                tsx                          ; 9136: ba
                txa                          ; 9137: 8a
                clc                          ; 9138: 18
                adc #6                       ; 9139: 69 06
                tax                          ; 913b: aa
                txs                          ; 913c: 9a
                lda arr47                    ; 913d: a5 60
                pha                          ; 913f: 48
                lda ram50                    ; 9140: a5 5f
                pha                          ; 9142: 48
                jsr sub13                    ; 9143: 20 78 83
cod130          beq cod129                   ; 9146: f0 db
cod131          jsr sub94                    ; 9148: 20 72 91
cod132          ldy #0                       ; 914b: a0 00
                lda (ram46),y                ; 914d: b1 5b
                clc                          ; 914f: 18
                adc ram46                    ; 9150: 65 5b
                sta arr8                     ; 9152: 85 0d
                lda #0                       ; 9154: a9 00
                adc ram47                    ; 9156: 65 5c
                sta ram7                     ; 9158: 85 0e
                iny                          ; 915a: c8
                lda (ram46),y                ; 915b: b1 5b
                sta ram6                     ; 915d: 85 0b
                iny                          ; 915f: c8
                lda (ram46),y                ; 9160: b1 5b
                sta arr7                     ; 9162: 85 0c
                clc                          ; 9164: 18
                lda #3                       ; 9165: a9 03
                adc ram46                    ; 9167: 65 5b
                sta ram4                     ; 9169: 85 09
                lda #0                       ; 916b: a9 00
                adc ram47                    ; 916d: 65 5c
                sta ram5                     ; 916f: 85 0a
                rts                          ; 9171: 60
sub94           cmp #$0b                     ; 9172: c9 0b
                bne cod129                   ; 9174: d0 ad
                ldy #1                       ; 9176: a0 01
                lda (ram4),y                 ; 9178: b1 09
                sta arr31                    ; 917a: 85 44
                iny                          ; 917c: c8
                lda (ram4),y                 ; 917d: b1 09
                sta arr32                    ; 917f: 85 45
                jsr sub16                    ; 9181: 20 04 84
                bne cod134                   ; 9184: d0 01
cod133          rts                          ; 9186: 60
cod134          lda #7                       ; 9187: a9 07
                jmp cod287                   ; 9189: 4c 8f a9
                jsr sub122                   ; 918c: 20 82 9c
                jmp (arr144)                 ; 918f: 6c 00 04
cod135          jmp $8370                    ; 9192: 4c 70 83
-               jmp sub211                   ; 9195: 4c 63 b2
                beq -                        ; 9198: f0 fb
                lda #0                       ; 919a: a9 00
                sta arr57                    ; 919c: 85 74
                jsr sub122                   ; 919e: 20 82 9c
                jsr sub158                   ; 91a1: 20 ef a3
                lda arr145                   ; 91a4: ad 01 04
                bmi cod135                   ; 91a7: 30 e9
                bne +                        ; 91a9: d0 05
                lda arr144                   ; 91ab: ad 00 04
                beq cod133                   ; 91ae: f0 d6
+               inc arr145                   ; 91b0: ee 01 04
-               jsr sub27                    ; 91b3: 20 d4 86
                dec arr57                    ; 91b6: c6 74
                bne -                        ; 91b8: d0 f9
                dec arr144                   ; 91ba: ce 00 04
                bne -                        ; 91bd: d0 f4
                lda arr145                   ; 91bf: ad 01 04
                beq +                        ; 91c2: f0 05
                dec arr145                   ; 91c4: ce 01 04
                bne -                        ; 91c7: d0 ea
+               rts                          ; 91c9: 60
                jsr sub120                   ; 91ca: 20 6d 9c
                cmp #$1c                     ; 91cd: c9 1c
                bcs cod135                   ; 91cf: b0 c1
                sta ram57                    ; 91d1: 85 6b
                jsr sub119                   ; 91d3: 20 6a 9c
                cmp #$18                     ; 91d6: c9 18
                bcs cod135                   ; 91d8: b0 b8
                sta ram58                    ; 91da: 85 6c
                jmp sub199                   ; 91dc: 4c aa ac
cod136          jsr sub122                   ; 91df: 20 82 9c
                lda arr144                   ; 91e2: ad 00 04
                sta arr17                    ; 91e5: 85 25
                lda arr145                   ; 91e7: ad 01 04
                sta ram22                    ; 91ea: 85 26
                ldy #0                       ; 91ec: a0 00
                sty arr33                    ; 91ee: 84 46
-               jsr sub119                   ; 91f0: 20 6a 9c
                ldy arr33                    ; 91f3: a4 46
                sta (arr17),y                ; 91f5: 91 25
                inc arr33                    ; 91f7: e6 46
                jsr sub13                    ; 91f9: 20 78 83
                bne -                        ; 91fc: d0 f2
                rts                          ; 91fe: 60
-               pla                          ; 91ff: 68
                pla                          ; 9200: 68
                jmp cod22                    ; 9201: 4c 45 83
                jsr sub122                   ; 9204: 20 82 9c
                lda arr144                   ; 9207: ad 00 04
                ora arr145                   ; 920a: 0d 01 04
                beq -                        ; 920d: f0 f0
                jsr sub13                    ; 920f: 20 78 83
                beq cod140                   ; 9212: f0 61
                cmp #$85                     ; 9214: c9 85
                beq cod138                   ; 9216: f0 04
                rts                          ; 9218: 60
cod137          jmp cod131                   ; 9219: 4c 48 91
cod138          jsr sub12                    ; 921c: 20 75 83
                beq cod136                   ; 921f: f0 be
                cmp #$0b                     ; 9221: c9 0b
                beq cod137                   ; 9223: f0 f4
                rts                          ; 9225: 60
                bne cod139                   ; 9226: d0 25
sub95           lda arr6                     ; 9228: a5 08
                sta ram19                    ; 922a: 85 1e
                ldx ram3                     ; 922c: a6 07
                inx                          ; 922e: e8
                bne +                        ; 922f: d0 02
                inc ram19                    ; 9231: e6 1e
+               stx ram18                    ; 9233: 86 1d
                lda ram19                    ; 9235: a5 1e
                sta arr14                    ; 9237: 85 20
                ldx ram18                    ; 9239: a6 1d
                inx                          ; 923b: e8
                bne +                        ; 923c: d0 02
                inc arr14                    ; 923e: e6 20
+               stx arr13                    ; 9240: 86 1f
                ldy #0                       ; 9242: a0 00
                tya                          ; 9244: 98
                sta (ram18),y                ; 9245: 91 1d
                iny                          ; 9247: c8
                sta (ram18),y                ; 9248: 91 1d
                jmp cod175                   ; 924a: 4c fa 98
cod139          jsr sub95                    ; 924d: 20 28 92
                jsr sub122                   ; 9250: 20 82 9c
                jsr sub158                   ; 9253: 20 ef a3
                lda arr145                   ; 9256: ad 01 04
                cmp #$78                     ; 9259: c9 78
                bcs cod141                   ; 925b: b0 1b
                cmp arr14                    ; 925d: c5 20
                bcc cod141                   ; 925f: 90 17
                bne +                        ; 9261: d0 07
                lda arr144                   ; 9263: ad 00 04
                cmp arr13                    ; 9266: c5 1f
                bcc cod141                   ; 9268: 90 0e
+               lda arr144                   ; 926a: ad 00 04
                sta ram1                     ; 926d: 85 03
                lda arr145                   ; 926f: ad 01 04
                sta ram2                     ; 9272: 85 04
                rts                          ; 9274: 60
cod140          jmp cod24                    ; 9275: 4c 6d 83
cod141          jmp $8370                    ; 9278: 4c 70 83
-               jmp cod262                   ; 927b: 4c e1 a3
                beq cod140                   ; 927e: f0 f5
                pla                          ; 9280: 68
                sta ram50                    ; 9281: 85 5f
                pla                          ; 9283: 68
                sta arr47                    ; 9284: 85 60
                lda arr8                     ; 9286: a5 0d
                pha                          ; 9288: 48
                lda ram7                     ; 9289: a5 0e
                pha                          ; 928b: 48
                lda ram6                     ; 928c: a5 0b
                pha                          ; 928e: 48
                lda arr7                     ; 928f: a5 0c
                pha                          ; 9291: 48
                jsr sub64                    ; 9292: 20 d4 8c
                jsr sub135                   ; 9295: 20 75 9f
                lda ram79                    ; 9298: a5 90
                cmp #2                       ; 929a: c9 02
                bne -                        ; 929c: d0 dd
                lda arr64                    ; 929e: a5 8c
                pha                          ; 92a0: 48
                lda arr65                    ; 92a1: a5 8d
                pha                          ; 92a3: 48
                jsr sub21                    ; 92a4: 20 a2 85
                jsr sub122                   ; 92a7: 20 82 9c
                pla                          ; 92aa: 68
                sta arr65                    ; 92ab: 85 8d
                pla                          ; 92ad: 68
                sta arr64                    ; 92ae: 85 8c
                ldy #0                       ; 92b0: a0 00
                lda arr144                   ; 92b2: ad 00 04
                sta (arr64),y                ; 92b5: 91 8c
                lda arr145                   ; 92b7: ad 01 04
                iny                          ; 92ba: c8
                sta (arr64),y                ; 92bb: 91 8c
                lda arr64                    ; 92bd: a5 8c
                pha                          ; 92bf: 48
                lda arr65                    ; 92c0: a5 8d
                pha                          ; 92c2: 48
                jsr sub64                    ; 92c3: 20 d4 8c
                cmp #$88                     ; 92c6: c9 88
                bne cod140                   ; 92c8: d0 ab
                jsr sub60                    ; 92ca: 20 a1 8c
                jsr sub122                   ; 92cd: 20 82 9c
                lda arr144                   ; 92d0: ad 00 04
                pha                          ; 92d3: 48
                lda arr145                   ; 92d4: ad 01 04
                pha                          ; 92d7: 48
                lda #1                       ; 92d8: a9 01
                sta arr144                   ; 92da: 8d 00 04
                lda #0                       ; 92dd: a9 00
                sta arr145                   ; 92df: 8d 01 04
                jsr sub13                    ; 92e2: 20 78 83
                beq +                        ; 92e5: f0 0a
                cmp #$89                     ; 92e7: c9 89
                bne cod140                   ; 92e9: d0 8a
                jsr sub60                    ; 92eb: 20 a1 8c
                jsr sub122                   ; 92ee: 20 82 9c
+               lda arr144                   ; 92f1: ad 00 04
                pha                          ; 92f4: 48
                lda arr145                   ; 92f5: ad 01 04
                pha                          ; 92f8: 48
                lda ram4                     ; 92f9: a5 09
                pha                          ; 92fb: 48
                lda ram5                     ; 92fc: a5 0a
                pha                          ; 92fe: 48
                lda #0                       ; 92ff: a9 00
                pha                          ; 9301: 48
                lda #$fd                     ; 9302: a9 fd
                pha                          ; 9304: 48
                jmp cod128                   ; 9305: 4c 1c 91
-               lda #0                       ; 9308: a9 00
                jmp cod287                   ; 930a: 4c 8f a9
                pla                          ; 930d: 68
                sta ram50                    ; 930e: 85 5f
                pla                          ; 9310: 68
                sta arr47                    ; 9311: 85 60
                pla                          ; 9313: 68
                cmp #$fd                     ; 9314: c9 fd
                bne -                        ; 9316: d0 f0
                pla                          ; 9318: 68
                bne -                        ; 9319: d0 ed
                pla                          ; 931b: 68
                sta ram75                    ; 931c: 85 89
                pla                          ; 931e: 68
                sta ram74                    ; 931f: 85 88
                pla                          ; 9321: 68
                sta arr63                    ; 9322: 85 83
                pla                          ; 9324: 68
                sta ram69                    ; 9325: 85 82
                pla                          ; 9327: 68
                sta ram68                    ; 9328: 85 81
                pla                          ; 932a: 68
                sta arr62                    ; 932b: 85 80
                pla                          ; 932d: 68
                sta ram65                    ; 932e: 85 7d
                pla                          ; 9330: 68
                sta ram64                    ; 9331: 85 7c
                pla                          ; 9333: 68
                sta ram73                    ; 9334: 85 87
                pla                          ; 9336: 68
                sta ram72                    ; 9337: 85 86
                pla                          ; 9339: 68
                sta ram71                    ; 933a: 85 85
                pla                          ; 933c: 68
                sta ram70                    ; 933d: 85 84
                ldy #0                       ; 933f: a0 00
                lda (ram64),y                ; 9341: b1 7c
                sta ram24                    ; 9343: 85 28
                iny                          ; 9345: c8
                lda (ram64),y                ; 9346: b1 7c
                sta ram25                    ; 9348: 85 29
                jsr sub96                    ; 934a: 20 8a 93
                beq +                        ; 934d: f0 02
                bcc cod142                   ; 934f: 90 36
+               lda ram70                    ; 9351: a5 84
                pha                          ; 9353: 48
                sta arr8                     ; 9354: 85 0d
                lda ram71                    ; 9356: a5 85
                pha                          ; 9358: 48
                sta ram7                     ; 9359: 85 0e
                lda ram72                    ; 935b: a5 86
                pha                          ; 935d: 48
                sta ram6                     ; 935e: 85 0b
                lda ram73                    ; 9360: a5 87
                pha                          ; 9362: 48
                sta arr7                     ; 9363: 85 0c
                lda ram64                    ; 9365: a5 7c
                pha                          ; 9367: 48
                lda ram65                    ; 9368: a5 7d
                pha                          ; 936a: 48
                lda arr62                    ; 936b: a5 80
                pha                          ; 936d: 48
                lda ram68                    ; 936e: a5 81
                pha                          ; 9370: 48
                lda ram69                    ; 9371: a5 82
                pha                          ; 9373: 48
                lda arr63                    ; 9374: a5 83
                pha                          ; 9376: 48
                lda ram74                    ; 9377: a5 88
                pha                          ; 9379: 48
                sta ram4                     ; 937a: 85 09
                lda ram75                    ; 937c: a5 89
                pha                          ; 937e: 48
                sta ram5                     ; 937f: 85 0a
                lda #0                       ; 9381: a9 00
                pha                          ; 9383: 48
                lda #$fd                     ; 9384: a9 fd
                pha                          ; 9386: 48
cod142          jmp cod128                   ; 9387: 4c 1c 91
sub96           lda arr63                    ; 938a: a5 83
                bmi cod143                   ; 938c: 30 0c
                jsr sub97                    ; 938e: 20 a0 93
                jsr sub57                    ; 9391: 20 03 8c
                bcs +                        ; 9394: b0 02
                sec                          ; 9396: 38
                rts                          ; 9397: 60
+               clc                          ; 9398: 18
                rts                          ; 9399: 60
cod143          jsr sub97                    ; 939a: 20 a0 93
                jmp sub57                    ; 939d: 4c 03 8c
sub97           lda ram69                    ; 93a0: a5 82
                sta arr18                    ; 93a2: 85 2c
                lda arr63                    ; 93a4: a5 83
                sta arr19                    ; 93a6: 85 2d
                jsr sub44                    ; 93a8: 20 e8 8a
                ldy #0                       ; 93ab: a0 00
                lda ram24                    ; 93ad: a5 28
                sta (ram64),y                ; 93af: 91 7c
                iny                          ; 93b1: c8
                lda ram25                    ; 93b2: a5 29
                sta (ram64),y                ; 93b4: 91 7c
                lda arr62                    ; 93b6: a5 80
                sta arr18                    ; 93b8: 85 2c
                lda ram68                    ; 93ba: a5 81
                sta arr19                    ; 93bc: 85 2d
cod144          rts                          ; 93be: 60
-               jmp cod24                    ; 93bf: 4c 6d 83
                beq -                        ; 93c2: f0 fb
                cmp #$22                     ; 93c4: c9 22
                bne cod145                   ; 93c6: d0 0b
                jsr sub98                    ; 93c8: 20 db 94
                cmp #$2c                     ; 93cb: c9 2c
                beq cod146                   ; 93cd: f0 09
                cmp #$3b                     ; 93cf: c9 3b
                bne -                        ; 93d1: d0 ec
cod145          lda #$3f                     ; 93d3: a9 3f
                jsr sub195                   ; 93d5: 20 0d ac
cod146          lda arr35                    ; 93d8: a5 49
                sta ram66                    ; 93da: 85 7e
                lda arr34                    ; 93dc: a5 48
                sta arr62                    ; 93de: 85 80
                jsr sub213                   ; 93e0: 20 43 b3
                jsr sub27                    ; 93e3: 20 d4 86
                lda #0                       ; 93e6: a9 00
                sta arr41                    ; 93e8: 85 52
-               lda ram66                    ; 93ea: a5 7e
                cmp ram39                    ; 93ec: c5 47
                beq +                        ; 93ee: f0 0b
                dec ram66                    ; 93f0: c6 7e
                clc                          ; 93f2: 18
                lda #$1c                     ; 93f3: a9 1c
                adc arr41                    ; 93f5: 65 52
                sta arr41                    ; 93f7: 85 52
                bne -                        ; 93f9: d0 ef
+               lda arr62                    ; 93fb: a5 80
                clc                          ; 93fd: 18
                adc arr41                    ; 93fe: 65 52
                sta arr41                    ; 9400: 85 52
cod147          jsr sub64                    ; 9402: 20 d4 8c
                jsr sub135                   ; 9405: 20 75 9f
                jsr sub89                    ; 9408: 20 f8 8f
                lda arr41                    ; 940b: a5 52
                sta ram4                     ; 940d: 85 09
                lda #5                       ; 940f: a9 05
                sta ram5                     ; 9411: 85 0a
                lda ram79                    ; 9413: a5 90
                and #%00001111               ; 9415: 29 0f
                cmp #3                       ; 9417: c9 03
                beq cod149                   ; 9419: f0 40
                jsr sub161                   ; 941b: 20 fe a4
                lda ram4                     ; 941e: a5 09
                sta arr41                    ; 9420: 85 52
                ldy #0                       ; 9422: a0 00
                lda ram24                    ; 9424: a5 28
                sta (arr64),y                ; 9426: 91 8c
                iny                          ; 9428: c8
                lda ram25                    ; 9429: a5 29
                sta (arr64),y                ; 942b: 91 8c
cod148          jsr sub90                    ; 942d: 20 01 90
                jsr sub64                    ; 9430: 20 d4 8c
                cmp #$2c                     ; 9433: c9 2c
                bne cod144                   ; 9435: d0 87
                jsr sub60                    ; 9437: 20 a1 8c
                jsr sub89                    ; 943a: 20 f8 8f
                lda arr41                    ; 943d: a5 52
                sta ram4                     ; 943f: 85 09
                lda #5                       ; 9441: a9 05
                sta ram5                     ; 9443: 85 0a
                ldy #0                       ; 9445: a0 00
                lda (ram4),y                 ; 9447: b1 09
                cmp #$2c                     ; 9449: c9 2c
                bne +                        ; 944b: d0 08
                inc arr41                    ; 944d: e6 52
                jsr sub90                    ; 944f: 20 01 90
                jmp cod147                   ; 9452: 4c 02 94
+               jsr sub90                    ; 9455: 20 01 90
                jmp cod145                   ; 9458: 4c d3 93
cod149          jsr sub64                    ; 945b: 20 d4 8c
                lda #0                       ; 945e: a9 00
                sta ram16                    ; 9460: 85 1b
                ldy #0                       ; 9462: a0 00
                ldx #0                       ; 9464: a2 00
-               lda (ram4),y                 ; 9466: b1 09
                beq +                        ; 9468: f0 10
                cmp #$2c                     ; 946a: c9 2c
                beq +                        ; 946c: f0 0c
                sta arr191,x                 ; 946e: 9d 00 07
                inc ram16                    ; 9471: e6 1b
                inx                          ; 9473: e8
                jsr sub60                    ; 9474: 20 a1 8c
                jmp -                        ; 9477: 4c 66 94
+               lda ram16                    ; 947a: a5 1b
                sta arr144                   ; 947c: 8d 00 04
                lda #0                       ; 947f: a9 00
                sta arr145                   ; 9481: 8d 01 04
                lda #7                       ; 9484: a9 07
                sta arr146                   ; 9486: 8d 02 04
                jsr sub11                    ; 9489: 20 ef 82
                lda ram4                     ; 948c: a5 09
                sta arr41                    ; 948e: 85 52
                jmp cod148                   ; 9490: 4c 2d 94
cod150          jmp cod24                    ; 9493: 4c 6d 83
                beq cod150                   ; 9496: f0 fb
                jsr sub135                   ; 9498: 20 75 9f
                lda ram79                    ; 949b: a5 90
                and #%00001111               ; 949d: 29 0f
                pha                          ; 949f: 48
                lda arr64                    ; 94a0: a5 8c
                pha                          ; 94a2: 48
                lda arr65                    ; 94a3: a5 8d
                pha                          ; 94a5: 48
                jsr sub165                   ; 94a6: 20 94 a5
                jsr sub64                    ; 94a9: 20 d4 8c
                jsr sub135                   ; 94ac: 20 75 9f
                pla                          ; 94af: 68
                sta ram15                    ; 94b0: 85 1a
                pla                          ; 94b2: 68
                sta ram14                    ; 94b3: 85 19
                lda ram79                    ; 94b5: a5 90
                and #%00001111               ; 94b7: 29 0f
                sta ram79                    ; 94b9: 85 90
                pla                          ; 94bb: 68
                cmp ram79                    ; 94bc: c5 90
                bne cod151                   ; 94be: d0 18
                tax                          ; 94c0: aa
                cmp #2                       ; 94c1: c9 02
                beq +                        ; 94c3: f0 02
                ldx #$21                     ; 94c5: a2 21
+               ldy #0                       ; 94c7: a0 00
-               lda (arr64),y                ; 94c9: b1 8c
                pha                          ; 94cb: 48
                lda (ram14),y                ; 94cc: b1 19
                sta (arr64),y                ; 94ce: 91 8c
                pla                          ; 94d0: 68
                sta (ram14),y                ; 94d1: 91 19
                iny                          ; 94d3: c8
                dex                          ; 94d4: ca
                bne -                        ; 94d5: d0 f2
                rts                          ; 94d7: 60
cod151          jmp cod262                   ; 94d8: 4c e1 a3
sub98           jsr sub60                    ; 94db: 20 a1 8c
                ldy #0                       ; 94de: a0 00
                lda (ram4),y                 ; 94e0: b1 09
                beq cod150                   ; 94e2: f0 af
                cmp #$22                     ; 94e4: c9 22
                beq +                        ; 94e6: f0 06
                jsr sub195                   ; 94e8: 20 0d ac
                jmp sub98                    ; 94eb: 4c db 94
+               jsr sub12                    ; 94ee: 20 75 83
                beq cod150                   ; 94f1: f0 a0
                jmp sub60                    ; 94f3: 4c a1 8c
                beq cod150                   ; 94f6: f0 9b
                cmp #$22                     ; 94f8: c9 22
                bne +                        ; 94fa: d0 0b
                jsr sub98                    ; 94fc: 20 db 94
                cmp #$2c                     ; 94ff: c9 2c
                beq +                        ; 9501: f0 04
                cmp #$3b                     ; 9503: c9 3b
                bne cod150                   ; 9505: d0 8c
+               jsr sub213                   ; 9507: 20 43 b3
                jsr sub27                    ; 950a: 20 d4 86
                jsr sub64                    ; 950d: 20 d4 8c
                jsr sub135                   ; 9510: 20 75 9f
                lda ram79                    ; 9513: a5 90
                and #%00001111               ; 9515: 29 0f
                cmp #3                       ; 9517: c9 03
                bne cod151                   ; 9519: d0 bd
                ldx #0                       ; 951b: a2 00
                ldy #0                       ; 951d: a0 00
                lda arr160,x                 ; 951f: bd 00 05
                cmp #$20                     ; 9522: c9 20
                bne cod152                   ; 9524: d0 07
                inx                          ; 9526: e8
                lda arr160,x                 ; 9527: bd 00 05
                beq cod153                   ; 952a: f0 0e
                dex                          ; 952c: ca
cod152          lda arr160,x                 ; 952d: bd 00 05
                beq cod153                   ; 9530: f0 08
                sta arr191,x                 ; 9532: 9d 00 07
                inx                          ; 9535: e8
                iny                          ; 9536: c8
                jmp cod152                   ; 9537: 4c 2d 95
cod153          sty arr144                   ; 953a: 8c 00 04
                lda #0                       ; 953d: a9 00
                sta arr145                   ; 953f: 8d 01 04
                lda #5                       ; 9542: a9 05
                sta arr146                   ; 9544: 8d 02 04
                jmp sub11                    ; 9547: 4c ef 82
cod154          jmp cod24                    ; 954a: 4c 6d 83
                jsr sub120                   ; 954d: 20 6d 9c
                jsr sub64                    ; 9550: 20 d4 8c
                pha                          ; 9553: 48
                jsr sub60                    ; 9554: 20 a1 8c
                ldx arr144                   ; 9557: ae 00 04
                beq cod157                   ; 955a: f0 34
cod155          jsr sub13                    ; 955c: 20 78 83
                beq cod158                   ; 955f: f0 32
                cmp #$0b                     ; 9561: c9 0b
                bne cod154                   ; 9563: d0 e5
                dex                          ; 9565: ca
                beq cod156                   ; 9566: f0 0e
                jsr sub113                   ; 9568: 20 27 99
dat12           jsr sub13                    ; 956b: 20 78 83
                beq cod158                   ; 956e: f0 23
sub99           jsr sub165                   ; 9570: 20 94 a5
                jmp cod155                   ; 9573: 4c 5c 95
cod156          pla                          ; 9576: 68
                sec                          ; 9577: 38
                sbc #$80                     ; 9578: e9 80
                cmp #5                       ; 957a: c9 05
                bcs cod154                   ; 957c: b0 cc
                asl a                        ; 957e: 0a
                tax                          ; 957f: aa
                lda dat72,x                  ; 9580: bd c6 c2
                sta ram14                    ; 9583: 85 19
                lda $c2c7,x                  ; 9585: bd c7 c2
                sta ram15                    ; 9588: 85 1a
                jsr sub64                    ; 958a: 20 d4 8c
                jmp (ram14)                  ; 958d: 6c 19 00
cod157          jsr sub100                   ; 9590: 20 98 95
cod158          pla                          ; 9593: 68
cod159          rts                          ; 9594: 60
cod160          jsr sub113                   ; 9595: 20 27 99
sub100          jsr sub13                    ; 9598: 20 78 83
                beq cod159                   ; 959b: f0 f7
                cmp #$0b                     ; 959d: c9 0b
                beq cod160                   ; 959f: f0 f4
                jsr sub165                   ; 95a1: 20 94 a5
                jmp sub100                   ; 95a4: 4c 98 95
-               jmp $8370                    ; 95a7: 4c 70 83
                cmp #$86                     ; 95aa: c9 86
                beq cod161                   ; 95ac: f0 45
                jsr sub120                   ; 95ae: 20 6d 9c
                beq -                        ; 95b1: f0 f4
                pha                          ; 95b3: 48
                jsr sub165                   ; 95b4: 20 94 a5
                jsr sub121                   ; 95b7: 20 7c 9c
                pla                          ; 95ba: 68
                sec                          ; 95bb: 38
                sbc #1                       ; 95bc: e9 01
                cmp #9                       ; 95be: c9 09
                bcs -                        ; 95c0: b0 e5
                asl a                        ; 95c2: 0a
                asl a                        ; 95c3: 0a
                asl a                        ; 95c4: 0a
                asl a                        ; 95c5: 0a
                tax                          ; 95c6: aa
                lda arr144                   ; 95c7: ad 00 04
                beq +                        ; 95ca: f0 21
                ldy #0                       ; 95cc: a0 00
                lda arr145                   ; 95ce: ad 01 04
                sta ram14                    ; 95d1: 85 19
                lda arr146                   ; 95d3: ad 02 04
                sta ram15                    ; 95d6: 85 1a
                lda #$0f                     ; 95d8: a9 0f
                sta ram79                    ; 95da: 85 90
-               lda (ram14),y                ; 95dc: b1 19
                sta arr159,x                 ; 95de: 9d 80 04
                inx                          ; 95e1: e8
                iny                          ; 95e2: c8
                dec arr144                   ; 95e3: ce 00 04
                beq +                        ; 95e6: f0 05
                dec ram79                    ; 95e8: c6 90
                bne -                        ; 95ea: d0 f0
                rts                          ; 95ec: 60
+               lda #0                       ; 95ed: a9 00
                sta arr159,x                 ; 95ef: 9d 80 04
                rts                          ; 95f2: 60
cod161          jsr sub60                    ; 95f3: 20 a1 8c
                lda #$30                     ; 95f6: a9 30
                sta ram79                    ; 95f8: 85 90
                lda #0                       ; 95fa: a9 00
                sta arr57                    ; 95fc: 85 74
cod162          lda #$46                     ; 95fe: a9 46
                jsr sub31                    ; 9600: 20 f0 87
                inc ram79                    ; 9603: e6 90
                lda ram79                    ; 9605: a5 90
                jsr sub31                    ; 9607: 20 f0 87
                lda #$20                     ; 960a: a9 20
                jsr sub31                    ; 960c: 20 f0 87
                lda arr57                    ; 960f: a5 74
                asl a                        ; 9611: 0a
                asl a                        ; 9612: 0a
                asl a                        ; 9613: 0a
                asl a                        ; 9614: 0a
                tay                          ; 9615: a8
-               lda arr159,y                 ; 9616: b9 80 04
                beq cod163                   ; 9619: f0 21
                cmp #$20                     ; 961b: c9 20
                bcc +                        ; 961d: 90 07
                jsr sub31                    ; 961f: 20 f0 87
                iny                          ; 9622: c8
                jmp -                        ; 9623: 4c 16 96
+               pha                          ; 9626: 48
                lda #$28                     ; 9627: a9 28
                jsr sub31                    ; 9629: 20 f0 87
                pla                          ; 962c: 68
                clc                          ; 962d: 18
                adc #$40                     ; 962e: 69 40
                jsr sub31                    ; 9630: 20 f0 87
                lda #$29                     ; 9633: a9 29
                jsr sub31                    ; 9635: 20 f0 87
                iny                          ; 9638: c8
                jmp -                        ; 9639: 4c 16 96
cod163          jsr sub33                    ; 963c: 20 fb 87
                jsr sub194                   ; 963f: 20 07 ac
                inc arr57                    ; 9642: e6 74
                lda arr57                    ; 9644: a5 74
                cmp #8                       ; 9646: c9 08
                bcc cod162                   ; 9648: 90 b4
                rts                          ; 964a: 60
cod164          jmp cod24                    ; 964b: 4c 6d 83
cod165          jsr sub143                   ; 964e: 20 c3 a1
                bcs cod164                   ; 9651: b0 f8
                sta ram64                    ; 9653: 85 7c
                lda #2                       ; 9655: a9 02
                sta ram70                    ; 9657: 85 84
                lda #0                       ; 9659: a9 00
                sta ram65                    ; 965b: 85 7d
                jsr sub61                    ; 965d: 20 ad 8c
                jsr sub142                   ; 9660: 20 bb a1
                bcs +                        ; 9663: b0 05
                sta ram65                    ; 9665: 85 7d
                jsr sub60                    ; 9667: 20 a1 8c
+               jsr sub64                    ; 966a: 20 d4 8c
                cmp #$24                     ; 966d: c9 24
                bne +                        ; 966f: d0 05
                inc ram70                    ; 9671: e6 84
                jsr sub12                    ; 9673: 20 75 83
+               cmp #$28                     ; 9676: c9 28
                bne cod164                   ; 9678: d0 d1
                lda #0                       ; 967a: a9 00
                sta ram69                    ; 967c: 85 82
                jsr sub118                   ; 967e: 20 64 9c
                sta ram66                    ; 9681: 85 7e
                jsr sub64                    ; 9683: 20 d4 8c
                cmp #$29                     ; 9686: c9 29
                beq +                        ; 9688: f0 0e
                inc ram69                    ; 968a: e6 82
                jsr sub119                   ; 968c: 20 6a 9c
                sta ram67                    ; 968f: 85 7f
                jsr sub13                    ; 9691: 20 78 83
                cmp #$29                     ; 9694: c9 29
                bne cod164                   ; 9696: d0 b3
+               jsr sub60                    ; 9698: 20 a1 8c
                jsr sub102                   ; 969b: 20 b2 96
                jsr sub13                    ; 969e: 20 78 83
                beq cod166                   ; 96a1: f0 09
                jsr sub165                   ; 96a3: 20 94 a5
sub101          jsr sub64                    ; 96a6: 20 d4 8c
                jmp cod165                   ; 96a9: 4c 4e 96
cod166          rts                          ; 96ac: 60
cod167          lda #9                       ; 96ad: a9 09
                jmp cod287                   ; 96af: 4c 8f a9
sub102          jsr sub103                   ; 96b2: 20 78 97
                bcs cod167                   ; 96b5: b0 f6
                lda #1                       ; 96b7: a9 01
                sta arr18                    ; 96b9: 85 2c
                jsr sub144                   ; 96bb: 20 cd a1
                lda ram66                    ; 96be: a5 7e
                sta ram24                    ; 96c0: 85 28
                inc ram24                    ; 96c2: e6 28
                bne +                        ; 96c4: d0 02
                inc ram25                    ; 96c6: e6 29
+               lda ram69                    ; 96c8: a5 82
                beq +                        ; 96ca: f0 0a
                lda ram67                    ; 96cc: a5 7f
                sta arr18                    ; 96ce: 85 2c
                inc arr18                    ; 96d0: e6 2c
                bne +                        ; 96d2: d0 02
                inc arr19                    ; 96d4: e6 2d
+               jsr sub52                    ; 96d6: 20 5c 8b
                jsr sub139                   ; 96d9: 20 03 a1
                sta arr18                    ; 96dc: 85 2c
                lda #0                       ; 96de: a9 00
                sta arr19                    ; 96e0: 85 2d
                jsr sub52                    ; 96e2: 20 5c 8b
                lda #5                       ; 96e5: a9 05
                sta arr18                    ; 96e7: 85 2c
                lda ram69                    ; 96e9: a5 82
                beq +                        ; 96eb: f0 02
                inc arr18                    ; 96ed: e6 2c
+               jsr sub48                    ; 96ef: 20 39 8b
                bcs +                        ; 96f2: b0 1e
                lda arr64                    ; 96f4: a5 8c
                sta ram14                    ; 96f6: 85 19
                sta arr18                    ; 96f8: 85 2c
                lda arr65                    ; 96fa: a5 8d
                sta ram15                    ; 96fc: 85 1a
                sta arr19                    ; 96fe: 85 2d
                jsr sub48                    ; 9700: 20 39 8b
                bcs +                        ; 9703: b0 0d
                lda ram2                     ; 9705: a5 04
                sta arr19                    ; 9707: 85 2d
                lda ram1                     ; 9709: a5 03
                sta arr18                    ; 970b: 85 2c
                jsr sub56                    ; 970d: 20 f7 8b
                bcc cod168                   ; 9710: 90 03
+               jmp cod61                    ; 9712: 4c 56 8a
cod168          ldy #0                       ; 9715: a0 00
                lda ram79                    ; 9717: a5 90
                sta (arr64),y                ; 9719: 91 8c
                iny                          ; 971b: c8
                lda ram76                    ; 971c: a5 8a
                sta (arr64),y                ; 971e: 91 8c
                iny                          ; 9720: c8
                lda ram77                    ; 9721: a5 8b
                sta (arr64),y                ; 9723: 91 8c
                iny                          ; 9725: c8
                lda ram69                    ; 9726: a5 82
                sta (arr64),y                ; 9728: 91 8c
                iny                          ; 972a: c8
                lda ram66                    ; 972b: a5 7e
                sta (arr64),y                ; 972d: 91 8c
                lda ram69                    ; 972f: a5 82
                beq +                        ; 9731: f0 05
                iny                          ; 9733: c8
                lda ram67                    ; 9734: a5 7f
                sta (arr64),y                ; 9736: 91 8c
+               lda ram24                    ; 9738: a5 28
                sta arr13                    ; 973a: 85 1f
                lda ram25                    ; 973c: a5 29
                sta arr14                    ; 973e: 85 20
                clc                          ; 9740: 18
                ldx #5                       ; 9741: a2 05
                lda ram69                    ; 9743: a5 82
                beq +                        ; 9745: f0 01
                inx                          ; 9747: e8
+               txa                          ; 9748: 8a
                adc ram14                    ; 9749: 65 19
                sta ram14                    ; 974b: 85 19
                lda #0                       ; 974d: a9 00
                adc ram15                    ; 974f: 65 1a
                sta ram15                    ; 9751: 85 1a
-               ldy #0                       ; 9753: a0 00
                lda #0                       ; 9755: a9 00
                sta (ram14),y                ; 9757: 91 19
                inc ram14                    ; 9759: e6 19
                bne +                        ; 975b: d0 02
                inc ram15                    ; 975d: e6 1a
+               lda ram15                    ; 975f: a5 1a
                cmp arr14                    ; 9761: c5 20
                bne -                        ; 9763: d0 ee
                lda ram14                    ; 9765: a5 19
                cmp arr13                    ; 9767: c5 1f
                bne -                        ; 9769: d0 e8
                ldy #0                       ; 976b: a0 00
                lda #0                       ; 976d: a9 00
                sta (ram14),y                ; 976f: 91 19
                iny                          ; 9771: c8
                sta (ram14),y                ; 9772: 91 19
                iny                          ; 9774: c8
                sta (ram14),y                ; 9775: 91 19
                rts                          ; 9777: 60
sub103          lda ram64                    ; 9778: a5 7c
                sta ram76                    ; 977a: 85 8a
                lda ram65                    ; 977c: a5 7d
                sta ram77                    ; 977e: 85 8b
                lda ram70                    ; 9780: a5 84
                ora #%10000000               ; 9782: 09 80
                sta ram79                    ; 9784: 85 90
                jsr sub141                   ; 9786: 20 0e a1
                jmp cod231                   ; 9789: 4c 07 a0
                jsr sub108                   ; 978c: 20 69 98
                jsr sub110                   ; 978f: 20 b4 98
                lda #2                       ; 9792: a9 02
                sta arr160                   ; 9794: 8d 00 05
                lda arr4                     ; 9797: a5 05
                sta ram204                   ; 9799: 8d 14 05
                sta arr18                    ; 979c: 85 2c
                lda arr5                     ; 979e: a5 06
                sta ram205                   ; 97a0: 8d 15 05
                sta arr19                    ; 97a3: 85 2d
                lda ram3                     ; 97a5: a5 07
                sta ram24                    ; 97a7: 85 28
                lda arr6                     ; 97a9: a5 08
                sta ram25                    ; 97ab: 85 29
                jsr sub41                    ; 97ad: 20 6f 8a
                lda ram24                    ; 97b0: a5 28
                sta ram202                   ; 97b2: 8d 12 05
                lda ram25                    ; 97b5: a5 29
                sta ram203                   ; 97b7: 8d 13 05
                jsr sub104                   ; 97ba: 20 c3 97
                jsr sub227                   ; 97bd: 20 fc b4
                jmp sub228                   ; 97c0: 4c 0d b5
sub104          lda #$46                     ; 97c3: a9 46
                sta arr41                    ; 97c5: 85 52
                lda #$aa                     ; 97c7: a9 aa
                sta arr42                    ; 97c9: 85 53
                jsr sub32                    ; 97cb: 20 f8 87
                beq cod169                   ; 97ce: f0 18
sub105          lda #$4f                     ; 97d0: a9 4f
                sta arr41                    ; 97d2: 85 52
                lda #$aa                     ; 97d4: a9 aa
                sta arr42                    ; 97d6: 85 53
                jsr sub32                    ; 97d8: 20 f8 87
                beq cod169                   ; 97db: f0 0b
sub106          lda #$58                     ; 97dd: a9 58
                sta arr41                    ; 97df: 85 52
                lda #$aa                     ; 97e1: a9 aa
                sta arr42                    ; 97e3: 85 53
                jsr sub32                    ; 97e5: 20 f8 87
cod169          lda #1                       ; 97e8: a9 01
                sta arr41                    ; 97ea: 85 52
                lda #5                       ; 97ec: a9 05
                sta arr42                    ; 97ee: 85 53
                jsr sub32                    ; 97f0: 20 f8 87
                jmp sub194                   ; 97f3: 4c 07 ac
cod170          jsr sub106                   ; 97f6: 20 dd 97
                jmp cod171                   ; 97f9: 4c 0c 98
                ldx #0                       ; 97fc: a2 00
                stx arr71                    ; 97fe: 86 9f
                cmp #$8b                     ; 9800: c9 8b
                bne +                        ; 9802: d0 05
                dec arr71                    ; 9804: c6 9f
                jsr sub60                    ; 9806: 20 a1 8c
+               jsr sub108                   ; 9809: 20 69 98
cod171          jsr sub223                   ; 980c: 20 30 b4
                bcs cod172                   ; 980f: b0 53
                jsr sub111                   ; 9811: 20 c8 98
                bcs cod170                   ; 9814: b0 e0
                lda arr160                   ; 9816: ad 00 05
                cmp #2                       ; 9819: c9 02
                bne cod170                   ; 981b: d0 d9
                jsr sub105                   ; 981d: 20 d0 97
                lda arr71                    ; 9820: a5 9f
                beq +                        ; 9822: f0 06
                jsr sub221                   ; 9824: 20 f9 b3
                bcs cod172                   ; 9827: b0 3b
                rts                          ; 9829: 60
+               lda arr4                     ; 982a: a5 05
                sta ram204                   ; 982c: 8d 14 05
                lda arr5                     ; 982f: a5 06
                sta ram205                   ; 9831: 8d 15 05
                jsr sub222                   ; 9834: 20 01 b4
                bcs cod172                   ; 9837: b0 2b
                lda arr76                    ; 9839: a5 ad
                sta ram3                     ; 983b: 85 07
                lda ram99                    ; 983d: a5 ae
                sta arr6                     ; 983f: 85 08
                jsr sub107                   ; 9841: 20 5d 98
                jsr sub214                   ; 9844: 20 ab b3
                lda arr76                    ; 9847: a5 ad
                sta ram18                    ; 9849: 85 1d
                lda ram99                    ; 984b: a5 ae
                sta ram19                    ; 984d: 85 1e
                jsr sub107                   ; 984f: 20 5d 98
                jsr sub214                   ; 9852: 20 ab b3
                lda arr76                    ; 9855: a5 ad
                sta arr13                    ; 9857: 85 1f
                lda ram99                    ; 9859: a5 ae
                sta arr14                    ; 985b: 85 20
sub107          ldy #0                       ; 985d: a0 00
                lda #0                       ; 985f: a9 00
                sta (arr76),y                ; 9861: 91 ad
                rts                          ; 9863: 60
cod172          lda #$11                     ; 9864: a9 11
                jmp cod287                   ; 9866: 4c 8f a9
sub108          jsr sub109                   ; 9869: 20 a1 98
                lda #0                       ; 986c: a9 00
                sta ram105                   ; 986e: 85 b5
                jsr sub13                    ; 9870: 20 78 83
                beq +                        ; 9873: f0 2b
                jsr sub121                   ; 9875: 20 7c 9c
                lda arr145                   ; 9878: ad 01 04
                sta ram14                    ; 987b: 85 19
                lda arr146                   ; 987d: ad 02 04
                sta ram15                    ; 9880: 85 1a
                lda arr144                   ; 9882: ad 00 04
                beq +                        ; 9885: f0 19
                ldy #0                       ; 9887: a0 00
                ldx #0                       ; 9889: a2 00
-               lda (ram14),y                ; 988b: b1 19
                sta arr167,x                 ; 988d: 9d 80 05
                inx                          ; 9890: e8
                iny                          ; 9891: c8
                dec arr144                   ; 9892: ce 00 04
                bne -                        ; 9895: d0 f4
                lda #0                       ; 9897: a9 00
                sta arr167,x                 ; 9899: 9d 80 05
                lda #1                       ; 989c: a9 01
                sta ram105                   ; 989e: 85 b5
+               rts                          ; 98a0: 60
sub109          ldx #0                       ; 98a1: a2 00
                ldy #$10                     ; 98a3: a0 10
                lda #$20                     ; 98a5: a9 20
-               sta arr167,x                 ; 98a7: 9d 80 05
                inx                          ; 98aa: e8
                dey                          ; 98ab: 88
                bne -                        ; 98ac: d0 f9
                lda #0                       ; 98ae: a9 00
                sta arr167,x                 ; 98b0: 9d 80 05
                rts                          ; 98b3: 60
sub110          ldx #0                       ; 98b4: a2 00
                ldy #$10                     ; 98b6: a0 10
-               lda arr167,x                 ; 98b8: bd 80 05
                sta arr161,x                 ; 98bb: 9d 01 05
                inx                          ; 98be: e8
                dey                          ; 98bf: 88
                bne -                        ; 98c0: d0 f6
                lda #0                       ; 98c2: a9 00
                sta arr161,x                 ; 98c4: 9d 01 05
                rts                          ; 98c7: 60
sub111          lda ram105                   ; 98c8: a5 b5
                beq +                        ; 98ca: f0 10
                ldx #0                       ; 98cc: a2 00
                ldy #$10                     ; 98ce: a0 10
-               lda arr161,x                 ; 98d0: bd 01 05
                cmp arr167,x                 ; 98d3: dd 80 05
                bne cod173                   ; 98d6: d0 06
                inx                          ; 98d8: e8
                dey                          ; 98d9: 88
                bne -                        ; 98da: d0 f4
+               clc                          ; 98dc: 18
                rts                          ; 98dd: 60
cod173          sec                          ; 98de: 38
                rts                          ; 98df: 60
                beq cod175                   ; 98e0: f0 18
                jsr sub94                    ; 98e2: 20 72 91
                jsr sub100                   ; 98e5: 20 98 95
                lda #3                       ; 98e8: a9 03
                clc                          ; 98ea: 18
                adc ram46                    ; 98eb: 65 5b
                sta ram102                   ; 98ed: 85 b2
                lda #0                       ; 98ef: a9 00
                adc ram47                    ; 98f1: 65 5c
cod174          sta ram103                   ; 98f3: 85 b3
                lda #0                       ; 98f5: a9 00
                sta ram104                   ; 98f7: 85 b4
                rts                          ; 98f9: 60
cod175          lda arr4                     ; 98fa: a5 05
                clc                          ; 98fc: 18
                adc #3                       ; 98fd: 69 03
                sta ram102                   ; 98ff: 85 b2
                lda #0                       ; 9901: a9 00
                adc arr5                     ; 9903: 65 06
                jmp cod174                   ; 9905: 4c f3 98
sub112          jsr sub63                    ; 9908: 20 c7 8c
                cmp #$80                     ; 990b: c9 80
                bcs +                        ; 990d: b0 15
                cmp #$12                     ; 990f: c9 12
                beq sub113                   ; 9911: f0 14
                cmp #$11                     ; 9913: c9 11
                beq sub113                   ; 9915: f0 10
                cmp #$0b                     ; 9917: c9 0b
                beq sub113                   ; 9919: f0 0c
                cmp #$22                     ; 991b: c9 22
                beq cod177                   ; 991d: f0 15
                jsr sub143                   ; 991f: 20 c3 a1
                bcc cod178                   ; 9922: 90 1e
+               jmp sub60                    ; 9924: 4c a1 8c
sub113          jsr sub60                    ; 9927: 20 a1 8c
                jsr sub60                    ; 992a: 20 a1 8c
                jmp sub60                    ; 992d: 4c a1 8c
cod176          pla                          ; 9930: 68
                jmp sub60                    ; 9931: 4c a1 8c
cod177          pha                          ; 9934: 48
-               jsr sub61                    ; 9935: 20 ad 8c
                cmp #$22                     ; 9938: c9 22
                beq cod176                   ; 993a: f0 f4
                and #%11111111               ; 993c: 29 ff
                bne -                        ; 993e: d0 f5
                pla                          ; 9940: 68
                rts                          ; 9941: 60
cod178          pha                          ; 9942: 48
-               jsr sub61                    ; 9943: 20 ad 8c
                jsr sub142                   ; 9946: 20 bb a1
                bcc -                        ; 9949: 90 f8
                pla                          ; 994b: 68
                rts                          ; 994c: 60
cod179          jsr sub135                   ; 994d: 20 75 9f
                jsr sub89                    ; 9950: 20 f8 8f
cod180          lda ram102                   ; 9953: a5 b2
                sta ram4                     ; 9955: 85 09
                lda ram103                   ; 9957: a5 b3
                sta ram5                     ; 9959: 85 0a
                lda ram104                   ; 995b: a5 b4
                bne cod182                   ; 995d: d0 26
-               jsr sub63                    ; 995f: 20 c7 8c
                beq +                        ; 9962: f0 0a
                cmp #$91                     ; 9964: c9 91
                beq cod181                   ; 9966: f0 16
                jsr sub112                   ; 9968: 20 08 99
                jmp -                        ; 996b: 4c 5f 99
+               jsr sub61                    ; 996e: 20 ad 8c
                beq +                        ; 9971: f0 06
                jsr sub113                   ; 9973: 20 27 99
                jmp -                        ; 9976: 4c 5f 99
+               lda #3                       ; 9979: a9 03
                jmp cod287                   ; 997b: 4c 8f a9
cod181          lda #$ff                     ; 997e: a9 ff
                sta ram104                   ; 9980: 85 b4
                jsr sub112                   ; 9982: 20 08 99
cod182          lda ram79                    ; 9985: a5 90
                and #%00001111               ; 9987: 29 0f
                cmp #3                       ; 9989: c9 03
                beq cod186                   ; 998b: f0 3e
                jsr sub161                   ; 998d: 20 fe a4
                ldy #0                       ; 9990: a0 00
                lda ram24                    ; 9992: a5 28
                sta (arr64),y                ; 9994: 91 8c
                lda ram25                    ; 9996: a5 29
                iny                          ; 9998: c8
                sta (arr64),y                ; 9999: 91 8c
                jsr sub13                    ; 999b: 20 78 83
                beq +                        ; 999e: f0 06
                jsr sub165                   ; 99a0: 20 94 a5
                jmp cod183                   ; 99a3: 4c aa 99
+               lda #0                       ; 99a6: a9 00
                sta ram104                   ; 99a8: 85 b4
cod183          lda ram4                     ; 99aa: a5 09
                sta ram102                   ; 99ac: 85 b2
                lda ram5                     ; 99ae: a5 0a
                sta ram103                   ; 99b0: 85 b3
                jsr sub90                    ; 99b2: 20 01 90
                jsr sub64                    ; 99b5: 20 d4 8c
                cmp #$2c                     ; 99b8: c9 2c
                beq cod185                   ; 99ba: f0 01
cod184          rts                          ; 99bc: 60
cod185          jsr sub60                    ; 99bd: 20 a1 8c
                jsr sub64                    ; 99c0: 20 d4 8c
                jsr sub143                   ; 99c3: 20 c3 a1
                bcs cod184                   ; 99c6: b0 f4
                jmp cod179                   ; 99c8: 4c 4d 99
cod186          lda #0                       ; 99cb: a9 00
                sta ram16                    ; 99cd: 85 1b
                tax                          ; 99cf: aa
                lda #$2c                     ; 99d0: a9 2c
                sta ram36                    ; 99d2: 85 3c
                jsr sub64                    ; 99d4: 20 d4 8c
                cmp #$22                     ; 99d7: c9 22
                bne cod187                   ; 99d9: d0 05
                sta ram36                    ; 99db: 85 3c
                jsr sub60                    ; 99dd: 20 a1 8c
cod187          lda (ram4),y                 ; 99e0: b1 09
                beq cod188                   ; 99e2: f0 20
                cmp ram36                    ; 99e4: c5 3c
                beq +                        ; 99e6: f0 0c
                sta arr191,x                 ; 99e8: 9d 00 07
                inc ram16                    ; 99eb: e6 1b
                inx                          ; 99ed: e8
                jsr sub60                    ; 99ee: 20 a1 8c
                jmp cod187                   ; 99f1: 4c e0 99
+               jsr sub60                    ; 99f4: 20 a1 8c
                jsr sub64                    ; 99f7: 20 d4 8c
                cmp #$2c                     ; 99fa: c9 2c
                bne cod189                   ; 99fc: d0 0a
                jsr sub60                    ; 99fe: 20 a1 8c
                jmp cod189                   ; 9a01: 4c 08 9a
cod188          lda #0                       ; 9a04: a9 00
                sta ram104                   ; 9a06: 85 b4
cod189          lda ram16                    ; 9a08: a5 1b
                sta arr144                   ; 9a0a: 8d 00 04
                lda #0                       ; 9a0d: a9 00
                sta arr145                   ; 9a0f: 8d 01 04
                lda #7                       ; 9a12: a9 07
                sta arr146                   ; 9a14: 8d 02 04
                jsr sub11                    ; 9a17: 20 ef 82
                jmp cod183                   ; 9a1a: 4c aa 99
                jsr sub121                   ; 9a1d: 20 7c 9c
                lda arr144                   ; 9a20: ad 00 04
                beq +                        ; 9a23: f0 60
                lda ram4                     ; 9a25: a5 09
                pha                          ; 9a27: 48
                lda ram5                     ; 9a28: a5 0a
                pha                          ; 9a2a: 48
                lda arr145                   ; 9a2b: ad 01 04
                sta ram4                     ; 9a2e: 85 09
                lda arr146                   ; 9a30: ad 02 04
                sta ram5                     ; 9a33: 85 0a
                lda #7                       ; 9a35: a9 07
                sta ram81                    ; 9a37: 85 92
                lda #0                       ; 9a39: a9 00
                sta ram80                    ; 9a3b: 85 91
                sta arr84                    ; 9a3d: 85 c6
                jsr sub117                   ; 9a3f: 20 40 9c
                lda #$21                     ; 9a42: a9 21
                sta ram80                    ; 9a44: 85 91
                sta ram116                   ; 9a46: 85 c7
                jsr sub117                   ; 9a48: 20 40 9c
                lda #$42                     ; 9a4b: a9 42
                sta ram80                    ; 9a4d: 85 91
                sta ram117                   ; 9a4f: 85 c8
                jsr sub117                   ; 9a51: 20 40 9c
                lda #1                       ; 9a54: a9 01
                sta arr86                    ; 9a56: 85 cb
                sta ram119                   ; 9a58: 85 cc
                sta ram120                   ; 9a5a: 85 cd
                lda #$7f                     ; 9a5c: a9 7f
                sta sq1_sweep                ; 9a5e: 8d 01 40
                sta sq2_sweep                ; 9a61: 8d 05 40
                lda #7                       ; 9a64: a9 07
                sta ram118                   ; 9a66: 85 c9
                sta snd_chn                  ; 9a68: 8d 15 40
                lda #$0a                     ; 9a6b: a9 0a
                sta ram52                    ; 9a6d: 85 63
-               jsr sub27                    ; 9a6f: 20 d4 86
                lda ram118                   ; 9a72: a5 c9
                bmi cod190                   ; 9a74: 30 10
                bne -                        ; 9a76: d0 f7
                lda #0                       ; 9a78: a9 00
                sta ram52                    ; 9a7a: 85 63
                sta snd_chn                  ; 9a7c: 8d 15 40
                pla                          ; 9a7f: 68
                sta ram5                     ; 9a80: 85 0a
                pla                          ; 9a82: 68
                sta ram4                     ; 9a83: 85 09
+               rts                          ; 9a85: 60
cod190          lda #0                       ; 9a86: a9 00
                sta ram52                    ; 9a88: 85 63
                sta snd_chn                  ; 9a8a: 8d 15 40
                jmp cod24                    ; 9a8d: 4c 6d 83
                txa                          ; 9a90: 8a
                pha                          ; 9a91: 48
                tya                          ; 9a92: 98
                pha                          ; 9a93: 48
                lda #$c0                     ; 9a94: a9 c0
                sta joypad2                  ; 9a96: 8d 17 40
                jsr sub114                   ; 9a99: 20 a2 9a
                pla                          ; 9a9c: 68
                tay                          ; 9a9d: a8
                pla                          ; 9a9e: 68
                tax                          ; 9a9f: aa
                pla                          ; 9aa0: 68
                rti                          ; 9aa1: 40
sub114          lda #2                       ; 9aa2: a9 02
                sta arr85                    ; 9aa4: 85 ca
                lda #4                       ; 9aa6: a9 04
                sta arr87                    ; 9aa8: 85 ce
-               lda ram118                   ; 9aaa: a5 c9
                bmi cod191                   ; 9aac: 30 09
                jsr sub115                   ; 9aae: 20 b8 9a
                lsr arr87                    ; 9ab1: 46 ce
                dec arr85                    ; 9ab3: c6 ca
                bpl -                        ; 9ab5: 10 f3
cod191          rts                          ; 9ab7: 60
sub115          lda ram118                   ; 9ab8: a5 c9
                and arr87                    ; 9aba: 25 ce
                beq cod191                   ; 9abc: f0 f9
                ldx arr85                    ; 9abe: a6 ca
                dec arr86,x                  ; 9ac0: d6 cb
                bne cod191                   ; 9ac2: d0 f3
                lda arr84,x                  ; 9ac4: b5 c6
                sta ram80                    ; 9ac6: 85 91
                lda #0                       ; 9ac8: a9 00
                sta ram114                   ; 9aca: 85 c2
cod192          ldy #0                       ; 9acc: a0 00
                lda (ram80),y                ; 9ace: b1 91
                bne +                        ; 9ad0: d0 11
                lda ram118                   ; 9ad2: a5 c9
                sec                          ; 9ad4: 38
                sbc arr87                    ; 9ad5: e5 ce
                sta ram118                   ; 9ad7: 85 c9
                sta snd_chn                  ; 9ad9: 8d 15 40
                ldx arr85                    ; 9adc: a6 ca
                lda ram80                    ; 9ade: a5 91
                sta arr84,x                  ; 9ae0: 95 c6
                rts                          ; 9ae2: 60
+               inc ram80                    ; 9ae3: e6 91
                cmp #$20                     ; 9ae5: c9 20
                beq cod192                   ; 9ae7: f0 e3
                cmp #$4d                     ; 9ae9: c9 4d
                bne cod193                   ; 9aeb: d0 18
                lda (ram80),y                ; 9aed: b1 91
                beq cod197                   ; 9aef: f0 79
                ldx #$30                     ; 9af1: a2 30
                cmp #$30                     ; 9af3: c9 30
                beq +                        ; 9af5: f0 06
                cmp #$31                     ; 9af7: c9 31
                bne cod197                   ; 9af9: d0 6f
                ldx #0                       ; 9afb: a2 00
+               inc ram80                    ; 9afd: e6 91
                ldy arr85                    ; 9aff: a4 ca
                stx arr88,y                  ; 9b01: 96 cf
                bpl cod192                   ; 9b03: 10 c7
cod193          cmp #$4f                     ; 9b05: c9 4f
                bne +                        ; 9b07: d0 15
                lda (ram80),y                ; 9b09: b1 91
                beq cod197                   ; 9b0b: f0 5d
                inc ram80                    ; 9b0d: e6 91
                cmp #$36                     ; 9b0f: c9 36
                bcs cod197                   ; 9b11: b0 57
                sec                          ; 9b13: 38
                sbc #$30                     ; 9b14: e9 30
                bcc cod197                   ; 9b16: 90 52
                ldx arr85                    ; 9b18: a6 ca
                sta arr81,x                  ; 9b1a: 95 bf
                bpl cod192                   ; 9b1c: 10 ae
+               cmp #$54                     ; 9b1e: c9 54
                bne cod195                   ; 9b20: d0 17
                lda (ram80),y                ; 9b22: b1 91
                beq cod197                   ; 9b24: f0 44
                inc ram80                    ; 9b26: e6 91
                cmp #$39                     ; 9b28: c9 39
                bcs cod197                   ; 9b2a: b0 3e
                sec                          ; 9b2c: 38
                sbc #$30                     ; 9b2d: e9 30
                beq cod197                   ; 9b2f: f0 39
                bcc cod197                   ; 9b31: 90 37
                ldx arr85                    ; 9b33: a6 ca
                sta arr78,x                  ; 9b35: 95 b9
cod194          bpl cod192                   ; 9b37: 10 93
cod195          cmp #$56                     ; 9b39: c9 56
                bne cod198                   ; 9b3b: d0 32
                lda (ram80),y                ; 9b3d: b1 91
                beq cod197                   ; 9b3f: f0 29
                inc ram80                    ; 9b41: e6 91
                cmp #$3a                     ; 9b43: c9 3a
                bcs cod197                   ; 9b45: b0 23
                sec                          ; 9b47: 38
                sbc #$30                     ; 9b48: e9 30
                bcc cod197                   ; 9b4a: 90 1e
                cmp #1                       ; 9b4c: c9 01
                bne cod196                   ; 9b4e: d0 14
                lda (ram80),y                ; 9b50: b1 91
                cmp #$36                     ; 9b52: c9 36
                bcs +                        ; 9b54: b0 0c
                sec                          ; 9b56: 38
                sbc #$30                     ; 9b57: e9 30
                bcc +                        ; 9b59: 90 07
                clc                          ; 9b5b: 18
                adc #$0a                     ; 9b5c: 69 0a
                inc ram80                    ; 9b5e: e6 91
                bne cod196                   ; 9b60: d0 02
+               lda #1                       ; 9b62: a9 01
cod196          ldx arr85                    ; 9b64: a6 ca
                sta arr79,x                  ; 9b66: 95 bc
                bpl cod194                   ; 9b68: 10 cd
cod197          lda #$80                     ; 9b6a: a9 80
                sta ram118                   ; 9b6c: 85 c9
                rts                          ; 9b6e: 60
cod198          cmp #$59                     ; 9b6f: c9 59
                bne +                        ; 9b71: d0 16
                lda (ram80),y                ; 9b73: b1 91
                cmp #$34                     ; 9b75: c9 34
                bcs cod197                   ; 9b77: b0 f1
                sec                          ; 9b79: 38
                sbc #$30                     ; 9b7a: e9 30
                bcc cod197                   ; 9b7c: 90 ec
                inc ram80                    ; 9b7e: e6 91
                lsr a                        ; 9b80: 4a
                ror a                        ; 9b81: 6a
                ror a                        ; 9b82: 6a
                ldx arr85                    ; 9b83: a6 ca
                sta arr90,x                  ; 9b85: 95 d2
                bpl cod194                   ; 9b87: 10 ae
+               cmp #$23                     ; 9b89: c9 23
                bne +                        ; 9b8b: d0 06
                lda #2                       ; 9b8d: a9 02
                sta ram114                   ; 9b8f: 85 c2
                bpl cod194                   ; 9b91: 10 a4
+               cmp #$52                     ; 9b93: c9 52
                bne cod199                   ; 9b95: d0 14
                jsr sub116                   ; 9b97: 20 0e 9c
dat13           lda arr85                    ; 9b9a: a5 ca
dat14           asl a                        ; 9b9c: 0a
                asl a                        ; 9b9d: 0a
                tay                          ; 9b9e: a8
                lda #$90                     ; 9b9f: a9 90
                cpy #8                       ; 9ba1: c0 08
                bne +                        ; 9ba3: d0 02
                lda #0                       ; 9ba5: a9 00
+               sta sq1_vol,y                ; 9ba7: 99 00 40
                rts                          ; 9baa: 60
cod199          cmp #$41                     ; 9bab: c9 41
                bcc cod197                   ; 9bad: 90 bb
                cmp #$48                     ; 9baf: c9 48
                bcs cod197                   ; 9bb1: b0 b7
                pha                          ; 9bb3: 48
                jsr sub116                   ; 9bb4: 20 0e 9c
                ldx arr85                    ; 9bb7: a6 ca
                txa                          ; 9bb9: 8a
                asl a                        ; 9bba: 0a
                asl a                        ; 9bbb: 0a
                tay                          ; 9bbc: a8
                cmp #8                       ; 9bbd: c9 08
                bne cod200                   ; 9bbf: d0 17
                lda arr86,x                  ; 9bc1: b5 cb
                sec                          ; 9bc3: 38
                sbc #1                       ; 9bc4: e9 01
                cmp #$0e                     ; 9bc6: c9 0e
                bcc +                        ; 9bc8: 90 02
                lda #$0e                     ; 9bca: a9 0e
+               asl a                        ; 9bcc: 0a
                asl a                        ; 9bcd: 0a
                ldy arr88,x                  ; 9bce: b4 cf
                beq +                        ; 9bd0: f0 02
                lda #$81                     ; 9bd2: a9 81
+               ldy #8                       ; 9bd4: a0 08
                bne cod201                   ; 9bd6: d0 06
cod200          lda arr79,x                  ; 9bd8: b5 bc
                ora arr90,x                  ; 9bda: 15 d2
                ora arr88,x                  ; 9bdc: 15 cf
cod201          sta sq1_vol,y                ; 9bde: 99 00 40
                pla                          ; 9be1: 68
                sec                          ; 9be2: 38
                sbc #$41                     ; 9be3: e9 41
                tay                          ; 9be5: a8
                lda arr81,x                  ; 9be6: b5 bf
                tax                          ; 9be8: aa
                lda $80a7,x                  ; 9be9: bd a7 80
                clc                          ; 9bec: 18
                adc $80a0,y                  ; 9bed: 79 a0 80
                adc ram114                   ; 9bf0: 65 c2
                tax                          ; 9bf2: aa
                lda arr85                    ; 9bf3: a5 ca
                asl a                        ; 9bf5: 0a
                asl a                        ; 9bf6: 0a
                tay                          ; 9bf7: a8
                cmp #8                       ; 9bf8: c9 08
                bne +                        ; 9bfa: d0 05
                txa                          ; 9bfc: 8a
                clc                          ; 9bfd: 18
                adc #$18                     ; 9bfe: 69 18
                tax                          ; 9c00: aa
+               lda dat1,x                   ; 9c01: bd 06 80
                sta sq1_lo,y                 ; 9c04: 99 02 40
                lda $8007,x                  ; 9c07: bd 07 80
                sta sq1_hi,y                 ; 9c0a: 99 03 40
                rts                          ; 9c0d: 60
sub116          lda (ram80),y                ; 9c0e: b1 91
                beq +                        ; 9c10: f0 13
                cmp #$3a                     ; 9c12: c9 3a
                bcs +                        ; 9c14: b0 0f
                sec                          ; 9c16: 38
                sbc #$30                     ; 9c17: e9 30
                bcc +                        ; 9c19: 90 0a
                tax                          ; 9c1b: aa
                lda dat3,x                   ; 9c1c: bd 96 80
                ldx arr85                    ; 9c1f: a6 ca
                sta arr82,x                  ; 9c21: 95 c3
                inc ram80                    ; 9c23: e6 91
+               jsr sub144                   ; 9c25: 20 cd a1
                ldx arr85                    ; 9c28: a6 ca
                lda arr82,x                  ; 9c2a: b5 c3
                sta ram24                    ; 9c2c: 85 28
                lda arr78,x                  ; 9c2e: b5 b9
                sta arr18                    ; 9c30: 85 2c
                jsr sub52                    ; 9c32: 20 5c 8b
                lda ram24                    ; 9c35: a5 28
                ldx arr85                    ; 9c37: a6 ca
                sta arr86,x                  ; 9c39: 95 cb
                lda ram80                    ; 9c3b: a5 91
                sta arr84,x                  ; 9c3d: 95 c6
                rts                          ; 9c3f: 60
sub117          lda arr144                   ; 9c40: ad 00 04
                beq +                        ; 9c43: f0 12
                dec arr144                   ; 9c45: ce 00 04
                jsr sub59                    ; 9c48: 20 9d 8c
                cmp #$3a                     ; 9c4b: c9 3a
                beq +                        ; 9c4d: f0 08
                ldy #0                       ; 9c4f: a0 00
                sta (ram80),y                ; 9c51: 91 91
                inc ram80                    ; 9c53: e6 91
                bne sub117                   ; 9c55: d0 e9
+               ldy #0                       ; 9c57: a0 00
                lda #0                       ; 9c59: a9 00
                sta (ram80),y                ; 9c5b: 91 91
                rts                          ; 9c5d: 60
cod202          jmp cod24                    ; 9c5e: 4c 6d 83
cod203          jmp $8370                    ; 9c61: 4c 70 83
sub118          jsr sub60                    ; 9c64: 20 a1 8c
                jmp sub120                   ; 9c67: 4c 6d 9c
sub119          jsr sub165                   ; 9c6a: 20 94 a5
sub120          jsr sub122                   ; 9c6d: 20 82 9c
                jsr sub158                   ; 9c70: 20 ef a3
                lda arr145                   ; 9c73: ad 01 04
                bne cod203                   ; 9c76: d0 e9
                lda arr144                   ; 9c78: ad 00 04
                rts                          ; 9c7b: 60
sub121          jsr sub122                   ; 9c7c: 20 82 9c
                jmp $a3f2                    ; 9c7f: 4c f2 a3
sub122          lda #0                       ; 9c82: a9 00
                sta ram23                    ; 9c84: 85 27
                sta arr20                    ; 9c86: 85 30
                lda #$80                     ; 9c88: a9 80
                sta arr15                    ; 9c8a: 85 21
                jsr sub123                   ; 9c8c: 20 94 9c
                lda ram23                    ; 9c8f: a5 27
                beq cod202                   ; 9c91: f0 cb
                rts                          ; 9c93: 60
sub123          jsr sub124                   ; 9c94: 20 bd 9c
-               cmp #$ef                     ; 9c97: c9 ef
                beq +                        ; 9c99: f0 01
                rts                          ; 9c9b: 60
+               jsr sub158                   ; 9c9c: 20 ef a3
                jsr sub60                    ; 9c9f: 20 a1 8c
                jsr sub124                   ; 9ca2: 20 bd 9c
                jsr sub158                   ; 9ca5: 20 ef a3
                jsr sub132                   ; 9ca8: 20 e0 9d
                lda ram24                    ; 9cab: a5 28
                eor arr18                    ; 9cad: 45 2c
                sta ram24                    ; 9caf: 85 28
                lda ram25                    ; 9cb1: a5 29
                eor arr19                    ; 9cb3: 45 2d
                sta ram25                    ; 9cb5: 85 29
                jsr sub145                   ; 9cb7: 20 d7 a1
                jmp -                        ; 9cba: 4c 97 9c
sub124          jsr sub125                   ; 9cbd: 20 e6 9c
-               cmp #$f0                     ; 9cc0: c9 f0
                beq +                        ; 9cc2: f0 01
                rts                          ; 9cc4: 60
+               jsr sub158                   ; 9cc5: 20 ef a3
                jsr sub60                    ; 9cc8: 20 a1 8c
                jsr sub125                   ; 9ccb: 20 e6 9c
                jsr sub158                   ; 9cce: 20 ef a3
                jsr sub132                   ; 9cd1: 20 e0 9d
                lda ram24                    ; 9cd4: a5 28
                ora arr18                    ; 9cd6: 05 2c
                sta ram24                    ; 9cd8: 85 28
                lda ram25                    ; 9cda: a5 29
                ora arr19                    ; 9cdc: 05 2d
                sta ram25                    ; 9cde: 85 29
                jsr sub145                   ; 9ce0: 20 d7 a1
                jmp -                        ; 9ce3: 4c c0 9c
sub125          jsr sub126                   ; 9ce6: 20 0f 9d
-               cmp #$f1                     ; 9ce9: c9 f1
                beq +                        ; 9ceb: f0 01
                rts                          ; 9ced: 60
+               jsr sub158                   ; 9cee: 20 ef a3
                jsr sub60                    ; 9cf1: 20 a1 8c
                jsr sub126                   ; 9cf4: 20 0f 9d
                jsr sub158                   ; 9cf7: 20 ef a3
                jsr sub132                   ; 9cfa: 20 e0 9d
                lda ram24                    ; 9cfd: a5 28
                and arr18                    ; 9cff: 25 2c
                sta ram24                    ; 9d01: 85 28
                lda ram25                    ; 9d03: a5 29
                and arr19                    ; 9d05: 25 2d
                sta ram25                    ; 9d07: 85 29
                jsr sub145                   ; 9d09: 20 d7 a1
                jmp -                        ; 9d0c: 4c e9 9c
sub126          jsr sub128                   ; 9d0f: 20 4e 9d
cod204          cmp #$f3                     ; 9d12: c9 f3
                bcs cod206                   ; 9d14: b0 01
cod205          rts                          ; 9d16: 60
cod206          cmp #$f9                     ; 9d17: c9 f9
                bcs cod205                   ; 9d19: b0 fb
                sec                          ; 9d1b: 38
                sbc #$f3                     ; 9d1c: e9 f3
                asl a                        ; 9d1e: 0a
                tax                          ; 9d1f: aa
                lda dat19,x                  ; 9d20: bd 7d a2
                pha                          ; 9d23: 48
                lda $a27e,x                  ; 9d24: bd 7e a2
                pha                          ; 9d27: 48
                lda ram23                    ; 9d28: a5 27
                pha                          ; 9d2a: 48
                jsr sub60                    ; 9d2b: 20 a1 8c
                jsr sub128                   ; 9d2e: 20 4e 9d
                pla                          ; 9d31: 68
                cmp ram23                    ; 9d32: c5 27
                bne cod210                   ; 9d34: d0 50
                jsr sub132                   ; 9d36: 20 e0 9d
                pla                          ; 9d39: 68
                sta ram15                    ; 9d3a: 85 1a
                pla                          ; 9d3c: 68
                sta ram14                    ; 9d3d: 85 19
                jsr sub127                   ; 9d3f: 20 4b 9d
                pha                          ; 9d42: 48
                lda #2                       ; 9d43: a9 02
                sta ram23                    ; 9d45: 85 27
                pla                          ; 9d47: 68
                jmp cod204                   ; 9d48: 4c 12 9d
sub127          jmp (ram14)                  ; 9d4b: 6c 19 00
sub128          jsr sub130                   ; 9d4e: 20 89 9d
cod207          cmp #$f9                     ; 9d51: c9 f9
                beq +                        ; 9d53: f0 05
                cmp #$fa                     ; 9d55: c9 fa
                beq cod208                   ; 9d57: f0 0a
                rts                          ; 9d59: 60
+               lda #$d4                     ; 9d5a: a9 d4
                pha                          ; 9d5c: 48
                lda #$a1                     ; 9d5d: a9 a1
                pha                          ; 9d5f: 48
                jmp cod209                   ; 9d60: 4c 69 9d
cod208          lda #$ee                     ; 9d63: a9 ee
                pha                          ; 9d65: 48
                lda #$a1                     ; 9d66: a9 a1
                pha                          ; 9d68: 48
cod209          lda ram23                    ; 9d69: a5 27
sub129          pha                          ; 9d6b: 48
                jsr sub60                    ; 9d6c: 20 a1 8c
                jsr sub130                   ; 9d6f: 20 89 9d
                pla                          ; 9d72: 68
                cmp ram23                    ; 9d73: c5 27
                bne cod210                   ; 9d75: d0 0f
                jsr sub132                   ; 9d77: 20 e0 9d
                pla                          ; 9d7a: 68
                sta ram15                    ; 9d7b: 85 1a
                pla                          ; 9d7d: 68
                sta ram14                    ; 9d7e: 85 19
                jsr sub127                   ; 9d80: 20 4b 9d
                jmp cod207                   ; 9d83: 4c 51 9d
cod210          jmp cod262                   ; 9d86: 4c e1 a3
sub130          jsr sub131                   ; 9d89: 20 a8 9d
-               cmp #$fb                     ; 9d8c: c9 fb
                beq +                        ; 9d8e: f0 01
                rts                          ; 9d90: 60
+               lda ram23                    ; 9d91: a5 27
                pha                          ; 9d93: 48
                jsr sub60                    ; 9d94: 20 a1 8c
                jsr sub131                   ; 9d97: 20 a8 9d
                pla                          ; 9d9a: 68
                cmp ram23                    ; 9d9b: c5 27
                bne cod210                   ; 9d9d: d0 e7
                jsr sub132                   ; 9d9f: 20 e0 9d
                jsr sub147                   ; 9da2: 20 1d a2
                jmp -                        ; 9da5: 4c 8c 9d
sub131          jsr sub134                   ; 9da8: 20 ab 9e
cod211          cmp #$fc                     ; 9dab: c9 fc
                beq +                        ; 9dad: f0 05
                cmp #$fd                     ; 9daf: c9 fd
                beq cod212                   ; 9db1: f0 0a
                rts                          ; 9db3: 60
+               lda #$fa                     ; 9db4: a9 fa
                pha                          ; 9db6: 48
                lda #$a1                     ; 9db7: a9 a1
                pha                          ; 9db9: 48
                jmp cod213                   ; 9dba: 4c c3 9d
cod212          lda #$f4                     ; 9dbd: a9 f4
                pha                          ; 9dbf: 48
                lda #$a1                     ; 9dc0: a9 a1
                pha                          ; 9dc2: 48
cod213          lda ram23                    ; 9dc3: a5 27
                pha                          ; 9dc5: 48
                jsr sub60                    ; 9dc6: 20 a1 8c
                jsr sub134                   ; 9dc9: 20 ab 9e
                pla                          ; 9dcc: 68
                cmp ram23                    ; 9dcd: c5 27
                bne cod210                   ; 9dcf: d0 b5
                jsr sub132                   ; 9dd1: 20 e0 9d
                pla                          ; 9dd4: 68
                sta ram15                    ; 9dd5: 85 1a
                pla                          ; 9dd7: 68
                sta ram14                    ; 9dd8: 85 19
                jsr sub127                   ; 9dda: 20 4b 9d
                jmp cod211                   ; 9ddd: 4c ab 9d
sub132          ldx arr20                    ; 9de0: a6 30
                cpx #$7d                     ; 9de2: e0 7d
                bcs cod214                   ; 9de4: b0 3d
                dex                          ; 9de6: ca
                dex                          ; 9de7: ca
                dex                          ; 9de8: ca
                stx arr20                    ; 9de9: 86 30
                lda arr144,x                 ; 9deb: bd 00 04
                sta arr18                    ; 9dee: 85 2c
                lda arr145,x                 ; 9df0: bd 01 04
                sta arr19                    ; 9df3: 85 2d
                lda arr146,x                 ; 9df5: bd 02 04
                sta ram28                    ; 9df8: 85 2e
                dex                          ; 9dfa: ca
                dex                          ; 9dfb: ca
                dex                          ; 9dfc: ca
                lda arr144,x                 ; 9dfd: bd 00 04
                sta ram24                    ; 9e00: 85 28
                lda arr145,x                 ; 9e02: bd 01 04
                sta ram25                    ; 9e05: 85 29
                lda arr146,x                 ; 9e07: bd 02 04
                sta ram26                    ; 9e0a: 85 2a
                rts                          ; 9e0c: 60
sub133          jsr sub60                    ; 9e0d: 20 a1 8c
                jsr sub134                   ; 9e10: 20 ab 9e
                ldx arr20                    ; 9e13: a6 30
                dex                          ; 9e15: ca
                dex                          ; 9e16: ca
                dex                          ; 9e17: ca
                lda arr144,x                 ; 9e18: bd 00 04
                sta ram24                    ; 9e1b: 85 28
                lda arr145,x                 ; 9e1d: bd 01 04
                sta ram25                    ; 9e20: 85 29
                rts                          ; 9e22: 60
cod214          jmp $8370                    ; 9e23: 4c 70 83
cod215          jsr sub133                   ; 9e26: 20 0d 9e
                jsr sub43                    ; 9e29: 20 7c 8a
                lda ram24                    ; 9e2c: a5 28
                sta arr144,x                 ; 9e2e: 9d 00 04
                lda ram25                    ; 9e31: a5 29
                sta arr145,x                 ; 9e33: 9d 01 04
                jmp sub64                    ; 9e36: 4c d4 8c
cod216          jsr sub133                   ; 9e39: 20 0d 9e
                lda #$ff                     ; 9e3c: a9 ff
                sec                          ; 9e3e: 38
                sbc arr144,x                 ; 9e3f: fd 00 04
                sta arr144,x                 ; 9e42: 9d 00 04
                lda #$ff                     ; 9e45: a9 ff
                sec                          ; 9e47: 38
                sbc arr145,x                 ; 9e48: fd 01 04
                sta arr145,x                 ; 9e4b: 9d 01 04
                lda #2                       ; 9e4e: a9 02
                sta ram23                    ; 9e50: 85 27
                rts                          ; 9e52: 60
cod217          jsr sub60                    ; 9e53: 20 a1 8c
                ldy #0                       ; 9e56: a0 00
                ldx arr15                    ; 9e58: a6 21
-               lda (ram4),y                 ; 9e5a: b1 09
                beq cod218                   ; 9e5c: f0 13
                cmp #$22                     ; 9e5e: c9 22
                beq +                        ; 9e60: f0 0c
                sta arr191,x                 ; 9e62: 9d 00 07
                inx                          ; 9e65: e8
                iny                          ; 9e66: c8
                cpy #$20                     ; 9e67: c0 20
                beq cod214                   ; 9e69: f0 b8
                jmp -                        ; 9e6b: 4c 5a 9e
+               jsr sub60                    ; 9e6e: 20 a1 8c
cod218          stx ram14                    ; 9e71: 86 19
                sty ram79                    ; 9e73: 84 90
                tya                          ; 9e75: 98
                clc                          ; 9e76: 18
                adc ram4                     ; 9e77: 65 09
                sta ram4                     ; 9e79: 85 09
                lda #0                       ; 9e7b: a9 00
                adc ram5                     ; 9e7d: 65 0a
                sta ram5                     ; 9e7f: 85 0a
                ldx arr20                    ; 9e81: a6 30
                lda ram79                    ; 9e83: a5 90
                sta arr144,x                 ; 9e85: 9d 00 04
                lda arr15                    ; 9e88: a5 21
                sta arr145,x                 ; 9e8a: 9d 01 04
                lda #7                       ; 9e8d: a9 07
                sta arr146,x                 ; 9e8f: 9d 02 04
                inx                          ; 9e92: e8
                inx                          ; 9e93: e8
                inx                          ; 9e94: e8
                stx arr20                    ; 9e95: 86 30
                lda ram14                    ; 9e97: a5 19
                sta arr15                    ; 9e99: 85 21
                lda #3                       ; 9e9b: a9 03
                sta ram23                    ; 9e9d: 85 27
dat15           jmp sub64                    ; 9e9f: 4c d4 8c
cod219          jmp cod24                    ; 9ea2: 4c 6d 83
cod220          jmp cod215                   ; 9ea5: 4c 26 9e
cod221          jsr sub60                    ; 9ea8: 20 a1 8c
sub134          jsr sub13                    ; 9eab: 20 78 83
                beq cod219                   ; 9eae: f0 f2
                cmp #$fa                     ; 9eb0: c9 fa
                beq cod220                   ; 9eb2: f0 f1
                cmp #$f2                     ; 9eb4: c9 f2
                beq cod216                   ; 9eb6: f0 81
                cmp #$12                     ; 9eb8: c9 12
                beq cod224                   ; 9eba: f0 51
                cmp #$11                     ; 9ebc: c9 11
                beq cod224                   ; 9ebe: f0 4d
                cmp #$f9                     ; 9ec0: c9 f9
                beq cod221                   ; 9ec2: f0 e4
                cmp #$28                     ; 9ec4: c9 28
                beq cod223                   ; 9ec6: f0 39
                cmp #$22                     ; 9ec8: c9 22
                beq cod217                   ; 9eca: f0 87
                cmp #$41                     ; 9ecc: c9 41
                bcc +                        ; 9ece: 90 2b
                cmp #$5b                     ; 9ed0: c9 5b
                bcc cod225                   ; 9ed2: 90 57
                cmp #$a1                     ; 9ed4: c9 a1
                beq cod222                   ; 9ed6: f0 26
                cmp #$ca                     ; 9ed8: c9 ca
                bcc +                        ; 9eda: 90 1f
                cmp #$ef                     ; 9edc: c9 ef
                bcs +                        ; 9ede: b0 1b
                sec                          ; 9ee0: 38
                sbc #$ca                     ; 9ee1: e9 ca
                asl a                        ; 9ee3: 0a
                tax                          ; 9ee4: aa
                lda $c328,x                  ; 9ee5: bd 28 c3
                sta ram14                    ; 9ee8: 85 19
                lda dat73,x                  ; 9eea: bd 29 c3
                sta ram15                    ; 9eed: 85 1a
                jsr sub60                    ; 9eef: 20 a1 8c
                jsr sub64                    ; 9ef2: 20 d4 8c
                jsr sub127                   ; 9ef5: 20 4b 9d
                jmp sub64                    ; 9ef8: 4c d4 8c
+               jmp cod24                    ; 9efb: 4c 6d 83
cod222          jmp cod253                   ; 9efe: 4c 9d a2
cod223          jsr sub60                    ; 9f01: 20 a1 8c
                jsr sub123                   ; 9f04: 20 94 9c
                jsr sub148                   ; 9f07: 20 93 a2
                jmp sub64                    ; 9f0a: 4c d4 8c
cod224          ldx arr20                    ; 9f0d: a6 30
                ldy #1                       ; 9f0f: a0 01
                lda (ram4),y                 ; 9f11: b1 09
                sta arr144,x                 ; 9f13: 9d 00 04
                iny                          ; 9f16: c8
                inx                          ; 9f17: e8
                lda (ram4),y                 ; 9f18: b1 09
                sta arr144,x                 ; 9f1a: 9d 00 04
                inx                          ; 9f1d: e8
                inx                          ; 9f1e: e8
                stx arr20                    ; 9f1f: 86 30
                lda #2                       ; 9f21: a9 02
                sta ram23                    ; 9f23: 85 27
                jsr sub113                   ; 9f25: 20 27 99
                jmp sub64                    ; 9f28: 4c d4 8c
cod225          jsr sub136                   ; 9f2b: 20 7e 9f
                ldx arr20                    ; 9f2e: a6 30
                lda ram79                    ; 9f30: a5 90
                and #%00001111               ; 9f32: 29 0f
                cmp #3                       ; 9f34: c9 03
                beq cod227                   ; 9f36: f0 21
                ldy #0                       ; 9f38: a0 00
                lda (arr64),y                ; 9f3a: b1 8c
                sta arr144,x                 ; 9f3c: 9d 00 04
                iny                          ; 9f3f: c8
                lda (arr64),y                ; 9f40: b1 8c
                sta arr145,x                 ; 9f42: 9d 01 04
                iny                          ; 9f45: c8
                lda (arr64),y                ; 9f46: b1 8c
                sta arr146,x                 ; 9f48: 9d 02 04
cod226          inx                          ; 9f4b: e8
                inx                          ; 9f4c: e8
                inx                          ; 9f4d: e8
                stx arr20                    ; 9f4e: 86 30
                lda ram79                    ; 9f50: a5 90
                and #%00001111               ; 9f52: 29 0f
                sta ram23                    ; 9f54: 85 27
                jmp sub64                    ; 9f56: 4c d4 8c
cod227          ldy #0                       ; 9f59: a0 00
                lda (arr64),y                ; 9f5b: b1 8c
                sta arr144,x                 ; 9f5d: 9d 00 04
                lda #1                       ; 9f60: a9 01
                clc                          ; 9f62: 18
                adc arr64                    ; 9f63: 65 8c
                sta arr145,x                 ; 9f65: 9d 01 04
                lda #0                       ; 9f68: a9 00
                adc arr65                    ; 9f6a: 65 8d
                sta arr146,x                 ; 9f6c: 9d 02 04
                jmp cod226                   ; 9f6f: 4c 4b 9f
cod228          jmp cod24                    ; 9f72: 4c 6d 83
sub135          jsr sub143                   ; 9f75: 20 c3 a1
                bcs cod228                   ; 9f78: b0 f8
                ldx #0                       ; 9f7a: a2 00
                stx arr20                    ; 9f7c: 86 30
sub136          ldx #0                       ; 9f7e: a2 00
                stx ram77                    ; 9f80: 86 8b
                sta ram76                    ; 9f82: 85 8a
                jsr sub61                    ; 9f84: 20 ad 8c
                jsr sub142                   ; 9f87: 20 bb a1
                bcs +                        ; 9f8a: b0 0a
                sta ram77                    ; 9f8c: 85 8b
-               jsr sub61                    ; 9f8e: 20 ad 8c
                jsr sub142                   ; 9f91: 20 bb a1
                bcc -                        ; 9f94: 90 f8
+               lda #2                       ; 9f96: a9 02
                sta ram79                    ; 9f98: 85 90
                jsr sub64                    ; 9f9a: 20 d4 8c
                cmp #$24                     ; 9f9d: c9 24
                bne cod229                   ; 9f9f: d0 07
                lda #3                       ; 9fa1: a9 03
dat16           sta ram79                    ; 9fa3: 85 90
                jsr sub60                    ; 9fa5: 20 a1 8c
cod229          jsr sub64                    ; 9fa8: 20 d4 8c
                cmp #$28                     ; 9fab: c9 28
                beq cod235                   ; 9fad: f0 70
                jsr sub141                   ; 9faf: 20 0e a1
                bcs cod230                   ; 9fb2: b0 45
                ldy #0                       ; 9fb4: a0 00
                lda ram79                    ; 9fb6: a5 90
                sta (arr66),y                ; 9fb8: 91 8e
                iny                          ; 9fba: c8
                lda ram76                    ; 9fbb: a5 8a
                sta (arr66),y                ; 9fbd: 91 8e
                iny                          ; 9fbf: c8
                lda ram77                    ; 9fc0: a5 8b
                sta (arr66),y                ; 9fc2: 91 8e
                iny                          ; 9fc4: c8
                lda #0                       ; 9fc5: a9 00
                sta (arr66),y                ; 9fc7: 91 8e
                iny                          ; 9fc9: c8
                sta (arr66),y                ; 9fca: 91 8e
                iny                          ; 9fcc: c8
                sta (arr66),y                ; 9fcd: 91 8e
                lda ram79                    ; 9fcf: a5 90
                cmp #2                       ; 9fd1: c9 02
                beq +                        ; 9fd3: f0 0c
                lda #0                       ; 9fd5: a9 00
                ldx #$21                     ; 9fd7: a2 21
-               iny                          ; 9fd9: c8
                sta (arr66),y                ; 9fda: 91 8e
                dex                          ; 9fdc: ca
                bne -                        ; 9fdd: d0 fa
                lda #$21                     ; 9fdf: a9 21
+               clc                          ; 9fe1: 18
                adc #3                       ; 9fe2: 69 03
                adc arr66                    ; 9fe4: 65 8e
                sta ram24                    ; 9fe6: 85 28
                lda #0                       ; 9fe8: a9 00
                adc ram78                    ; 9fea: 65 8f
                sta ram25                    ; 9fec: 85 29
                jsr sub38                    ; 9fee: 20 44 8a
                lda ram24                    ; 9ff1: a5 28
                sta arr13                    ; 9ff3: 85 1f
                lda ram25                    ; 9ff5: a5 29
                sta arr14                    ; 9ff7: 85 20
cod230          clc                          ; 9ff9: 18
                lda #3                       ; 9ffa: a9 03
                adc arr66                    ; 9ffc: 65 8e
                sta arr64                    ; 9ffe: 85 8c
dat17           lda #0                       ; a000: a9 00
                adc ram78                    ; a002: 65 8f
                sta arr65                    ; a004: 85 8d
                rts                          ; a006: 60
cod231          lda arr66                    ; a007: a5 8e
                sta arr64                    ; a009: 85 8c
                lda ram78                    ; a00b: a5 8f
                sta arr65                    ; a00d: 85 8d
cod232          rts                          ; a00f: 60
sub137          jsr sub123                   ; a010: 20 94 9c
                lda #2                       ; a013: a9 02
                cmp ram23                    ; a015: c5 27
                beq cod232                   ; a017: f0 f6
cod233          jmp cod262                   ; a019: 4c e1 a3
cod234          jmp cod238                   ; a01c: 4c bc a0
cod235          lda ram76                    ; a01f: a5 8a
                pha                          ; a021: 48
                lda ram77                    ; a022: a5 8b
                pha                          ; a024: 48
                lda ram79                    ; a025: a5 90
                ora #%10000000               ; a027: 09 80
                pha                          ; a029: 48
                jsr sub60                    ; a02a: 20 a1 8c
                jsr sub137                   ; a02d: 20 10 a0
                ldx arr20                    ; a030: a6 30
                dex                          ; a032: ca
                dex                          ; a033: ca
                dex                          ; a034: ca
                lda arr144,x                 ; a035: bd 00 04
                pha                          ; a038: 48
                jsr sub138                   ; a039: 20 f1 a0
                bcc cod234                   ; a03c: 90 de
                jsr sub165                   ; a03e: 20 94 a5
                jsr sub137                   ; a041: 20 10 a0
                ldx arr20                    ; a044: a6 30
                dex                          ; a046: ca
                dex                          ; a047: ca
                dex                          ; a048: ca
                lda arr144,x                 ; a049: bd 00 04
                pha                          ; a04c: 48
                jsr sub138                   ; a04d: 20 f1 a0
                bcs cod233                   ; a050: b0 c7
                jsr sub60                    ; a052: 20 a1 8c
                pla                          ; a055: 68
                sta ram16                    ; a056: 85 1b
                pla                          ; a058: 68
                sta ram14                    ; a059: 85 19
                pla                          ; a05b: 68
                sta ram79                    ; a05c: 85 90
                pla                          ; a05e: 68
                sta ram77                    ; a05f: 85 8b
                pla                          ; a061: 68
                sta ram76                    ; a062: 85 8a
                jsr sub141                   ; a064: 20 0e a1
                bcc cod237                   ; a067: 90 50
                ldy #3                       ; a069: a0 03
                lda (arr66),y                ; a06b: b1 8e
                beq cod237                   ; a06d: f0 4a
                iny                          ; a06f: c8
                lda (arr66),y                ; a070: b1 8e
                cmp ram14                    ; a072: c5 19
                bcc cod237                   ; a074: 90 43
                tax                          ; a076: aa
                iny                          ; a077: c8
                lda (arr66),y                ; a078: b1 8e
                cmp ram16                    ; a07a: c5 1b
                bcc cod237                   ; a07c: 90 3b
                jsr sub144                   ; a07e: 20 cd a1
                inx                          ; a081: e8
                bne +                        ; a082: d0 02
                inc ram25                    ; a084: e6 29
+               stx ram24                    ; a086: 86 28
                lda ram16                    ; a088: a5 1b
                sta arr18                    ; a08a: 85 2c
                jsr sub52                    ; a08c: 20 5c 8b
                lda ram14                    ; a08f: a5 19
                sta arr18                    ; a091: 85 2c
                jsr sub44                    ; a093: 20 e8 8a
                jsr sub139                   ; a096: 20 03 a1
                sta arr18                    ; a099: 85 2c
                jsr sub52                    ; a09b: 20 5c 8b
                lda #6                       ; a09e: a9 06
cod236          sta arr18                    ; a0a0: 85 2c
                jsr sub44                    ; a0a2: 20 e8 8a
                lda arr66                    ; a0a5: a5 8e
                sta arr18                    ; a0a7: 85 2c
                lda ram78                    ; a0a9: a5 8f
                sta arr19                    ; a0ab: 85 2d
                jsr sub44                    ; a0ad: 20 e8 8a
                lda ram24                    ; a0b0: a5 28
                sta arr64                    ; a0b2: 85 8c
                lda ram25                    ; a0b4: a5 29
                sta arr65                    ; a0b6: 85 8d
                rts                          ; a0b8: 60
cod237          jmp $8370                    ; a0b9: 4c 70 83
cod238          jsr sub60                    ; a0bc: 20 a1 8c
                pla                          ; a0bf: 68
                sta ram14                    ; a0c0: 85 19
                pla                          ; a0c2: 68
                sta ram79                    ; a0c3: 85 90
                pla                          ; a0c5: 68
                sta ram77                    ; a0c6: 85 8b
                pla                          ; a0c8: 68
                sta ram76                    ; a0c9: 85 8a
                jsr sub141                   ; a0cb: 20 0e a1
                bcc cod237                   ; a0ce: 90 e9
                ldy #3                       ; a0d0: a0 03
                lda (arr66),y                ; a0d2: b1 8e
                bne cod237                   ; a0d4: d0 e3
                iny                          ; a0d6: c8
                lda (arr66),y                ; a0d7: b1 8e
                cmp ram14                    ; a0d9: c5 19
                bcc cod237                   ; a0db: 90 dc
                lda ram14                    ; a0dd: a5 19
                sta ram24                    ; a0df: 85 28
                jsr sub139                   ; a0e1: 20 03 a1
                sta arr18                    ; a0e4: 85 2c
                jsr sub144                   ; a0e6: 20 cd a1
                jsr sub52                    ; a0e9: 20 5c 8b
                lda #5                       ; a0ec: a9 05
                jmp cod236                   ; a0ee: 4c a0 a0
sub138          lda arr145,x                 ; a0f1: bd 01 04
                bne cod237                   ; a0f4: d0 c3
                stx arr20                    ; a0f6: 86 30
                jsr sub64                    ; a0f8: 20 d4 8c
                cmp #$29                     ; a0fb: c9 29
                bne +                        ; a0fd: d0 02
                clc                          ; a0ff: 18
                rts                          ; a100: 60
+               sec                          ; a101: 38
                rts                          ; a102: 60
sub139          lda ram79                    ; a103: a5 90
                and #%00001111               ; a105: 29 0f
sub140          cmp #2                       ; a107: c9 02
                beq +                        ; a109: f0 02
                lda #$21                     ; a10b: a9 21
+               rts                          ; a10d: 60
sub141          lda ram18                    ; a10e: a5 1d
                sta arr66                    ; a110: 85 8e
                lda ram19                    ; a112: a5 1e
                sta ram78                    ; a114: 85 8f
cod239          ldy #0                       ; a116: a0 00
                lda (arr66),y                ; a118: b1 8e
                beq cod242                   ; a11a: f0 36
                cmp ram79                    ; a11c: c5 90
                bne cod240                   ; a11e: d0 10
dat18           iny                          ; a120: c8
                lda (arr66),y                ; a121: b1 8e
                cmp ram76                    ; a123: c5 8a
                bne cod240                   ; a125: d0 09
                iny                          ; a127: c8
                lda (arr66),y                ; a128: b1 8e
                cmp ram77                    ; a12a: c5 8b
                bne cod240                   ; a12c: d0 02
                sec                          ; a12e: 38
                rts                          ; a12f: 60
cod240          ldy #0                       ; a130: a0 00
                lda (arr66),y                ; a132: b1 8e
                bmi cod243                   ; a134: 30 1e
                jsr sub140                   ; a136: 20 07 a1
                clc                          ; a139: 18
                adc #3                       ; a13a: 69 03
                adc arr66                    ; a13c: 65 8e
                sta arr66                    ; a13e: 85 8e
                lda #0                       ; a140: a9 00
                adc ram78                    ; a142: 65 8f
                sta ram78                    ; a144: 85 8f
cod241          lda arr13                    ; a146: a5 1f
                cmp arr66                    ; a148: c5 8e
                bne cod239                   ; a14a: d0 ca
                lda arr14                    ; a14c: a5 20
                cmp ram78                    ; a14e: c5 8f
                bne cod239                   ; a150: d0 c4
cod242          clc                          ; a152: 18
                rts                          ; a153: 60
cod243          and #%00001111               ; a154: 29 0f
                sta arr56                    ; a156: 85 73
                ldy #3                       ; a158: a0 03
                lda (arr66),y                ; a15a: b1 8e
                sta arr57                    ; a15c: 85 74
                iny                          ; a15e: c8
                lda (arr66),y                ; a15f: b1 8e
                sta ram40                    ; a161: 85 4a
                iny                          ; a163: c8
                lda (arr66),y                ; a164: b1 8e
                sta ram41                    ; a166: 85 4b
                jsr sub144                   ; a168: 20 cd a1
                sta arr18                    ; a16b: 85 2c
                lda ram40                    ; a16d: a5 4a
                sta ram24                    ; a16f: 85 28
                lda arr57                    ; a171: a5 74
                beq +                        ; a173: f0 04
                lda ram41                    ; a175: a5 4b
                sta arr18                    ; a177: 85 2c
+               inc ram24                    ; a179: e6 28
                bne +                        ; a17b: d0 02
                inc ram25                    ; a17d: e6 29
+               inc arr18                    ; a17f: e6 2c
                bne +                        ; a181: d0 02
                inc arr19                    ; a183: e6 2d
+               jsr sub52                    ; a185: 20 5c 8b
                lda arr56                    ; a188: a5 73
                jsr sub140                   ; a18a: 20 07 a1
                sta arr18                    ; a18d: 85 2c
                lda #0                       ; a18f: a9 00
                sta arr19                    ; a191: 85 2d
                jsr sub52                    ; a193: 20 5c 8b
                lda #5                       ; a196: a9 05
                sta arr18                    ; a198: 85 2c
                lda arr57                    ; a19a: a5 74
                beq +                        ; a19c: f0 02
                inc arr18                    ; a19e: e6 2c
+               jsr sub44                    ; a1a0: 20 e8 8a
                lda arr66                    ; a1a3: a5 8e
                sta arr18                    ; a1a5: 85 2c
                lda ram78                    ; a1a7: a5 8f
                sta arr19                    ; a1a9: 85 2d
                jsr sub44                    ; a1ab: 20 e8 8a
                lda ram24                    ; a1ae: a5 28
                sta arr66                    ; a1b0: 85 8e
                lda ram25                    ; a1b2: a5 29
                sta ram78                    ; a1b4: 85 8f
                jmp cod241                   ; a1b6: 4c 46 a1
cod244          sec                          ; a1b9: 38
                rts                          ; a1ba: 60
sub142          cmp #$30                     ; a1bb: c9 30
                bcc cod244                   ; a1bd: 90 fa
                cmp #$3a                     ; a1bf: c9 3a
                bcc cod245                   ; a1c1: 90 08
sub143          cmp #$41                     ; a1c3: c9 41
                bcc cod244                   ; a1c5: 90 f2
                cmp #$5b                     ; a1c7: c9 5b
                bcs cod244                   ; a1c9: b0 ee
cod245          clc                          ; a1cb: 18
                rts                          ; a1cc: 60
sub144          lda #0                       ; a1cd: a9 00
                sta arr19                    ; a1cf: 85 2d
                sta ram25                    ; a1d1: 85 29
                rts                          ; a1d3: 60
                jsr sub45                    ; a1d4: 20 ec 8a
sub145          ldx arr20                    ; a1d7: a6 30
                dex                          ; a1d9: ca
                dex                          ; a1da: ca
                dex                          ; a1db: ca
                lda ram24                    ; a1dc: a5 28
                sta arr144,x                 ; a1de: 9d 00 04
                lda ram25                    ; a1e1: a5 29
                sta arr145,x                 ; a1e3: 9d 01 04
                lda ram26                    ; a1e6: a5 2a
                sta arr146,x                 ; a1e8: 9d 02 04
                jmp sub64                    ; a1eb: 4c d4 8c
                jsr sub42                    ; a1ee: 20 73 8a
                jmp sub145                   ; a1f1: 4c d7 a1
                jsr sub50                    ; a1f4: 20 51 8b
                jmp sub145                   ; a1f7: 4c d7 a1
sub146          lda arr18                    ; a1fa: a5 2c
                bne +                        ; a1fc: d0 04
                lda arr19                    ; a1fe: a5 2d
                beq cod246                   ; a200: f0 16
+               nop                          ; a202: ea
                nop                          ; a203: ea
                nop                          ; a204: ea
                nop                          ; a205: ea
                nop                          ; a206: ea
                jsr sub54                    ; a207: 20 b2 8b
                jmp sub145                   ; a20a: 4c d7 a1
                lda #1                       ; a20d: a9 01
                sta ram24                    ; a20f: 85 28
                lda #0                       ; a211: a9 00
                sta ram25                    ; a213: 85 29
                jmp sub145                   ; a215: 4c d7 a1
cod246          lda #$0a                     ; a218: a9 0a
                jmp cod287                   ; a21a: 4c 8f a9
sub147          lda ram25                    ; a21d: a5 29
                pha                          ; a21f: 48
                jsr sub146                   ; a220: 20 fa a1
                lda ram26                    ; a223: a5 2a
                sta ram24                    ; a225: 85 28
                lda ram27                    ; a227: a5 2b
                sta ram25                    ; a229: 85 29
                pla                          ; a22b: 68
                bpl cod249                   ; a22c: 10 0a
                lda ram25                    ; a22e: a5 29
                bmi cod248                   ; a230: 30 03
cod247          jsr sub43                    ; a232: 20 7c 8a
cod248          jmp sub145                   ; a235: 4c d7 a1
cod249          lda ram25                    ; a238: a5 29
                bpl cod248                   ; a23a: 10 f9
                bmi cod247                   ; a23c: 30 f4
                jsr sub57                    ; a23e: 20 03 8c
                bne cod252                   ; a241: d0 09
cod250          lda #0                       ; a243: a9 00
cod251          sta ram24                    ; a245: 85 28
                sta ram25                    ; a247: 85 29
                jmp sub145                   ; a249: 4c d7 a1
cod252          lda #$ff                     ; a24c: a9 ff
                jmp cod251                   ; a24e: 4c 45 a2
                jsr sub57                    ; a251: 20 03 8c
                beq cod252                   ; a254: f0 f6
                bcc cod252                   ; a256: 90 f4
                jmp cod250                   ; a258: 4c 43 a2
                jsr sub57                    ; a25b: 20 03 8c
                bcs cod252                   ; a25e: b0 ec
                jmp cod250                   ; a260: 4c 43 a2
                jsr sub57                    ; a263: 20 03 8c
                beq cod252                   ; a266: f0 e4
                jmp cod250                   ; a268: 4c 43 a2
                jsr sub57                    ; a26b: 20 03 8c
                beq cod250                   ; a26e: f0 d3
                bcs cod252                   ; a270: b0 da
                jmp cod250                   ; a272: 4c 43 a2
                jsr sub57                    ; a275: 20 03 8c
                bcc cod252                   ; a278: 90 d2
                jmp cod250                   ; a27a: 4c 43 a2
dat19           rol misc160,x                ; a27d: 3e a2 5b
                ldx #$51                     ; a280: a2 51
                ldx #$63                     ; a282: a2 63
                ldx #$6b                     ; a284: a2 6b
                ldx #$75                     ; a286: a2 75
                ldx #$20                     ; a288: a2 20

                hex d4                       ; a28a

                sty misc33                   ; a28b: 8c c9 28
                bne cod254                   ; a28e: d0 4e
                jmp sub60                    ; a290: 4c a1 8c
sub148          jsr sub64                    ; a293: 20 d4 8c
                cmp #$29                     ; a296: c9 29
                bne cod254                   ; a298: d0 44
                jmp sub60                    ; a29a: 4c a1 8c
cod253          jsr sub60                    ; a29d: 20 a1 8c
                jsr sub156                   ; a2a0: 20 e6 a3
                ldy ram24                    ; a2a3: a4 28
                lda arr178,y                 ; a2a5: b9 45 06
                ldy #0                       ; a2a8: a0 00
                and #%00010000               ; a2aa: 29 10
                beq +                        ; a2ac: f0 02
                ldy #$ff                     ; a2ae: a0 ff
+               sty ram24                    ; a2b0: 84 28
                sty ram25                    ; a2b2: 84 29
                jsr sub155                   ; a2b4: 20 63 a3
                jmp sub64                    ; a2b7: 4c d4 8c
sub149          lda #0                       ; a2ba: a9 00
                sta ram24                    ; a2bc: 85 28
sub150          sta ram25                    ; a2be: 85 29
                sta ram26                    ; a2c0: 85 2a
                rts                          ; a2c2: 60
sub151          jsr $a289                    ; a2c3: 20 89 a2
                jsr sub123                   ; a2c6: 20 94 9c
                ldx arr20                    ; a2c9: a6 30
                dex                          ; a2cb: ca
                lda arr144,x                 ; a2cc: bd 00 04
                sta ram26                    ; a2cf: 85 2a
                dex                          ; a2d1: ca
                lda arr144,x                 ; a2d2: bd 00 04
                sta ram25                    ; a2d5: 85 29
                dex                          ; a2d7: ca
                lda arr144,x                 ; a2d8: bd 00 04
                sta ram24                    ; a2db: 85 28
                rts                          ; a2dd: 60
cod254          jmp cod24                    ; a2de: 4c 6d 83
                ldx arr20                    ; a2e1: a6 30
                lda ram24                    ; a2e3: a5 28
                sta arr144,x                 ; a2e5: 9d 00 04
                inx                          ; a2e8: e8
                lda ram25                    ; a2e9: a5 29
                sta arr144,x                 ; a2eb: 9d 00 04
                inx                          ; a2ee: e8
                inx                          ; a2ef: e8
                stx arr20                    ; a2f0: 86 30
                rts                          ; a2f2: 60
                lda arr35                    ; a2f3: a5 49
                sta ram24                    ; a2f5: 85 28
                lda #0                       ; a2f7: a9 00
                sta ram25                    ; a2f9: 85 29
sub152          inc arr20                    ; a2fb: e6 30
                inc arr20                    ; a2fd: e6 30
                inc arr20                    ; a2ff: e6 30
cod255          lda #2                       ; a301: a9 02
                sta ram23                    ; a303: 85 27
cod256          ldx arr20                    ; a305: a6 30
                dex                          ; a307: ca
                dex                          ; a308: ca
                dex                          ; a309: ca
                lda ram24                    ; a30a: a5 28
                sta arr144,x                 ; a30c: 9d 00 04
                lda ram25                    ; a30f: a5 29
                sta arr145,x                 ; a311: 9d 01 04
                lda ram26                    ; a314: a5 2a
                sta arr146,x                 ; a316: 9d 02 04
                rts                          ; a319: 60
                jsr sub153                   ; a31a: 20 20 a3
                jmp sub152                   ; a31d: 4c fb a2
sub153          sec                          ; a320: 38
                lda ram1                     ; a321: a5 03
                sbc arr13                    ; a323: e5 1f
                sta ram24                    ; a325: 85 28
                lda ram2                     ; a327: a5 04
                sbc arr14                    ; a329: e5 20
                sta ram25                    ; a32b: 85 29
                rts                          ; a32d: 60
                jsr sub157                   ; a32e: 20 ec a3
                lda arr34                    ; a331: a5 48
cod257          sta ram24                    ; a333: 85 28
                lda #0                       ; a335: a9 00
                sta ram25                    ; a337: 85 29
                jmp sub155                   ; a339: 4c 63 a3
sub154          jsr sub156                   ; a33c: 20 e6 a3
                lda ram24                    ; a33f: a5 28
                asl a                        ; a341: 0a
                asl a                        ; a342: 0a
                asl a                        ; a343: 0a
dat20           tax                          ; a344: aa
                rts                          ; a345: 60
                jsr sub154                   ; a346: 20 3c a3
                lda arr188,x                 ; a349: bd c6 06
                jmp cod257                   ; a34c: 4c 33 a3
                jsr sub154                   ; a34f: 20 3c a3
                lda arr189,x                 ; a352: bd c7 06
                jmp cod257                   ; a355: 4c 33 a3
                jsr sub157                   ; a358: 20 ec a3
                ldy #0                       ; a35b: a0 00
                lda (ram24),y                ; a35d: b1 28
                sta ram24                    ; a35f: 85 28
                sty ram25                    ; a361: 84 29
sub155          jsr sub148                   ; a363: 20 93 a2
                jmp cod255                   ; a366: 4c 01 a3
                jsr sub157                   ; a369: 20 ec a3
                lda ram25                    ; a36c: a5 29
                bmi +                        ; a36e: 30 03
                jmp sub155                   ; a370: 4c 63 a3
+               jsr sub43                    ; a373: 20 7c 8a
                jmp sub155                   ; a376: 4c 63 a3
                jsr sub157                   ; a379: 20 ec a3
                lda ram25                    ; a37c: a5 29
                bmi cod259                   ; a37e: 30 0d
                beq cod261                   ; a380: f0 14
cod258          lda #0                       ; a382: a9 00
                sta ram25                    ; a384: 85 29
                lda #1                       ; a386: a9 01
                sta ram24                    ; a388: 85 28
                jmp sub155                   ; a38a: 4c 63 a3
cod259          lda #$ff                     ; a38d: a9 ff
cod260          sta ram24                    ; a38f: 85 28
                sta ram25                    ; a391: 85 29
                jmp sub155                   ; a393: 4c 63 a3
cod261          lda ram24                    ; a396: a5 28
                bne cod258                   ; a398: d0 e8
                lda #0                       ; a39a: a9 00
                jmp cod260                   ; a39c: 4c 8f a3
                jsr sub157                   ; a39f: 20 ec a3
                lda ram24                    ; a3a2: a5 28
                pha                          ; a3a4: 48
                lda ram25                    ; a3a5: a5 29
                pha                          ; a3a7: 48
                lda arr45                    ; a3a8: a5 56
                sta ram24                    ; a3aa: 85 28
                lda ram43                    ; a3ac: a5 57
                sta ram25                    ; a3ae: 85 29
                lda #$83                     ; a3b0: a9 83
                sta arr18                    ; a3b2: 85 2c
                lda #3                       ; a3b4: a9 03
                sta arr19                    ; a3b6: 85 2d
                jsr sub51                    ; a3b8: 20 59 8b
                lda #$7f                     ; a3bb: a9 7f
                and ram25                    ; a3bd: 25 29
                sta ram25                    ; a3bf: 85 29
                sta ram43                    ; a3c1: 85 57
                lda ram24                    ; a3c3: a5 28
                sta arr45                    ; a3c5: 85 56
                pla                          ; a3c7: 68
                sta arr19                    ; a3c8: 85 2d
                pla                          ; a3ca: 68
                sta arr18                    ; a3cb: 85 2c
                jsr sub51                    ; a3cd: 20 59 8b
                asl ram25                    ; a3d0: 06 29
                rol ram33                    ; a3d2: 26 36
                rol arr23                    ; a3d4: 26 37
                lda ram33                    ; a3d6: a5 36
                sta ram24                    ; a3d8: 85 28
                lda arr23                    ; a3da: a5 37
                sta ram25                    ; a3dc: 85 29
                jmp sub155                   ; a3de: 4c 63 a3
cod262          lda #$0b                     ; a3e1: a9 0b
                jmp cod287                   ; a3e3: 4c 8f a9
sub156          jsr sub157                   ; a3e6: 20 ec a3
                jmp sub162                   ; a3e9: 4c 48 a5
sub157          jsr sub151                   ; a3ec: 20 c3 a2
sub158          lda #2                       ; a3ef: a9 02
                ldx ram178                   ; a3f1: ae a9 03
                cmp ram23                    ; a3f4: c5 27
                bne cod262                   ; a3f6: d0 e9
                rts                          ; a3f8: 60
sub159          jsr sub151                   ; a3f9: 20 c3 a2
                jmp $a3f2                    ; a3fc: 4c f2 a3
                jsr sub159                   ; a3ff: 20 f9 a3
-               lda #0                       ; a402: a9 00
                jsr sub150                   ; a404: 20 be a2
                jmp sub155                   ; a407: 4c 63 a3
                jsr sub159                   ; a40a: 20 f9 a3
                lda ram24                    ; a40d: a5 28
                beq -                        ; a40f: f0 f1
                ldy #0                       ; a411: a0 00
                lda (ram25),y                ; a413: b1 29
                sta ram24                    ; a415: 85 28
                jmp -                        ; a417: 4c 02 a4
-               jmp $8370                    ; a41a: 4c 70 83
                jsr sub198                   ; a41d: 20 a1 ac
                jsr sub156                   ; a420: 20 e6 a3
                lda ram24                    ; a423: a5 28
                cmp #$1c                     ; a425: c9 1c
                bcs -                        ; a427: b0 f1
                sta arr34                    ; a429: 85 48
                jsr sub166                   ; a42b: 20 9e a5
                jsr sub162                   ; a42e: 20 48 a5
                lda ram24                    ; a431: a5 28
                cmp #$18                     ; a433: c9 18
                bcs -                        ; a435: b0 e3
                sta arr35                    ; a437: 85 49
                jsr sub64                    ; a439: 20 d4 8c
                cmp #$29                     ; a43c: c9 29
                beq +                        ; a43e: f0 0f
                jsr sub166                   ; a440: 20 9e a5
                lda ram24                    ; a443: a5 28
                beq +                        ; a445: f0 08
                jsr sub248                   ; a447: 20 37 ba
                lda ram87                    ; a44a: a5 9c
                jmp cod263                   ; a44c: 4c 59 a4
+               jsr sub187                   ; a44f: 20 a6 ab
                lda #5                       ; a452: a9 05
                jsr sub34                    ; a454: 20 08 88
                lda arr56                    ; a457: a5 73
cod263          sta ram24                    ; a459: 85 28
                jsr sub199                   ; a45b: 20 aa ac
                jmp +                        ; a45e: 4c 64 a4
                jsr sub156                   ; a461: 20 e6 a3
+               lda ram24                    ; a464: a5 28
cod264          jsr sub160                   ; a466: 20 73 a4
cod265          lda #3                       ; a469: a9 03
                sta ram23                    ; a46b: 85 27
                jsr sub148                   ; a46d: 20 93 a2
                jmp cod256                   ; a470: 4c 05 a3
sub160          ldx arr15                    ; a473: a6 21
                sta arr191,x                 ; a475: 9d 00 07
                inc arr15                    ; a478: e6 21
                lda #1                       ; a47a: a9 01
                sta ram24                    ; a47c: 85 28
                stx ram25                    ; a47e: 86 29
                lda #7                       ; a480: a9 07
                sta ram26                    ; a482: 85 2a
                rts                          ; a484: 60
                jsr sub157                   ; a485: 20 ec a3
                jsr sub73                    ; a488: 20 96 8d
cod266          jsr sub66                    ; a48b: 20 eb 8c
                lda #0                       ; a48e: a9 00
                sta ram79                    ; a490: 85 90
                ldy arr15                    ; a492: a4 21
                ldx arr33                    ; a494: a6 46
-               lda arr26,x                  ; a496: b5 3d
                beq +                        ; a498: f0 0a
                sta arr191,y                 ; a49a: 99 00 07
                inx                          ; a49d: e8
                iny                          ; a49e: c8
                inc ram79                    ; a49f: e6 90
                jmp -                        ; a4a1: 4c 96 a4
+               lda arr15                    ; a4a4: a5 21
                sty arr15                    ; a4a6: 84 21
                sta ram25                    ; a4a8: 85 29
                lda #7                       ; a4aa: a9 07
                sta ram26                    ; a4ac: 85 2a
                lda ram79                    ; a4ae: a5 90
                sta ram24                    ; a4b0: 85 28
                jmp cod265                   ; a4b2: 4c 69 a4
                jsr sub157                   ; a4b5: 20 ec a3
                jsr sub76                    ; a4b8: 20 d8 8d
                jmp cod266                   ; a4bb: 4c 8b a4
                jsr sub159                   ; a4be: 20 f9 a3
                lda ram24                    ; a4c1: a5 28
                beq +                        ; a4c3: f0 27
                jsr sub89                    ; a4c5: 20 f8 8f
                lda ram24                    ; a4c8: a5 28
                sta arr57                    ; a4ca: 85 74
                ldx #0                       ; a4cc: a2 00
                ldy #0                       ; a4ce: a0 00
-               lda (ram25),y                ; a4d0: b1 29
                sta arr160,x                 ; a4d2: 9d 00 05
                inx                          ; a4d5: e8
                iny                          ; a4d6: c8
                dec arr57                    ; a4d7: c6 74
                bne -                        ; a4d9: d0 f5
                lda #0                       ; a4db: a9 00
                sta arr160,x                 ; a4dd: 9d 00 05
                jsr sub36                    ; a4e0: 20 32 8a
                jsr sub161                   ; a4e3: 20 fe a4
                jsr sub90                    ; a4e6: 20 01 90
                jmp sub155                   ; a4e9: 4c 63 a3
+               jsr sub149                   ; a4ec: 20 ba a2
                jmp sub155                   ; a4ef: 4c 63 a3
cod267          jsr sub60                    ; a4f2: 20 a1 8c
                jsr sub161                   ; a4f5: 20 fe a4
                jmp sub43                    ; a4f8: 4c 7c 8a
cod268          jsr sub60                    ; a4fb: 20 a1 8c
sub161          ldy #0                       ; a4fe: a0 00
                lda (ram4),y                 ; a500: b1 09
                cmp #$2d                     ; a502: c9 2d
                beq cod267                   ; a504: f0 ec
                cmp #$2b                     ; a506: c9 2b
                beq cod268                   ; a508: f0 f1
                cmp #$26                     ; a50a: c9 26
                beq +                        ; a50c: f0 03
                jmp sub67                    ; a50e: 4c f9 8c
+               jsr sub60                    ; a511: 20 a1 8c
                lda (ram4),y                 ; a514: b1 09
                cmp #$48                     ; a516: c9 48
                bne +                        ; a518: d0 03
                jsr sub60                    ; a51a: 20 a1 8c
+               jmp sub77                    ; a51d: 4c eb 8d
                jsr sub13                    ; a520: 20 78 83
                beq +                        ; a523: f0 0d
                cmp #$28                     ; a525: c9 28
                bne +                        ; a527: d0 09
                jsr sub151                   ; a529: 20 c3 a2
                jsr sub211                   ; a52c: 20 63 b2
                jmp cod264                   ; a52f: 4c 66 a4
+               jsr sub206                   ; a532: 20 88 af
                beq cod270                   ; a535: f0 0b
                jsr sub160                   ; a537: 20 73 a4
cod269          jsr sub152                   ; a53a: 20 fb a2
                lda #3                       ; a53d: a9 03
                sta ram23                    ; a53f: 85 27
                rts                          ; a541: 60
cod270          jsr sub149                   ; a542: 20 ba a2
                jmp cod269                   ; a545: 4c 3a a5
sub162          lda ram25                    ; a548: a5 29
                bne cod271                   ; a54a: d0 06
                rts                          ; a54c: 60
sub163          cmp #$20                     ; a54d: c9 20
                bcs cod271                   ; a54f: b0 01
                rts                          ; a551: 60
cod271          jmp $8370                    ; a552: 4c 70 83
sub164          jsr sub159                   ; a555: 20 f9 a3
                lda ram24                    ; a558: a5 28
                pha                          ; a55a: 48
                lda ram25                    ; a55b: a5 29
                pha                          ; a55d: 48
                lda ram26                    ; a55e: a5 2a
                pha                          ; a560: 48
                jsr sub166                   ; a561: 20 9e a5
                jsr sub162                   ; a564: 20 48 a5
                lda ram24                    ; a567: a5 28
                jsr sub163                   ; a569: 20 4d a5
                pla                          ; a56c: 68
                sta ram15                    ; a56d: 85 1a
                pla                          ; a56f: 68
                sta ram14                    ; a570: 85 19
                pla                          ; a572: 68
                rts                          ; a573: 60
                jsr sub164                   ; a574: 20 55 a5
                sta ram40                    ; a577: 85 4a
                lda ram24                    ; a579: a5 28
                cmp ram40                    ; a57b: c5 4a
                bcs cod273                   ; a57d: b0 0b
cod272          lda ram14                    ; a57f: a5 19
                sta ram25                    ; a581: 85 29
                lda ram15                    ; a583: a5 1a
                sta ram26                    ; a585: 85 2a
                jmp cod265                   ; a587: 4c 69 a4
cod273          lda ram40                    ; a58a: a5 4a
                sta ram24                    ; a58c: 85 28
                jmp cod272                   ; a58e: 4c 7f a5
cod274          jmp cod24                    ; a591: 4c 6d 83
sub165          jsr sub64                    ; a594: 20 d4 8c
                cmp #$2c                     ; a597: c9 2c
                bne cod274                   ; a599: d0 f6
                jmp sub60                    ; a59b: 4c a1 8c
sub166          jsr sub165                   ; a59e: 20 94 a5
                jsr sub123                   ; a5a1: 20 94 9c
                ldx arr20                    ; a5a4: a6 30
                dex                          ; a5a6: ca
                lda arr144,x                 ; a5a7: bd 00 04
                sta ram26                    ; a5aa: 85 2a
                dex                          ; a5ac: ca
                lda arr144,x                 ; a5ad: bd 00 04
                sta ram25                    ; a5b0: 85 29
                dex                          ; a5b2: ca
                lda arr144,x                 ; a5b3: bd 00 04
                sta ram24                    ; a5b6: 85 28
                stx arr20                    ; a5b8: 86 30
                jmp sub158                   ; a5ba: 4c ef a3
                jsr sub164                   ; a5bd: 20 55 a5
                sta ram40                    ; a5c0: 85 4a
                lda ram24                    ; a5c2: a5 28
                cmp ram40                    ; a5c4: c5 4a
                bcs cod273                   ; a5c6: b0 c2
                sec                          ; a5c8: 38
                lda ram40                    ; a5c9: a5 4a
                sbc ram24                    ; a5cb: e5 28
                clc                          ; a5cd: 18
                adc ram14                    ; a5ce: 65 19
                sta ram14                    ; a5d0: 85 19
                lda #0                       ; a5d2: a9 00
                adc ram15                    ; a5d4: 65 1a
                sta ram15                    ; a5d6: 85 1a
                lda ram24                    ; a5d8: a5 28
                sta ram79                    ; a5da: 85 90
                ldx arr15                    ; a5dc: a6 21
                ldy #0                       ; a5de: a0 00
-               lda (ram14),y                ; a5e0: b1 19
                sta arr191,x                 ; a5e2: 9d 00 07
                inx                          ; a5e5: e8
                iny                          ; a5e6: c8
                dec ram79                    ; a5e7: c6 90
                bne -                        ; a5e9: d0 f5
                lda arr15                    ; a5eb: a5 21
                sta ram25                    ; a5ed: 85 29
                stx arr15                    ; a5ef: 86 21
                lda #7                       ; a5f1: a9 07
                sta ram26                    ; a5f3: 85 2a
                jmp cod265                   ; a5f5: 4c 69 a4
-               jmp $8370                    ; a5f8: 4c 70 83
                jsr sub159                   ; a5fb: 20 f9 a3
                lda ram24                    ; a5fe: a5 28
                pha                          ; a600: 48
                lda ram25                    ; a601: a5 29
                pha                          ; a603: 48
                lda ram26                    ; a604: a5 2a
                pha                          ; a606: 48
                jsr sub166                   ; a607: 20 9e a5
                jsr sub162                   ; a60a: 20 48 a5
                lda ram24                    ; a60d: a5 28
                beq -                        ; a60f: f0 e7
                jsr sub163                   ; a611: 20 4d a5
                sec                          ; a614: 38
                sbc #1                       ; a615: e9 01
                pha                          ; a617: 48
                jsr sub166                   ; a618: 20 9e a5
                jsr sub162                   ; a61b: 20 48 a5
                lda ram24                    ; a61e: a5 28
dat21           jsr sub163                   ; a620: 20 4d a5
                sta ram17                    ; a623: 85 1c
                pla                          ; a625: 68
                sta ram16                    ; a626: 85 1b
                pla                          ; a628: 68
                sta ram15                    ; a629: 85 1a
                pla                          ; a62b: 68
                sta ram14                    ; a62c: 85 19
                pla                          ; a62e: 68
                cmp ram16                    ; a62f: c5 1b
                bcc cod277                   ; a631: 90 3b
                sec                          ; a633: 38
                sbc ram16                    ; a634: e5 1b
                cmp ram17                    ; a636: c5 1c
                bcc cod276                   ; a638: 90 2f
cod275          lda ram16                    ; a63a: a5 1b
                clc                          ; a63c: 18
                adc ram14                    ; a63d: 65 19
                sta ram14                    ; a63f: 85 19
                lda #0                       ; a641: a9 00
                adc ram15                    ; a643: 65 1a
                sta ram15                    ; a645: 85 1a
                lda ram17                    ; a647: a5 1c
                sta ram24                    ; a649: 85 28
                sta ram79                    ; a64b: 85 90
                ldx arr15                    ; a64d: a6 21
                ldy #0                       ; a64f: a0 00
-               lda (ram14),y                ; a651: b1 19
                sta arr191,x                 ; a653: 9d 00 07
                inx                          ; a656: e8
                iny                          ; a657: c8
                dec ram79                    ; a658: c6 90
                bne -                        ; a65a: d0 f5
                lda arr15                    ; a65c: a5 21
                sta ram25                    ; a65e: 85 29
                stx arr15                    ; a660: 86 21
                lda #7                       ; a662: a9 07
                sta ram26                    ; a664: 85 2a
                jmp cod265                   ; a666: 4c 69 a4
cod276          sta ram17                    ; a669: 85 1c
                jmp cod275                   ; a66b: 4c 3a a6
cod277          jsr sub149                   ; a66e: 20 ba a2
                jmp cod265                   ; a671: 4c 69 a4
cod278          jmp $8370                    ; a674: 4c 70 83
sub167          jsr sub156                   ; a677: 20 e6 a3
sub168          lda ram24                    ; a67a: a5 28
                beq $a685                    ; a67c: f0 07
                cmp #1                       ; a67e: c9 01
                bne cod278                   ; a680: d0 f2
                lda #$17                     ; a682: a9 17
                ldx ram239                   ; a684: ae a9 16
                sta ram14                    ; a687: 85 19
                lda #$40                     ; a689: a9 40
                sta ram15                    ; a68b: 85 1a
                lda #5                       ; a68d: a9 05
                sta joypad1                  ; a68f: 8d 16 40
                nop                          ; a692: ea
                nop                          ; a693: ea
                lda #4                       ; a694: a9 04
                sta joypad1                  ; a696: 8d 16 40
                nop                          ; a699: ea
                nop                          ; a69a: ea
                ldx #8                       ; a69b: a2 08
                ldy #0                       ; a69d: a0 00
-               lda (ram14),y                ; a69f: b1 19
                lsr a                        ; a6a1: 4a
                rol ram79                    ; a6a2: 26 90
                nop                          ; a6a4: ea
                nop                          ; a6a5: ea
                dex                          ; a6a6: ca
                bne -                        ; a6a7: d0 f6
                rts                          ; a6a9: 60
                jsr sub167                   ; a6aa: 20 77 a6
                jsr sub168                   ; a6ad: 20 7a a6
                lda ram79                    ; a6b0: a5 90
                and #%00001111               ; a6b2: 29 0f
-               sta ram24                    ; a6b4: 85 28
                jmp sub155                   ; a6b6: 4c 63 a3
                jsr sub167                   ; a6b9: 20 77 a6
                lda ram79                    ; a6bc: a5 90
                lsr a                        ; a6be: 4a
                lsr a                        ; a6bf: 4a
                lsr a                        ; a6c0: 4a
                lsr a                        ; a6c1: 4a
                jmp -                        ; a6c2: 4c b4 a6
sub169          asl a                        ; a6c5: 0a
                asl a                        ; a6c6: 0a
                asl a                        ; a6c7: 0a
                asl a                        ; a6c8: 0a
                rts                          ; a6c9: 60
                jsr sub120                   ; a6ca: 20 6d 9c
                and #%00000011               ; a6cd: 29 03
                asl a                        ; a6cf: 0a
                asl a                        ; a6d0: 0a
                asl a                        ; a6d1: 0a
                sta arr57                    ; a6d2: 85 74
                lda arr21                    ; a6d4: a5 32
                and #%11100111               ; a6d6: 29 e7
                ora arr57                    ; a6d8: 05 74
                sta arr21                    ; a6da: 85 32
                jmp sub220                   ; a6dc: 4c f1 b3
sub170          ldx #0                       ; a6df: a2 00
                lda #$ef                     ; a6e1: a9 ef
-               sta arr107,x                 ; a6e3: 9d 00 02
                inx                          ; a6e6: e8
                bne -                        ; a6e7: d0 fa
                rts                          ; a6e9: 60
                ldx #0                       ; a6ea: a2 00
                stx ram53                    ; a6ec: 86 65
                cmp #$42                     ; a6ee: c9 42
                beq +                        ; a6f0: f0 08
                cmp #$53                     ; a6f2: c9 53
                bne cod280                   ; a6f4: d0 4d
                lda #$10                     ; a6f6: a9 10
                sta ram53                    ; a6f8: 85 65
+               jsr sub118                   ; a6fa: 20 64 9c
                cmp #4                       ; a6fd: c9 04
                bcs cod279                   ; a6ff: b0 3f
                pha                          ; a701: 48
                lda #4                       ; a702: a9 04
                sta arr3                     ; a704: 85 02
                lda #0                       ; a706: a9 00
                sta ram64                    ; a708: 85 7c
-               jsr sub119                   ; a70a: 20 6a 9c
                ldy ram64                    ; a70d: a4 7c
                sta arr26,y                  ; a70f: 99 3d 00
                inc ram64                    ; a712: e6 7c
                dec arr3                     ; a714: c6 02
                bne -                        ; a716: d0 f2
                pla                          ; a718: 68
                sta arr191                   ; a719: 8d 00 07
                lda arr26                    ; a71c: a5 3d
                sta ram212                   ; a71e: 8d 01 07
                lda arr27                    ; a721: a5 3e
                sta ram213                   ; a723: 8d 02 07
                lda arr28                    ; a726: a5 3f
                sta ram214                   ; a728: 8d 03 07
                lda ram37                    ; a72b: a5 40
                sta ram215                   ; a72d: 8d 04 07
                ldy #6                       ; a730: a0 06
                ldx ram53                    ; a732: a6 65
                beq +                        ; a734: f0 01
                iny                          ; a736: c8
+               tya                          ; a737: 98
                jmp sub34                    ; a738: 4c 08 88
sub171          cmp #8                       ; a73b: c9 08
                bcs cod279                   ; a73d: b0 01
                rts                          ; a73f: 60
cod279          jmp $8370                    ; a740: 4c 70 83
cod280          jmp cod24                    ; a743: 4c 6d 83
                cmp #$2c                     ; a746: c9 2c
                beq cod281                   ; a748: f0 25
                jsr sub120                   ; a74a: 20 6d 9c
                beq +                        ; a74d: f0 04
                cmp #1                       ; a74f: c9 01
                bne cod279                   ; a751: d0 ed
+               asl a                        ; a753: 0a
                tax                          ; a754: aa
                lda $c3a5,x                  ; a755: bd a5 c3
                sta arr41                    ; a758: 85 52
                lda dat76,x                  ; a75a: bd a6 c3
                sta arr42                    ; a75d: 85 53
                lda #0                       ; a75f: a9 00
                sta ram53                    ; a761: 85 65
                jsr sub172                   ; a763: 20 8a a7
                jsr sub13                    ; a766: 20 78 83
                beq cod282                   ; a769: f0 1e
                cmp #$2c                     ; a76b: c9 2c
                bne cod280                   ; a76d: d0 d4
cod281          jsr sub118                   ; a76f: 20 64 9c
                cmp #3                       ; a772: c9 03
                bcs cod279                   ; a774: b0 ca
                asl a                        ; a776: 0a
                tax                          ; a777: aa
                lda dat77,x                  ; a778: bd a9 c3
                sta arr41                    ; a77b: 85 52
                lda cod415,x                 ; a77d: bd aa c3
                sta arr42                    ; a780: 85 53
                lda #1                       ; a782: a9 01
                sta ram53                    ; a784: 85 65
                jsr sub172                   ; a786: 20 8a a7
cod282          rts                          ; a789: 60
sub172          lda #0                       ; a78a: a9 00
                sta arr191                   ; a78c: 8d 00 07
                sta ram61                    ; a78f: 85 75
cod283          lda #4                       ; a791: a9 04
                ldx #1                       ; a793: a2 01
                sta arr57                    ; a795: 85 74
                ldy ram61                    ; a797: a4 75
-               lda (arr41),y                ; a799: b1 52
                sta arr191,x                 ; a79b: 9d 00 07
                inx                          ; a79e: e8
                iny                          ; a79f: c8
                dec arr57                    ; a7a0: c6 74
                bne -                        ; a7a2: d0 f5
                sty ram61                    ; a7a4: 84 75
                lda #6                       ; a7a6: a9 06
                sta arr56                    ; a7a8: 85 73
                lda ram53                    ; a7aa: a5 65
                beq +                        ; a7ac: f0 02
                inc arr56                    ; a7ae: e6 73
+               lda arr56                    ; a7b0: a5 73
                jsr sub34                    ; a7b2: 20 08 88
                inc arr191                   ; a7b5: ee 00 07
                lda arr191                   ; a7b8: ad 00 07
                cmp #4                       ; a7bb: c9 04
                bne cod283                   ; a7bd: d0 d2
                rts                          ; a7bf: 60
sub173          lda ram31                    ; a7c0: a5 33
                ora #%00010000               ; a7c2: 09 10
cod284          sta ram31                    ; a7c4: 85 33
                sta ppu_mask                 ; a7c6: 8d 01 20
                jmp sub60                    ; a7c9: 4c a1 8c
sub174          lda ram31                    ; a7cc: a5 33
                and #%11101111               ; a7ce: 29 ef
                jmp cod284                   ; a7d0: 4c c4 a7
cod285          pla                          ; a7d3: 68
                jsr sub169                   ; a7d4: 20 c5 a6
                tax                          ; a7d7: aa
                ldy #4                       ; a7d8: a0 04
-               lda #$ef                     ; a7da: a9 ef
                sta arr107,x                 ; a7dc: 9d 00 02
                sta arr110,x                 ; a7df: 9d 03 02
                sta arr108,x                 ; a7e2: 9d 01 02
                inx                          ; a7e5: e8
                inx                          ; a7e6: e8
                inx                          ; a7e7: e8
                inx                          ; a7e8: e8
                dey                          ; a7e9: 88
                bne -                        ; a7ea: d0 ee
                rts                          ; a7ec: 60
                jmp $8370                    ; a7ed: 4c 70 83
                jmp cod24                    ; a7f0: 4c 6d 83
                cmp #$9a                     ; a7f3: c9 9a
                beq sub173                   ; a7f5: f0 c9
                cmp #$9b                     ; a7f7: c9 9b
                beq sub174                   ; a7f9: f0 d1
                jsr sub120                   ; a7fb: 20 6d 9c
                jsr sub171                   ; a7fe: 20 3b a7
                pha                          ; a801: 48
                jsr sub13                    ; a802: 20 78 83
                beq cod285                   ; a805: f0 cc
                jsr sub119                   ; a807: 20 6a 9c
                pha                          ; a80a: 48
                jsr sub119                   ; a80b: 20 6a 9c
                sta ram16                    ; a80e: 85 1b
                pla                          ; a810: 68
                sta ram14                    ; a811: 85 19
                pla                          ; a813: 68
                sta ram61                    ; a814: 85 75
                tax                          ; a816: aa
                lda arr176,x                 ; a817: bd 3d 06
                sta ram79                    ; a81a: 85 90
                lda ram61                    ; a81c: a5 75
                asl a                        ; a81e: 0a
                asl a                        ; a81f: 0a
                tax                          ; a820: aa
                asl a                        ; a821: 0a
                asl a                        ; a822: 0a
                pha                          ; a823: 48
                tay                          ; a824: a8
                lda #4                       ; a825: a9 04
                sta arr57                    ; a827: 85 74
-               lda arr181,x                 ; a829: bd 80 06
                sta arr108,y                 ; a82c: 99 01 02
                inx                          ; a82f: e8
                iny                          ; a830: c8
                iny                          ; a831: c8
                iny                          ; a832: c8
                iny                          ; a833: c8
                dec arr57                    ; a834: c6 74
                bne -                        ; a836: d0 f1
                pla                          ; a838: 68
                tay                          ; a839: a8
                lda ram16                    ; a83a: a5 1b
                sta arr107,y                 ; a83c: 99 00 02
                lda ram14                    ; a83f: a5 19
                sta arr110,y                 ; a841: 99 03 02
                lda ram79                    ; a844: a5 90
                bne +                        ; a846: d0 01
                rts                          ; a848: 60
+               lda #0                       ; a849: a9 00
                sta ram17                    ; a84b: 85 1c
                lda #8                       ; a84d: a9 08
                sta ram15                    ; a84f: 85 1a
                jsr sub175                   ; a851: 20 65 a8
                lda #0                       ; a854: a9 00
                sta ram15                    ; a856: 85 1a
                lda #8                       ; a858: a9 08
                sta ram17                    ; a85a: 85 1c
                jsr sub175                   ; a85c: 20 65 a8
                lda #8                       ; a85f: a9 08
                sta ram15                    ; a861: 85 1a
                sta ram17                    ; a863: 85 1c
sub175          iny                          ; a865: c8
                iny                          ; a866: c8
                iny                          ; a867: c8
                iny                          ; a868: c8
                lda ram14                    ; a869: a5 19
                clc                          ; a86b: 18
                adc ram15                    ; a86c: 65 1a
                sta arr110,y                 ; a86e: 99 03 02
                lda ram16                    ; a871: a5 1b
                clc                          ; a873: 18
                adc ram17                    ; a874: 65 1c
                sta arr107,y                 ; a876: 99 00 02
                rts                          ; a879: 60
-               cmp #$a1                     ; a87a: c9 a1
                bne +                        ; a87c: d0 03
                jmp cod403                   ; a87e: 4c e4 bf
+               jmp cod24                    ; a881: 4c 6d 83
                jmp $8370                    ; a884: 4c 70 83
                cmp #$8a                     ; a887: c9 8a
                bne -                        ; a889: d0 ef
                jsr sub118                   ; a88b: 20 64 9c
                jsr sub171                   ; a88e: 20 3b a7
                pha                          ; a891: 48
                jsr sub165                   ; a892: 20 94 a5
                jsr $a289                    ; a895: 20 89 a2
                lda #4                       ; a898: a9 04
                sta ram61                    ; a89a: 85 75
                jsr sub120                   ; a89c: 20 6d 9c
                pha                          ; a89f: 48
-               jsr sub119                   ; a8a0: 20 6a 9c
                pha                          ; a8a3: 48
                dec ram61                    ; a8a4: c6 75
                bne -                        ; a8a6: d0 f8
                jsr sub148                   ; a8a8: 20 93 a2
                jsr sub21                    ; a8ab: 20 a2 85
                pla                          ; a8ae: 68
                ror a                        ; a8af: 6a
                ror a                        ; a8b0: 6a
                and #%10000000               ; a8b1: 29 80
                sta ram14                    ; a8b3: 85 19
                pla                          ; a8b5: 68
                ror a                        ; a8b6: 6a
                ror a                        ; a8b7: 6a
                ror a                        ; a8b8: 6a
                and #%01000000               ; a8b9: 29 40
                ora ram14                    ; a8bb: 05 19
                sta ram14                    ; a8bd: 85 19
                pla                          ; a8bf: 68
                ror a                        ; a8c0: 6a
                ror a                        ; a8c1: 6a
                ror a                        ; a8c2: 6a
                ror a                        ; a8c3: 6a
                and #%00100000               ; a8c4: 29 20
                ora ram14                    ; a8c6: 05 19
                sta ram14                    ; a8c8: 85 19
                pla                          ; a8ca: 68
                sta arr76                    ; a8cb: 85 ad
                pla                          ; a8cd: 68
                and #%00000011               ; a8ce: 29 03
                ora ram14                    ; a8d0: 05 19
                sta ram14                    ; a8d2: 85 19
                pla                          ; a8d4: 68
                sta ram61                    ; a8d5: 85 75
                jsr sub169                   ; a8d7: 20 c5 a6
                ldy #4                       ; a8da: a0 04
                tax                          ; a8dc: aa
-               lda #0                       ; a8dd: a9 00
                sta arr107,x                 ; a8df: 9d 00 02
                sta arr110,x                 ; a8e2: 9d 03 02
                lda ram14                    ; a8e5: a5 19
                sta arr109,x                 ; a8e7: 9d 02 02
                lda #$20                     ; a8ea: a9 20
                sta arr108,x                 ; a8ec: 9d 01 02
                inx                          ; a8ef: e8
                inx                          ; a8f0: e8
                inx                          ; a8f1: e8
                inx                          ; a8f2: e8
                dey                          ; a8f3: 88
                bne -                        ; a8f4: d0 e7
                jsr sub121                   ; a8f6: 20 7c 9c
                lda arr145                   ; a8f9: ad 01 04
                sta ram16                    ; a8fc: 85 1b
                lda arr146                   ; a8fe: ad 02 04
                sta ram17                    ; a901: 85 1c
                ldy #0                       ; a903: a0 00
                lda ram61                    ; a905: a5 75
                asl a                        ; a907: 0a
                asl a                        ; a908: 0a
                tax                          ; a909: aa
                lda arr144                   ; a90a: ad 00 04
                beq +                        ; a90d: f0 10
-               lda (ram16),y                ; a90f: b1 1b
                sta arr181,x                 ; a911: 9d 80 06
                inx                          ; a914: e8
                iny                          ; a915: c8
                cpy #4                       ; a916: c0 04
                beq cod286                   ; a918: f0 10
                dec arr144                   ; a91a: ce 00 04
                bne -                        ; a91d: d0 f0
+               lda #$20                     ; a91f: a9 20
-               sta arr181,x                 ; a921: 9d 80 06
                inx                          ; a924: e8
                iny                          ; a925: c8
                cpy #4                       ; a926: c0 04
                bne -                        ; a928: d0 f7
cod286          ldx ram61                    ; a92a: a6 75
                lda arr76                    ; a92c: a5 ad
                sta arr176,x                 ; a92e: 9d 3d 06
                rts                          ; a931: 60
                jsr sub186                   ; a932: 20 75 ab
                lda #$20                     ; a935: a9 20
                sta arr57                    ; a937: 85 74
                lda #$0c                     ; a939: a9 0c
                jsr sub34                    ; a93b: 20 08 88
                ldx #0                       ; a93e: a2 00
-               lda arr57                    ; a940: a5 74
                clc                          ; a942: 18
                adc #4                       ; a943: 69 04
                jsr sub9                     ; a945: 20 f8 81
                lda ppu_data                 ; a948: ad 07 20
                lda ppu_data                 ; a94b: ad 07 20
                pha                          ; a94e: 48
                lda arr57                    ; a94f: a5 74
                jsr sub9                     ; a951: 20 f8 81
                pla                          ; a954: 68
                sta ppu_data                 ; a955: 8d 07 20
                inx                          ; a958: e8
                bne -                        ; a959: d0 e5
                inc arr57                    ; a95b: e6 74
                lda arr57                    ; a95d: a5 74
                cmp #$24                     ; a95f: c9 24
                bne -                        ; a961: d0 dd
                jsr sub190                   ; a963: 20 e6 ab
                jsr sub220                   ; a966: 20 f1 b3
                lda #$0b                     ; a969: a9 0b
                jmp sub34                    ; a96b: 4c 08 88
sub176          ldx #$3d                     ; a96e: a2 3d
                lda #0                       ; a970: a9 00
-               sta arr168,x                 ; a972: 9d 00 06
                inx                          ; a975: e8
                bne -                        ; a976: d0 fa
                ldx #0                       ; a978: a2 00
                lda #$ef                     ; a97a: a9 ef
-               sta arr181,x                 ; a97c: 9d 80 06
                inx                          ; a97f: e8
                cpx #$20                     ; a980: e0 20
                bne -                        ; a982: d0 f8
                ldx #$c0                     ; a984: a2 c0
                lda #1                       ; a986: a9 01
-               sta arr168,x                 ; a988: 9d 00 06
                inx                          ; a98b: e8
                bne -                        ; a98c: d0 fa
                rts                          ; a98e: 60
cod287          pha                          ; a98f: 48
                jsr sub193                   ; a990: 20 03 ac
                pla                          ; a993: 68
                ldx #0                       ; a994: a2 00
                txs                          ; a996: 9a
                asl a                        ; a997: 0a
                tay                          ; a998: a8
                lda #$3f                     ; a999: a9 3f
                jsr sub31                    ; a99b: 20 f0 87
                lda $aa5e,y                  ; a99e: b9 5e aa
                jsr sub31                    ; a9a1: 20 f0 87
                lda dat22,y                  ; a9a4: b9 5f aa
                jsr sub31                    ; a9a7: 20 f0 87
                lda #$3f                     ; a9aa: a9 3f
                sta arr41                    ; a9ac: 85 52
                lda #$aa                     ; a9ae: a9 aa
                sta arr42                    ; a9b0: 85 53
                jsr sub29                    ; a9b2: 20 b7 87
                jsr sub28                    ; a9b5: 20 3b 87
cod288          lda #$ff                     ; a9b8: a9 ff
                cmp arr7                     ; a9ba: c5 0c
                bne +                        ; a9bc: d0 04
                cmp ram6                     ; a9be: c5 0b
                beq cod289                   ; a9c0: f0 0e
+               lda #$34                     ; a9c2: a9 34
                sta arr41                    ; a9c4: 85 52
                lda #$aa                     ; a9c6: a9 aa
                sta arr42                    ; a9c8: 85 53
                jsr sub29                    ; a9ca: 20 b7 87
                jsr sub177                   ; a9cd: 20 d9 a9
cod289          jsr sub33                    ; a9d0: 20 fb 87
                jsr sub212                   ; a9d3: 20 0f b3
                jmp cod12                    ; a9d6: 4c 21 82
sub177          lda ram6                     ; a9d9: a5 0b
                sta ram24                    ; a9db: 85 28
                lda arr7                     ; a9dd: a5 0c
                sta ram25                    ; a9df: 85 29
sub178          jsr sub69                    ; a9e1: 20 3c 8d
                jsr sub66                    ; a9e4: 20 eb 8c
                jmp sub23                    ; a9e7: 4c 5f 86
cod290          jsr sub193                   ; a9ea: 20 03 ac
                lda #0                       ; a9ed: a9 00
                sta arr48                    ; a9ef: 85 62
                lda #$39                     ; a9f1: a9 39
                sta arr41                    ; a9f3: 85 52
                lda #$aa                     ; a9f5: a9 aa
                sta arr42                    ; a9f7: 85 53
                jsr sub29                    ; a9f9: 20 b7 87
                jmp cod288                   ; a9fc: 4c b8 a9
sub179          lda #$4f                     ; a9ff: a9 4f
                jsr sub195                   ; aa01: 20 0d ac
                lda #$4b                     ; aa04: a9 4b
                jmp sub195                   ; aa06: 4c 0d ac
sub180          lda #$58                     ; aa09: a9 58
                sta arr41                    ; aa0b: 85 52
                lda #$c3                     ; aa0d: a9 c3
                sta arr42                    ; aa0f: 85 53
                jsr sub32                    ; aa11: 20 f8 87
                jsr sub153                   ; aa14: 20 20 a3
                jsr sub178                   ; aa17: 20 e1 a9
                jsr sub33                    ; aa1a: 20 fb 87
                lda #$28                     ; aa1d: a9 28
                sta arr41                    ; aa1f: 85 52
                lda #$aa                     ; aa21: a9 aa
                sta arr42                    ; aa23: 85 53
                jmp sub32                    ; aa25: 4c f8 87
                jsr misc158                  ; aa28: 20 42 59

                hex 54                       ; aa2b

cod291          eor arr42                    ; aa2c: 45 53
                jsr misc137                  ; aa2e: 20 46 52
                eor arr32                    ; aa31: 45 45
                brk                          ; aa33: 00
                jsr misc121                  ; aa34: 20 49 4e
                jsr misc79                   ; aa37: 20 00 42

                hex 52                       ; aa3a

                eor ram38                    ; aa3b: 45 41

                hex 4b                       ; aa3d

                brk                          ; aa3e: 00
                jsr misc136                  ; aa3f: 20 45 52

                hex 52 4f 52                 ; aa42

                brk                          ; aa45: 00

                hex 57 52                    ; aa46

                eor #%01010100               ; aa48: 49 54
                eor #%01001110               ; aa4a: 49 4e

                hex 47                       ; aa4c

                jsr misc108                  ; aa4d: 20 00 4c

                hex 4f                       ; aa50

                eor (arr31,x)                ; aa51: 41 44
                eor #%01001110               ; aa53: 49 4e

                hex 47                       ; aa55

                jsr misc141                  ; aa56: 20 00 53

                hex 4b                       ; aa59

                eor #%01010000               ; aa5a: 49 50
                jsr misc118                  ; aa5c: 20 00 4e
dat22           lsr arr42                    ; aa5f: 46 53
                lsr misc103                  ; aa61: 4e 52 47

                hex 4f 44                    ; aa64

                eor #%01001100               ; aa66: 49 4c

                hex 4f                       ; aa68

                lsr arr38,x                  ; aa69: 56 4f
                eor misc110                  ; aa6b: 4d 55 4c

                hex 53 4f 44 44 44 5a 54     ; aa6e

                eor misc150                  ; aa75: 4d 53 54
                lsr arr43                    ; aa78: 46 54

                hex 43 43                    ; aa7a

                eor arr33,x                  ; aa7c: 55 46
                eor misc148                  ; aa7e: 4d 4f 54
                bvc cod291                   ; aa81: 50 a9
                bpl $aa0a                    ; aa83: 10 85

                hex 32                       ; aa85

                lda #$0e                     ; aa86: a9 0e
                sta ram31                    ; aa88: 85 33
                jsr sub191                   ; aa8a: 20 f1 ab
                lda #0                       ; aa8d: a9 00
                sta ram88                    ; aa8f: 85 9d
                sta ram56                    ; aa91: 85 69
                sta ram52                    ; aa93: 85 63
                sta arr75                    ; aa95: 85 ab
                sta ram98                    ; aa97: 85 ac
                sta arr48                    ; aa99: 85 62
                sta arr55                    ; aa9b: 85 72
                sta arr39                    ; aa9d: 85 50
                sta arr12                    ; aa9f: 85 18
                sta dmc_freq                 ; aaa1: 8d 10 40
                sta sq1_sweep                ; aaa4: 8d 01 40
                sta sq2_sweep                ; aaa7: 8d 05 40
                sta snd_chn                  ; aaaa: 8d 15 40
                sta arr36                    ; aaad: 85 4c
                sta ram54                    ; aaaf: 85 66
                sta arr50                    ; aab1: 85 67
                lda #$4f                     ; aab3: a9 4f
                sta joypad2                  ; aab5: 8d 17 40
                jsr sub181                   ; aab8: 20 f3 aa
                jsr sub220                   ; aabb: 20 f1 b3
                lda #$20                     ; aabe: a9 20
                sta arr38                    ; aac0: 85 4f
                jsr sub186                   ; aac2: 20 75 ab
                jsr sub183                   ; aac5: 20 09 ab
                ldx #0                       ; aac8: a2 00
                txa                          ; aaca: 8a
                ldy #$80                     ; aacb: a0 80
-               sta arr159,x                 ; aacd: 9d 80 04
                inx                          ; aad0: e8
                dey                          ; aad1: 88
                bne -                        ; aad2: d0 f9
                ldx #0                       ; aad4: a2 00
cod292          lda arr50                    ; aad6: a5 67
                cmp #8                       ; aad8: c9 08
                beq cod293                   ; aada: f0 2c
                jsr sub169                   ; aadc: 20 c5 a6
                tay                          ; aadf: a8
-               lda dat23,x                  ; aae0: bd 1d ab
                beq +                        ; aae3: f0 08
                sta arr159,y                 ; aae5: 99 80 04
                inx                          ; aae8: e8
                iny                          ; aae9: c8
                jmp -                        ; aaea: 4c e0 aa
+               inx                          ; aaed: e8
                inc arr50                    ; aaee: e6 67
                jmp cod292                   ; aaf0: 4c d6 aa
sub181          lda #$fd                     ; aaf3: a9 fd
                sta ram128                   ; aaf5: 85 e0
                lda #$5f                     ; aaf7: a9 5f
                sta ram129                   ; aaf9: 85 e1
                jmp sub204                   ; aafb: 4c a9 ad
sub182          lda ppu_status               ; aafe: ad 02 20
                bmi sub182                   ; ab01: 30 fb
-               lda ppu_status               ; ab03: ad 02 20
                bpl -                        ; ab06: 10 fb
cod293          rts                          ; ab08: 60
sub183          lda #$bf                     ; ab09: a9 bf
                sta arr41                    ; ab0b: 85 52
                lda #$c3                     ; ab0d: a9 c3
                sta arr42                    ; ab0f: 85 53
                lda #0                       ; ab11: a9 00
                sta ram53                    ; ab13: 85 65
                jsr sub172                   ; ab15: 20 8a a7
                inc ram53                    ; ab18: e6 65
                jmp sub172                   ; ab1a: 4c 8a a7
dat23           jmp misc76                   ; ab1d: 4c 4f 41

                hex 44                       ; ab20

                ora misc130                  ; ab21: 0d 00 50

                hex 52                       ; ab24

                eor #%01001110               ; ab25: 49 4e

                hex 54                       ; ab27

                jsr misc101                  ; ab28: 20 00 47

                hex 4f 54 4f                 ; ab2b

                jsr misc83                   ; ab2e: 20 00 43
                pha                          ; ab31: 48

                hex 52                       ; ab32

                bit ram24                    ; ab33: 24 28
                brk                          ; ab35: 00

                hex 53                       ; ab36

                bvc $ab8b                    ; ab37: 50 52
                eor #%01010100               ; ab39: 49 54
                eor arr14                    ; ab3b: 45 20
                brk                          ; ab3d: 00

                hex 43 4f                    ; ab3e

                lsr ram223                   ; ab40: 4e 54 0d
                brk                          ; ab43: 00
                jmp misc143                  ; ab44: 4c 49 53

                hex 54                       ; ab47

                ora misc135                  ; ab48: 0d 00 52
                eor arr37,x                  ; ab4b: 55 4e
                ora dat17                    ; ab4d: 0d 00 a0

                hex 04                       ; ab50

                ldx #$c0                     ; ab51: a2 c0
                lda #$20                     ; ab53: a9 20
-               sta ppu_data                 ; ab55: 8d 07 20
                dex                          ; ab58: ca
                bne -                        ; ab59: d0 fa
                dey                          ; ab5b: 88
                bne -                        ; ab5c: d0 f7
sub184          ldx #$c0                     ; ab5e: a2 c0
                lda arr38                    ; ab60: a5 4f
                clc                          ; ab62: 18
                adc #3                       ; ab63: 69 03
                jsr sub9                     ; ab65: 20 f8 81
                lda #0                       ; ab68: a9 00
-               sta ppu_data                 ; ab6a: 8d 07 20
                inx                          ; ab6d: e8
                bne -                        ; ab6e: d0 fa
                rts                          ; ab70: 60
sub185          lda #$24                     ; ab71: a9 24
                sta arr38                    ; ab73: 85 4f
sub186          lda #$0c                     ; ab75: a9 0c
                jsr sub34                    ; ab77: 20 08 88
                jsr sub219                   ; ab7a: 20 eb b3
                jsr sub191                   ; ab7d: 20 f1 ab
                lda arr38                    ; ab80: a5 4f
                ldx #0                       ; ab82: a2 00
                jsr sub9                     ; ab84: 20 f8 81
                jsr $ab4f                    ; ab87: 20 4f ab
                jsr sub190                   ; ab8a: 20 e6 ab
                jsr sub220                   ; ab8d: 20 f1 b3
                lda #$0b                     ; ab90: a9 0b
                jsr sub34                    ; ab92: 20 08 88
                jsr sub200                   ; ab95: 20 8b ad
                sta ram56                    ; ab98: 85 69
                sta ram88                    ; ab9a: 85 9d
                tax                          ; ab9c: aa
-               sta arr168,x                 ; ab9d: 9d 00 06
                inx                          ; aba0: e8
                cpx #$1a                     ; aba1: e0 1a
                bne -                        ; aba3: d0 f8
                rts                          ; aba5: 60
sub187          lda #$20                     ; aba6: a9 20
                sta ram24                    ; aba8: 85 28
                lda #0                       ; abaa: a9 00
                sta ram25                    ; abac: 85 29
                sta arr19                    ; abae: 85 2d
                lda ram56                    ; abb0: a5 69
                lsr a                        ; abb2: 4a
                lsr a                        ; abb3: 4a
                lsr a                        ; abb4: 4a
                clc                          ; abb5: 18
                adc arr35                    ; abb6: 65 49
                adc #3                       ; abb8: 69 03
                cmp #$1e                     ; abba: c9 1e
                bcc +                        ; abbc: 90 02
                sbc #$1e                     ; abbe: e9 1e
+               sta arr18                    ; abc0: 85 2c
                jsr sub52                    ; abc2: 20 5c 8b
                clc                          ; abc5: 18
                lda arr34                    ; abc6: a5 48
                adc #2                       ; abc8: 69 02
                adc ram24                    ; abca: 65 28
                sta ram40                    ; abcc: 85 4a
                lda #0                       ; abce: a9 00
                adc ram25                    ; abd0: 65 29
                clc                          ; abd2: 18
                adc arr38                    ; abd3: 65 4f
                sta ram41                    ; abd5: 85 4b
                rts                          ; abd7: 60
sub188          lda ram41                    ; abd8: a5 4b
                sta ppu_addr                 ; abda: 8d 06 20
                lda ram40                    ; abdd: a5 4a
                sta ppu_addr                 ; abdf: 8d 06 20
                rts                          ; abe2: 60
sub189          sta ppu_data                 ; abe3: 8d 07 20
sub190          lda ram88                    ; abe6: a5 9d
                sta ppu_scroll               ; abe8: 8d 05 20
                lda ram56                    ; abeb: a5 69
                sta ppu_scroll               ; abed: 8d 05 20
                rts                          ; abf0: 60
sub191          jsr sub182                   ; abf1: 20 fe aa
                lda #0                       ; abf4: a9 00
                sta ppu_mask                 ; abf6: 8d 01 20
                rts                          ; abf9: 60
sub192          jsr sub182                   ; abfa: 20 fe aa
                lda ram31                    ; abfd: a5 33
                sta ppu_mask                 ; abff: 8d 01 20
cod294          rts                          ; ac02: 60
sub193          lda arr34                    ; ac03: a5 48
                beq cod294                   ; ac05: f0 fb
sub194          lda #0                       ; ac07: a9 00
                sta arr34                    ; ac09: 85 48
                lda #$0a                     ; ac0b: a9 0a
sub195          cmp #$20                     ; ac0d: c9 20
                bcs cod295                   ; ac0f: b0 23
                cmp #8                       ; ac11: c9 08
                beq +                        ; ac13: f0 10
                cmp #1                       ; ac15: c9 01
                beq +                        ; ac17: f0 0c
                cmp #$12                     ; ac19: c9 12
                beq +                        ; ac1b: f0 08
                cmp #9                       ; ac1d: c9 09
                beq +                        ; ac1f: f0 04
                ldy #0                       ; ac21: a0 00
                sty arr36                    ; ac23: 84 4c
+               asl a                        ; ac25: 0a
                tax                          ; ac26: aa
                lda dat30,x                  ; ac27: bd 01 af
                sta ram24                    ; ac2a: 85 28
                lda $af02,x                  ; ac2c: bd 02 af
                sta ram25                    ; ac2f: 85 29
                jmp (ram24)                  ; ac31: 6c 28 00
cod295          ldy arr36                    ; ac34: a4 4c
                beq +                        ; ac36: f0 07
                pha                          ; ac38: 48
                lda #$12                     ; ac39: a9 12
                jsr sub195                   ; ac3b: 20 0d ac
                pla                          ; ac3e: 68
+               jsr sub31                    ; ac3f: 20 f0 87
                jmp sub33                    ; ac42: 4c fb 87
cod296          inc arr35                    ; ac45: e6 49
                lda arr35                    ; ac47: a5 49
                cmp #$18                     ; ac49: c9 18
                beq sub196                   ; ac4b: f0 10
dat24           rts                          ; ac4d: 60
cod297          jsr sub201                   ; ac4e: 20 8f ad
-               ldx arr35                    ; ac51: a6 49
                lda arr169,x                 ; ac53: bd 01 06
                beq cod296                   ; ac56: f0 ed
                inc arr35                    ; ac58: e6 49
                jmp -                        ; ac5a: 4c 51 ac
sub196          dec ram66                    ; ac5d: c6 7e
                jsr sub200                   ; ac5f: 20 8b ad
                jsr sub187                   ; ac62: 20 a6 ab
                lda #4                       ; ac65: a9 04
                jsr sub34                    ; ac67: 20 08 88
sub197          lda arr21                    ; ac6a: a5 32
                sta ppu_ctrl                 ; ac6c: 8d 00 20
                lda ram56                    ; ac6f: a5 69
                clc                          ; ac71: 18
                adc #8                       ; ac72: 69 08
                cmp #$f0                     ; ac74: c9 f0
                bcc +                        ; ac76: 90 02
                lda #0                       ; ac78: a9 00
+               sta ram56                    ; ac7a: 85 69
                jsr sub182                   ; ac7c: 20 fe aa
                jsr sub190                   ; ac7f: 20 e6 ab
                ldy #$18                     ; ac82: a0 18
                ldx #0                       ; ac84: a2 00
-               lda arr170,x                 ; ac86: bd 02 06
                sta arr169,x                 ; ac89: 9d 01 06
                inx                          ; ac8c: e8
                dey                          ; ac8d: 88
                bne -                        ; ac8e: d0 f6
                lda #0                       ; ac90: a9 00
                sta arr172                   ; ac92: 8d 18 06
                sta ram210                   ; ac95: 8d 19 06
                sta arr34                    ; ac98: 85 48
                lda #$17                     ; ac9a: a9 17
                sta arr35                    ; ac9c: 85 49
                jmp sub220                   ; ac9e: 4c f1 b3
sub198          lda arr34                    ; aca1: a5 48
                sta ram57                    ; aca3: 85 6b
                lda arr35                    ; aca5: a5 49
                sta ram58                    ; aca7: 85 6c
                rts                          ; aca9: 60
sub199          lda ram57                    ; acaa: a5 6b
                sta arr34                    ; acac: 85 48
                lda ram58                    ; acae: a5 6c
                sta arr35                    ; acb0: 85 49
                rts                          ; acb2: 60
                jsr sub191                   ; acb3: 20 f1 ab
                lda #$10                     ; acb6: a9 10
                sta arr21                    ; acb8: 85 32
                jsr sub220                   ; acba: 20 f1 b3
                lda #$0e                     ; acbd: a9 0e
                sta ppu_mask                 ; acbf: 8d 01 20
                sta ram31                    ; acc2: 85 33
                jsr sub183                   ; acc4: 20 09 ab
                jsr sub184                   ; acc7: 20 5e ab
                sta arr36                    ; acca: 85 4c
                jsr sub190                   ; accc: 20 e6 ab
                jmp sub192                   ; accf: 4c fa ab
dat25           jsr sub198                   ; acd2: 20 a1 ac
                jsr sub187                   ; acd5: 20 a6 ab
                lda #4                       ; acd8: a9 04
-               jsr sub34                    ; acda: 20 08 88
                ldx arr35                    ; acdd: a6 49
                lda arr169,x                 ; acdf: bd 01 06
                beq cod298                   ; ace2: f0 0d
                inc arr35                    ; ace4: e6 49
                jsr sub201                   ; ace6: 20 8f ad
                jsr sub187                   ; ace9: 20 a6 ab
                lda #4                       ; acec: a9 04
                jmp -                        ; acee: 4c da ac
cod298          jmp sub199                   ; acf1: 4c aa ac
dat26           jsr sub198                   ; acf4: 20 a1 ac
                jsr sub187                   ; acf7: 20 a6 ab
-               lda #4                       ; acfa: a9 04
                jsr sub34                    ; acfc: 20 08 88
                ldx arr35                    ; acff: a6 49
                lda #0                       ; ad01: a9 00
                sta arr169,x                 ; ad03: 9d 01 06
                sta arr34                    ; ad06: 85 48
                inc arr35                    ; ad08: e6 49
                inx                          ; ad0a: e8
                cpx #$18                     ; ad0b: e0 18
                beq cod298                   ; ad0d: f0 e2
                jsr sub187                   ; ad0f: 20 a6 ab
                jmp -                        ; ad12: 4c fa ac
                ldx arr35                    ; ad15: a6 49
                dex                          ; ad17: ca
                txa                          ; ad18: 8a
                tax                          ; ad19: aa
                inx                          ; ad1a: e8
                lda arr169,x                 ; ad1b: bd 01 06
                rts                          ; ad1e: 60
                jmp sub194                   ; ad1f: 4c 07 ac
dat27           lda arr34                    ; ad22: a5 48
                cmp #$15                     ; ad24: c9 15
                bcs $ad33                    ; ad26: b0 0b
                cmp #$0e                     ; ad28: c9 0e
                bcs $ad36                    ; ad2a: b0 0a
                cmp #7                       ; ad2c: c9 07
                bcs $ad39                    ; ad2e: b0 09
                lda #7                       ; ad30: a9 07
                cpx ram245                   ; ad32: ec a9 1c
                cpx ram237                   ; ad35: ec a9 15
                cpx ram230                   ; ad38: ec a9 0e
                sec                          ; ad3b: 38
                sbc arr34                    ; ad3c: e5 48
                sta arr48                    ; ad3e: 85 62
                tax                          ; ad40: aa
                lda #$20                     ; ad41: a9 20
-               sta arr191,x                 ; ad43: 9d 00 07
                dex                          ; ad46: ca
                bpl -                        ; ad47: 10 fa
                jmp sub33                    ; ad49: 4c fb 87
                lda #$ff                     ; ad4c: a9 ff
                eor arr36                    ; ad4e: 45 4c
                sta arr36                    ; ad50: 85 4c
                rts                          ; ad52: 60
                lda arr35                    ; ad53: a5 49
                beq +                        ; ad55: f0 02
                dec arr35                    ; ad57: c6 49
+               rts                          ; ad59: 60
dat28           lda arr34                    ; ad5a: a5 48
                pha                          ; ad5c: 48
                jsr sub202                   ; ad5d: 20 94 ad
                pla                          ; ad60: 68
                sta arr34                    ; ad61: 85 48
                rts                          ; ad63: 60
dat29           lda arr34                    ; ad64: a5 48
                beq +                        ; ad66: f0 03
                dec arr34                    ; ad68: c6 48
                rts                          ; ad6a: 60
+               lda arr35                    ; ad6b: a5 49
                beq +                        ; ad6d: f0 06
                lda #$1b                     ; ad6f: a9 1b
                sta arr34                    ; ad71: 85 48
                dec arr35                    ; ad73: c6 49
+               rts                          ; ad75: 60
                lda arr34                    ; ad76: a5 48
                cmp #$1b                     ; ad78: c9 1b
                beq +                        ; ad7a: f0 03
                inc arr34                    ; ad7c: e6 48
                rts                          ; ad7e: 60
+               jsr sub201                   ; ad7f: 20 8f ad
                lda arr35                    ; ad82: a5 49
                cmp #$17                     ; ad84: c9 17
                beq +                        ; ad86: f0 02
                inc arr35                    ; ad88: e6 49
+               rts                          ; ad8a: 60
sub200          lda #0                       ; ad8b: a9 00
                sta arr35                    ; ad8d: 85 49
sub201          lda #0                       ; ad8f: a9 00
                sta arr34                    ; ad91: 85 48
                rts                          ; ad93: 60
sub202          ldx arr35                    ; ad94: a6 49
                inx                          ; ad96: e8
                cpx #$18                     ; ad97: e0 18
                bne +                        ; ad99: d0 03
                jmp sub196                   ; ad9b: 4c 5d ac
+               stx arr35                    ; ad9e: 86 49
                rts                          ; ada0: 60
sub203          lda #$ff                     ; ada1: a9 ff
                sta arr55                    ; ada3: 85 72
                lda ram129                   ; ada5: a5 e1
                bne cod299                   ; ada7: d0 06
sub204          lda #0                       ; ada9: a9 00
                sta arr55                    ; adab: 85 72
                lda ram128                   ; adad: a5 e0
cod299          sta ram51                    ; adaf: 85 61
                rts                          ; adb1: 60
                ldx arr34                    ; adb2: a6 48
                beq +                        ; adb4: f0 05
                dec arr34                    ; adb6: c6 48
                jmp cod300                   ; adb8: 4c cb ad
+               ldx arr35                    ; adbb: a6 49
                beq cod300                   ; adbd: f0 0c
                dex                          ; adbf: ca
                lda arr169,x                 ; adc0: bd 01 06
                beq cod300                   ; adc3: f0 06
                dec arr35                    ; adc5: c6 49
                lda #$1b                     ; adc7: a9 1b
                sta arr34                    ; adc9: 85 48
cod300          jsr sub198                   ; adcb: 20 a1 ac
-               lda arr34                    ; adce: a5 48
                cmp #$1b                     ; add0: c9 1b
                beq +                        ; add2: f0 1b
                jsr sub187                   ; add4: 20 a6 ab
                lda ram40                    ; add7: a5 4a
                sta ram14                    ; add9: 85 19
                lda ram41                    ; addb: a5 4b
                sta ram15                    ; addd: 85 1a
                inc arr34                    ; addf: e6 48
                jsr sub187                   ; ade1: 20 a6 ab
                dec arr34                    ; ade4: c6 48
                lda #3                       ; ade6: a9 03
                jsr sub34                    ; ade8: 20 08 88
                lda #$1b                     ; adeb: a9 1b
                sta arr34                    ; aded: 85 48
+               ldx arr35                    ; adef: a6 49
                lda arr169,x                 ; adf1: bd 01 06
                bne +                        ; adf4: d0 11
                jsr sub187                   ; adf6: 20 a6 ab
                jsr sub182                   ; adf9: 20 fe aa
                jsr sub188                   ; adfc: 20 d8 ab
                lda #$20                     ; adff: a9 20
                jsr sub189                   ; ae01: 20 e3 ab
                jmp sub199                   ; ae04: 4c aa ac
+               inc arr35                    ; ae07: e6 49
                lda #$ff                     ; ae09: a9 ff
                sta arr34                    ; ae0b: 85 48
                jsr sub205                   ; ae0d: 20 18 ae
                inc arr35                    ; ae10: e6 49
                jsr sub201                   ; ae12: 20 8f ad
                jmp -                        ; ae15: 4c ce ad
sub205          inc arr34                    ; ae18: e6 48
                jsr sub187                   ; ae1a: 20 a6 ab
                jsr sub182                   ; ae1d: 20 fe aa
                jsr sub188                   ; ae20: 20 d8 ab
                lda ppu_data                 ; ae23: ad 07 20
                lda ppu_data                 ; ae26: ad 07 20
                pha                          ; ae29: 48
                jsr sub190                   ; ae2a: 20 e6 ab
                dec arr34                    ; ae2d: c6 48
                lda arr34                    ; ae2f: a5 48
                cmp #$ff                     ; ae31: c9 ff
                bne +                        ; ae33: d0 06
                lda #$1b                     ; ae35: a9 1b
                sta arr34                    ; ae37: 85 48
                dec arr35                    ; ae39: c6 49
+               jsr sub187                   ; ae3b: 20 a6 ab
                jsr sub182                   ; ae3e: 20 fe aa
                jsr sub188                   ; ae41: 20 d8 ab
                pla                          ; ae44: 68
                jmp sub189                   ; ae45: 4c e3 ab
                jsr sub198                   ; ae48: 20 a1 ac
                lda #$20                     ; ae4b: a9 20
                sta arr77                    ; ae4d: 85 b0
-               jsr sub187                   ; ae4f: 20 a6 ab
                lda #$0d                     ; ae52: a9 0d
                jsr sub34                    ; ae54: 20 08 88
                ldx arr35                    ; ae57: a6 49
                lda arr169,x                 ; ae59: bd 01 06
                beq cod302                   ; ae5c: f0 0b
                inc arr35                    ; ae5e: e6 49
                jsr sub201                   ; ae60: 20 8f ad
                jmp -                        ; ae63: 4c 4f ae
cod301          jmp sub199                   ; ae66: 4c aa ac
cod302          lda arr77                    ; ae69: a5 b0
                cmp #$20                     ; ae6b: c9 20
                beq cod301                   ; ae6d: f0 f7
                lda arr35                    ; ae6f: a5 49
                cmp #$17                     ; ae71: c9 17
                beq cod303                   ; ae73: f0 61
                jsr sub201                   ; ae75: 20 8f ad
                ldy arr35                    ; ae78: a4 49
                iny                          ; ae7a: c8
                cpy #$17                     ; ae7b: c0 17
                beq +                        ; ae7d: f0 26
                lda arr35                    ; ae7f: a5 49
                sta ram80                    ; ae81: 85 91
                lda #$16                     ; ae83: a9 16
                sta arr35                    ; ae85: 85 49
-               jsr sub187                   ; ae87: 20 a6 ab
                lda arr35                    ; ae8a: a5 49
                pha                          ; ae8c: 48
                lda #$0e                     ; ae8d: a9 0e
                jsr sub34                    ; ae8f: 20 08 88
                pla                          ; ae92: 68
                sta arr35                    ; ae93: 85 49
                tax                          ; ae95: aa
                lda arr169,x                 ; ae96: bd 01 06
                inx                          ; ae99: e8
                sta arr169,x                 ; ae9a: 9d 01 06
                dec arr35                    ; ae9d: c6 49
                lda arr35                    ; ae9f: a5 49
                cmp ram80                    ; aea1: c5 91
                bne -                        ; aea3: d0 e2
+               ldx arr35                    ; aea5: a6 49
                lda #$ff                     ; aea7: a9 ff
                sta arr169,x                 ; aea9: 9d 01 06
                inc arr35                    ; aeac: e6 49
                inx                          ; aeae: e8
                lda #0                       ; aeaf: a9 00
                sta arr169,x                 ; aeb1: 9d 01 06
                ldx #$17                     ; aeb4: a2 17
                sta arr169,x                 ; aeb6: 9d 01 06
                lda ram57                    ; aeb9: a5 6b
                pha                          ; aebb: 48
                lda ram58                    ; aebc: a5 6c
                pha                          ; aebe: 48
                lda arr36                    ; aebf: a5 4c
                pha                          ; aec1: 48
                lda #5                       ; aec2: a9 05
                jsr sub195                   ; aec4: 20 0d ac
                pla                          ; aec7: 68
                sta arr36                    ; aec8: 85 4c
                lda #$0d                     ; aeca: a9 0d
                jsr sub34                    ; aecc: 20 08 88
                pla                          ; aecf: 68
                sta arr35                    ; aed0: 85 49
                pla                          ; aed2: 68
                sta arr34                    ; aed3: 85 48
                rts                          ; aed5: 60
cod303          lda ram57                    ; aed6: a5 6b
                pha                          ; aed8: 48
                ldx ram58                    ; aed9: a6 6c
                beq +                        ; aedb: f0 01
                dex                          ; aedd: ca
+               txa                          ; aede: 8a
                pha                          ; aedf: 48
                jsr sub196                   ; aee0: 20 5d ac
                lda #$17                     ; aee3: a9 17
                sta arr35                    ; aee5: 85 49
                lda #0                       ; aee7: a9 00
                sta arr34                    ; aee9: 85 48
                jsr sub187                   ; aeeb: 20 a6 ab
                lda #$0d                     ; aeee: a9 0d
                jsr sub34                    ; aef0: 20 08 88
                ldx #$16                     ; aef3: a2 16
                lda #$ff                     ; aef5: a9 ff
                sta arr169,x                 ; aef7: 9d 01 06
                pla                          ; aefa: 68
                sta arr35                    ; aefb: 85 49
                pla                          ; aefd: 68
                sta arr34                    ; aefe: 85 48
                rts                          ; af00: 60
dat30           eor misc112                  ; af01: 4d ac 4c
                lda dat24                    ; af04: ad 4d ac
                lsr $b3ac                    ; af07: 4e ac b3
                ldy dat25                    ; af0a: ac d2 ac
                eor ram233                   ; af0d: 4d ac 0f

                hex b3 b2                    ; af10

                lda dat27                    ; af12: ad 22 ad
                sty arr76,x                  ; af15: 94 ad

                hex 8b                       ; af17

                lda sub186                   ; af18: ad 75 ab

                hex 8f                       ; af1b

                lda dat24                    ; af1c: ad 4d ac
                eor misc116                  ; af1f: 4d ac 4d
                ldy dat24                    ; af22: ac 4d ac
                pha                          ; af25: 48
                ldx dat24                    ; af26: ae 4d ac
                eor misc116                  ; af29: 4d ac 4d
                ldy sub203                   ; af2c: ac a1 ad
                lda #$ad                     ; af2f: a9 ad
                eor misc116                  ; af31: 4d ac 4d
                ldy dat26                    ; af34: ac f4 ac
                eor misc271                  ; af37: 4d ac 76
                lda dat29                    ; af3a: ad 64 ad

                hex 53                       ; af3d

                lda dat28                    ; af3e: ad 5a ad
cod304          lda #0                       ; af41: a9 00
                rts                          ; af43: 60
cod305          sta ram59                    ; af44: 85 6d
                jsr sub209                   ; af46: 20 dc b0
                bcs +                        ; af49: b0 05
                lda ram59                    ; af4b: a5 6d
                and #%11111111               ; af4d: 29 ff
                rts                          ; af4f: 60
+               lda ram59                    ; af50: a5 6d
                ldx ram55                    ; af52: a6 68
                bne cod304                   ; af54: d0 eb
                sta arr51                    ; af56: 85 6a
                lda #4                       ; af58: a9 04
                sta arr57                    ; af5a: 85 74
-               jsr sub207                   ; af5c: 20 9b af
                cmp arr51                    ; af5f: c5 6a
                bne sub206                   ; af61: d0 25
                dec arr57                    ; af63: c6 74
                bne -                        ; af65: d0 f5
                sec                          ; af67: 38
                sbc #$f0                     ; af68: e9 f0
                jsr sub169                   ; af6a: 20 c5 a6
                sta arr50                    ; af6d: 85 67
                lda #$ff                     ; af6f: a9 ff
                sta ram54                    ; af71: 85 66
cod306          ldx arr50                    ; af73: a6 67
                lda arr159,x                 ; af75: bd 80 04
                beq +                        ; af78: f0 06
                inx                          ; af7a: e8
                stx arr50                    ; af7b: 86 67
                and #%11111111               ; af7d: 29 ff
                rts                          ; af7f: 60
+               lda #0                       ; af80: a9 00
                sta ram54                    ; af82: 85 66
                ldx #$ff                     ; af84: a2 ff
                stx ram55                    ; af86: 86 68
sub206          lda ram54                    ; af88: a5 66
                bne cod306                   ; af8a: d0 e7
                jsr sub207                   ; af8c: 20 9b af
                beq +                        ; af8f: f0 07
                cmp #$f0                     ; af91: c9 f0
                bcs cod305                   ; af93: b0 af
                and #%11111111               ; af95: 29 ff
                rts                          ; af97: 60
+               sta ram55                    ; af98: 85 68
                rts                          ; af9a: 60
sub207          lda #5                       ; af9b: a9 05
                sta joypad1                  ; af9d: 8d 16 40
                nop                          ; afa0: ea
                nop                          ; afa1: ea
                nop                          ; afa2: ea
                nop                          ; afa3: ea
                nop                          ; afa4: ea
                nop                          ; afa5: ea
                ldx #0                       ; afa6: a2 00
cod307          lda #4                       ; afa8: a9 04
                sta joypad1                  ; afaa: 8d 16 40
                ldy #$0a                     ; afad: a0 0a
-               dey                          ; afaf: 88
                bne -                        ; afb0: d0 fd
                nop                          ; afb2: ea
                nop                          ; afb3: ea
                lda joypad2                  ; afb4: ad 17 40
                lsr a                        ; afb7: 4a
                and #%00001111               ; afb8: 29 0f
                sta arr174,x                 ; afba: 9d 34 06
                lda #6                       ; afbd: a9 06
                sta joypad1                  ; afbf: 8d 16 40
                ldy #$0a                     ; afc2: a0 0a
-               dey                          ; afc4: 88
                bne -                        ; afc5: d0 fd
                nop                          ; afc7: ea
                nop                          ; afc8: ea
                lda joypad2                  ; afc9: ad 17 40
                rol a                        ; afcc: 2a
                rol a                        ; afcd: 2a
                rol a                        ; afce: 2a
                and #%11110000               ; afcf: 29 f0
                ora arr174,x                 ; afd1: 1d 34 06
                eor #%11111111               ; afd4: 49 ff
                ldy #8                       ; afd6: a0 08
-               asl a                        ; afd8: 0a
                ror arr174,x                 ; afd9: 7e 34 06
                dey                          ; afdc: 88
                bne -                        ; afdd: d0 f9
                inx                          ; afdf: e8
                cpx #9                       ; afe0: e0 09
                bne cod307                   ; afe2: d0 c4
                lda #0                       ; afe4: a9 00
                sta arr52                    ; afe6: 85 6f
                sta arr53                    ; afe8: 85 70
                sta arr54                    ; afea: 85 71
                lda ram211                   ; afec: ad 3b 06
                and #%00010000               ; afef: 29 10
                bne cod308                   ; aff1: d0 2b
                lda ram211                   ; aff3: ad 3b 06
                and #%00001000               ; aff6: 29 08
                bne cod310                   ; aff8: d0 44
                lda arr174                   ; affa: ad 34 06
                and #%00000100               ; affd: 29 04
                bne cod311                   ; afff: d0 45
                lda ram211                   ; b001: ad 3b 06
                and #%00000100               ; b004: 29 04
                bne cod312                   ; b006: d0 4f
                jsr sub208                   ; b008: 20 2c b0
                bne +                        ; b00b: d0 03
                sta arr12                    ; b00d: 85 18
                rts                          ; b00f: 60
+               ldy arr12                    ; b010: a4 18
                bne +                        ; b012: d0 07
                ldy arr39                    ; b014: a4 50
                bne +                        ; b016: d0 03
                and #%11111111               ; b018: 29 ff
                rts                          ; b01a: 60
+               lda #0                       ; b01b: a9 00
                rts                          ; b01d: 60
cod308          lda #$ff                     ; b01e: a9 ff
                sta arr52                    ; b020: 85 6f
                sta arr12                    ; b022: 85 18
cod309          lda ram211                   ; b024: ad 3b 06
                and #%11100011               ; b027: 29 e3
                sta ram211                   ; b029: 8d 3b 06
sub208          ldx #0                       ; b02c: a2 00
                ldy #9                       ; b02e: a0 09
-               lda arr174,x                 ; b030: bd 34 06
                bne cod313                   ; b033: d0 2b
                inx                          ; b035: e8
                dey                          ; b036: 88
                bne -                        ; b037: d0 f7
                sta ram59                    ; b039: 85 6d
                sta arr39                    ; b03b: 85 50
                rts                          ; b03d: 60
cod310          lda #$ff                     ; b03e: a9 ff
                sta arr12                    ; b040: 85 18
                sta arr53                    ; b042: 85 70
                bne cod309                   ; b044: d0 de
cod311          lda #$ff                     ; b046: a9 ff
                sta arr12                    ; b048: 85 18
                sta arr53                    ; b04a: 85 70
                lda arr174                   ; b04c: ad 34 06
                and #%11111011               ; b04f: 29 fb
                sta arr174                   ; b051: 8d 34 06
                jmp cod309                   ; b054: 4c 24 b0
cod312          lda #$ff                     ; b057: a9 ff
                sta arr54                    ; b059: 85 71
                sta arr12                    ; b05b: 85 18
                jmp cod309                   ; b05d: 4c 24 b0
cod313          stx ram60                    ; b060: 86 6e
                ldy #0                       ; b062: a0 00
                clc                          ; b064: 18
-               lsr a                        ; b065: 4a
                bcs +                        ; b066: b0 04
                iny                          ; b068: c8
                jmp -                        ; b069: 4c 65 b0
+               txa                          ; b06c: 8a
                asl a                        ; b06d: 0a
                asl a                        ; b06e: 0a
                asl a                        ; b06f: 0a
                sty ram59                    ; b070: 84 6d
                clc                          ; b072: 18
                adc ram59                    ; b073: 65 6d
                tax                          ; b075: aa
                lda arr52                    ; b076: a5 6f
                bne cod315                   ; b078: d0 22
                lda arr53                    ; b07a: a5 70
                bne cod317                   ; b07c: d0 34
                lda arr54                    ; b07e: a5 71
                bne cod318                   ; b080: d0 38
                lda arr55                    ; b082: a5 72
                bne cod319                   ; b084: d0 3d
                lda dat31,x                  ; b086: bd ec b0
                cmp #$ff                     ; b089: c9 ff
                beq +                        ; b08b: f0 03
                and #%11111111               ; b08d: 29 ff
                rts                          ; b08f: 60
+               cmp arr39                    ; b090: c5 50
                beq cod314                   ; b092: f0 05
                sta arr39                    ; b094: 85 50
                jsr sub203                   ; b096: 20 a1 ad
cod314          lda #0                       ; b099: a9 00
                rts                          ; b09b: 60
cod315          lda dat31,x                  ; b09c: bd ec b0
                cmp #$20                     ; b09f: c9 20
                bcs +                        ; b0a1: b0 03
                and #%11111111               ; b0a3: 29 ff
                rts                          ; b0a5: 60
+               sec                          ; b0a6: 38
                sbc #$40                     ; b0a7: e9 40
                bcc cod314                   ; b0a9: 90 ee
                cmp #$20                     ; b0ab: c9 20
                bcs cod314                   ; b0ad: b0 ea
cod316          and #%11111111               ; b0af: 29 ff
                rts                          ; b0b1: 60
cod317          lda arr55                    ; b0b2: a5 72
                bne cod320                   ; b0b4: d0 13
                lda $b134,x                  ; b0b6: bd 34 b1
                rts                          ; b0b9: 60
cod318          lda arr55                    ; b0ba: a5 72
                bne +                        ; b0bc: d0 01
                rts                          ; b0be: 60
+               lda $b20c,x                  ; b0bf: bd 0c b2
                rts                          ; b0c2: 60
cod319          lda $b17c,x                  ; b0c3: bd 7c b1
                jmp cod321                   ; b0c6: 4c cc b0
cod320          lda $b1c4,x                  ; b0c9: bd c4 b1
cod321          cmp #$ff                     ; b0cc: c9 ff
                bne cod316                   ; b0ce: d0 df
                cmp arr39                    ; b0d0: c5 50
                beq cod314                   ; b0d2: f0 c5
                sta arr39                    ; b0d4: 85 50
                jsr sub204                   ; b0d6: 20 a9 ad
                lda #0                       ; b0d9: a9 00
cod322          rts                          ; b0db: 60
sub209          ldy #8                       ; b0dc: a0 08
                ldx #0                       ; b0de: a2 00
-               lda arr174,x                 ; b0e0: bd 34 06
                asl a                        ; b0e3: 0a
                bcs cod322                   ; b0e4: b0 f5
                inx                          ; b0e6: e8
                dey                          ; b0e7: 88
                bne -                        ; b0e8: d0 f6
                clc                          ; b0ea: 18
                rts                          ; b0eb: 60

dat31           hex 03 5c                    ; b0ec

                brk                          ; b0ee: 00

                hex ff b3 b2                 ; b0ef

                ora misc161                  ; b0f2: 0d f7 5e
                and_abs ram29                ; b0f5: 2d 2f 00

                hex 3b 3a                    ; b0f8

                rti                          ; b0fa: 40
                inc arr20,x                  ; b0fb: f6 30
                bvc +                        ; b0fd: 50 2c
                rol misc109                  ; b0ff: 2e 4b 4c

                hex 4f                       ; b102

                sbc arr24,x                  ; b103: f5 38
                and misc115,y                ; b105: 39 4e 4d
                lsr a                        ; b108: 4a
                eor arr35,x                  ; b109: 55 49

                hex f4                       ; b10b

                rol arr23,x                  ; b10c: 36 37
                lsr arr29,x                  ; b10e: 56 42
                pha                          ; b110: 48

                hex 47                       ; b111

                eor misc54,y                 ; b112: 59 f3 34
                and arr30,x                  ; b115: 35 43
                lsr arr31                    ; b117: 46 44

                hex 52 54 f2 33              ; b119

                eor ram45                    ; b11d: 45 5a
                cli                          ; b11f: 58
                eor (arr42,x)                ; b120: 41 53

                hex 57                       ; b122

                sbc (arr21),y                ; b123: f1 32
                and (arr1),y                 ; b125: 31 00
                brk                          ; b127: 00
                brk                          ; b128: 00
                eor (ram16),y                ; b129: 51 1b
+               beq $b13f                    ; b12b: f0 12
                php                          ; b12d: 08
                jsr ram246                   ; b12e: 20 1f 1d

                hex 1c                       ; b131

                asl arr136,x                 ; b132: 1e 0b 03
                brk                          ; b135: 00
                brk                          ; b136: 00
                brk                          ; b137: 00
                brk                          ; b138: 00
                brk                          ; b139: 00
                ora_abs arr12                ; b13a: 0d 18 00
                and misc162,x                ; b13d: 3d 3f 5f

                hex 2b                       ; b140

                rol a                        ; b141: 2a
                brk                          ; b142: 00

                hex 17                       ; b143

                brk                          ; b144: 00
                brk                          ; b145: 00

                hex 3c                       ; b146

                rol_absx arr1                ; b147: 3e 00 00
                brk                          ; b14a: 00
                ora (ram24),y                ; b14b: 11 28
                and #%00000000               ; b14d: 29 00
                brk                          ; b14f: 00
                brk                          ; b150: 00
                brk                          ; b151: 00
                brk                          ; b152: 00
                bpl $b17b                    ; b153: 10 26

                hex 27                       ; b155

                brk                          ; b156: 00
                brk                          ; b157: 00
                brk                          ; b158: 00
                brk                          ; b159: 00
                brk                          ; b15a: 00

                hex 0f                       ; b15b

                bit arr17                    ; b15c: 24 25
                brk                          ; b15e: 00
                brk                          ; b15f: 00
                brk                          ; b160: 00
                brk                          ; b161: 00
                brk                          ; b162: 00
                asl_abs arr16                ; b163: 0e 23 00
                brk                          ; b166: 00
                brk                          ; b167: 00
                brk                          ; b168: 00
                brk                          ; b169: 00
                brk                          ; b16a: 00
                asl ram20                    ; b16b: 06 22
                and (arr1,x)                 ; b16d: 21 00
                brk                          ; b16f: 00
                brk                          ; b170: 00
                brk                          ; b171: 00

                hex 1b 02 12                 ; b172

                php                          ; b175: 08
                jsr ram246                   ; b176: 20 1f 1d

                hex 1c                       ; b179

                asl arr137,x                 ; b17a: 1e 0c 03
                dey                          ; b17d: 88
                brk                          ; b17e: 00

                hex ff                       ; b17f

                lda (ram76),y                ; b180: b1 8a
                ora dat6                     ; b182: 0d f7 87
                stx arr65                    ; b185: 86 8d
                sty misc40                   ; b187: 8c 82 2d

                hex 89                       ; b18a

                inc arr60,x                  ; b18b: f6 78
                adc $8b85,x                  ; b18d: 7d 85 8b

                hex 80                       ; b190

                sta (ram64,x)                ; b191: 81 7c
                sbc arr58,x                  ; b193: f5 76

                hex 77 83                    ; b195

                sty ram67                    ; b197: 84 7f

                hex 7a 7b f4 74              ; b199

                adc arr55,x                  ; b19d: 75 72

                hex 73                       ; b19f

                ror misc276,x                ; b1a0: 7e 6e 79

                hex f3 63 64                 ; b1a3

                adc (ram59),y                ; b1a6: 71 6d
                jmp (misc206)                ; b1a8: 6c 68 69

                hex f2 62 67 6f              ; b1ab

                bvs cod323                   ; b1af: 70 6a

                hex 6b                       ; b1b1

                ror arr100                   ; b1b2: 66 f1
                adc (arr47,x)                ; b1b4: 61 60
                brk                          ; b1b6: 00
                brk                          ; b1b7: 00
                brk                          ; b1b8: 00
                adc ram16                    ; b1b9: 65 1b
                beq +                        ; b1bb: f0 12
                php                          ; b1bd: 08
                jsr ram246                   ; b1be: 20 1f 1d

                hex 1c                       ; b1c1

                asl arr136,x                 ; b1c2: 1e 0b 03
                brk                          ; b1c5: 00
                brk                          ; b1c6: 00

                hex ff                       ; b1c7

                eor arr201,x                 ; b1c8: 5d 5b 0d

                hex f7                       ; b1cb

                brk                          ; b1cc: 00
                brk                          ; b1cd: 00
                brk                          ; b1ce: 00
+               brk                          ; b1cf: 00
                brk                          ; b1d0: 00
                brk                          ; b1d1: 00
                brk                          ; b1d2: 00
                inc arr1,x                   ; b1d3: f6 00

                hex af                       ; b1d5

                sta arr1,x                   ; b1d6: 95 00
                brk                          ; b1d8: 00
                brk                          ; b1d9: 00
                ldx_abs arr102               ; b1da: ae f5 00
                brk                          ; b1dd: 00

                hex 93                       ; b1de

                sty arr1,x                   ; b1df: 94 00
                ldy dat148                   ; b1e1: ac ad f4
                brk                          ; b1e4: 00
                brk                          ; b1e5: 00
                brk                          ; b1e6: 00
                brk                          ; b1e7: 00
                brk                          ; b1e8: 00
                brk                          ; b1e9: 00

                hex ab f3                    ; b1ea

                sta (ram81),y                ; b1ec: 91 92
                stx arr1,y                   ; b1ee: 96 00
                brk                          ; b1f0: 00
                brk                          ; b1f1: 00
                brk                          ; b1f2: 00

                hex f2                       ; b1f3

                bcc +                        ; b1f4: 90 00
+               brk                          ; b1f6: 00
                brk                          ; b1f7: 00
                brk                          ; b1f8: 00
                brk                          ; b1f9: 00
                brk                          ; b1fa: 00
                sbc (ram78),y                ; b1fb: f1 8f
                stx_abs arr1                 ; b1fd: 8e 00 00
                brk                          ; b200: 00
                brk                          ; b201: 00

                hex 1b                       ; b202

                beq +                        ; b203: f0 12
                php                          ; b205: 08
                jsr ram246                   ; b206: 20 1f 1d

                hex 1c                       ; b209

                asl arr137,x                 ; b20a: 1e 0c 03
                inc_absx arr1                ; b20d: fe 00 00
                brk                          ; b210: 00
                brk                          ; b211: 00
                ora dat162                   ; b212: 0d f7 fd

                hex f2                       ; b215

                brk                          ; b216: 00
+               brk                          ; b217: 00
                brk                          ; b218: 00
                brk                          ; b219: 00
                brk                          ; b21a: 00
cod323          inc arr100,x                 ; b21b: f6 f1
                tax                          ; b21d: aa
                brk                          ; b21e: 00
                brk                          ; b21f: 00
                brk                          ; b220: 00
                brk                          ; b221: 00
                lda #$f5                     ; b222: a9 f5

                hex ef                       ; b224

                beq +                        ; b225: f0 00
+               brk                          ; b227: 00
                brk                          ; b228: 00

                hex a7                       ; b229

                tay                          ; b22a: a8

                hex f4                       ; b22b

                sbc $a4ee                    ; b22c: ed ee a4
                lda arr1                     ; b22f: a5 00
                ldy #$a6                     ; b231: a0 a6

                hex f3 eb                    ; b233

                cpx dat16                    ; b235: ec a3 9f

                hex 9e                       ; b238

                txs                          ; b239: 9a

                hex 9b f2                    ; b23a

                nop                          ; b23c: ea
                sta $a2a1,y                  ; b23d: 99 a1 a2

                hex 9c                       ; b240

                sta dat147,x                 ; b241: 9d 98 f1
                sbc #$e8                     ; b244: e9 e8
                brk                          ; b246: 00
                brk                          ; b247: 00
                brk                          ; b248: 00

                hex 97 1b                    ; b249

                beq $b25f                    ; b24b: f0 12
                php                          ; b24d: 08
                jsr ram246                   ; b24e: 20 1f 1d

                hex 1c                       ; b251

                asl misc1,x                  ; b252: 1e 0b 20
                ldx arr75                    ; b255: a6 ab
                lda #8                       ; b257: a9 08
                bne cod324                   ; b259: d0 05
sub210          jsr sub187                   ; b25b: 20 a6 ab
                lda #9                       ; b25e: a9 09
cod324          jmp sub34                    ; b260: 4c 08 88
sub211          lda #0                       ; b263: a9 00
                sta ram49                    ; b265: 85 5e
                jsr sub206                   ; b267: 20 88 af
                beq cod329                   ; b26a: f0 46
                ldx ram54                    ; b26c: a6 66
                bne cod326                   ; b26e: d0 25
                cmp ram61                    ; b270: c5 75
                bne cod329                   ; b272: d0 3e
                lda ram63                    ; b274: a5 7b
                bne cod327                   ; b276: d0 20
                jsr $b254                    ; b278: 20 54 b2
-               jsr sub206                   ; b27b: 20 88 af
                beq cod328                   ; b27e: f0 2f
                cmp ram61                    ; b280: c5 75
                bne cod328                   ; b282: d0 2b
                dec arr59                    ; b284: c6 77
                bne -                        ; b286: d0 f3
                dec arr60                    ; b288: c6 78
                bne -                        ; b28a: d0 ef
                lda #$ff                     ; b28c: a9 ff
                sta ram63                    ; b28e: 85 7b
                jmp cod332                   ; b290: 4c 06 b3
cod325          lda #3                       ; b293: a9 03
cod326          sta ram61                    ; b295: 85 75
                rts                          ; b297: 60
cod327          jsr sub206                   ; b298: 20 88 af
                beq cod329                   ; b29b: f0 15
                cmp ram61                    ; b29d: c5 75
                bne cod329                   ; b29f: d0 11
                dec arr61                    ; b2a1: c6 79
                bne cod327                   ; b2a3: d0 f3
                lda #$20                     ; b2a5: a9 20
                sta arr61                    ; b2a7: 85 79
                jsr $b254                    ; b2a9: 20 54 b2
                jmp cod332                   ; b2ac: 4c 06 b3
cod328          jsr sub210                   ; b2af: 20 5b b2
cod329          lda #0                       ; b2b2: a9 00
                sta ram63                    ; b2b4: 85 7b
                sta arr59                    ; b2b6: 85 77
                lda #$20                     ; b2b8: a9 20
                sta arr61                    ; b2ba: 85 79
                lda #1                       ; b2bc: a9 01
                sta arr60                    ; b2be: 85 78
                jsr $b254                    ; b2c0: 20 54 b2
                lda #$80                     ; b2c3: a9 80
                sta arr57                    ; b2c5: 85 74
-               jsr sub206                   ; b2c7: 20 88 af
                bne cod331                   ; b2ca: d0 25
                dec arr57                    ; b2cc: c6 74
                bne -                        ; b2ce: d0 f7
                jsr sub210                   ; b2d0: 20 5b b2
                lda ram49                    ; b2d3: a5 5e
                bne cod325                   ; b2d5: d0 bc
                lda #$80                     ; b2d7: a9 80
                sta arr57                    ; b2d9: 85 74
-               jsr sub206                   ; b2db: 20 88 af
                bne cod331                   ; b2de: d0 11
                dec arr57                    ; b2e0: c6 74
                bne -                        ; b2e2: d0 f7
                lda ram49                    ; b2e4: a5 5e
                bne cod325                   ; b2e6: d0 ab
                jmp cod329                   ; b2e8: 4c b2 b2
cod330          jsr sub210                   ; b2eb: 20 5b b2
                jmp cod329                   ; b2ee: 4c b2 b2
cod331          sta ram61                    ; b2f1: 85 75
                lda ram54                    ; b2f3: a5 66
                bne cod332                   ; b2f5: d0 0f
                lda #1                       ; b2f7: a9 01
                sta arr57                    ; b2f9: 85 74
-               jsr sub206                   ; b2fb: 20 88 af
                cmp ram61                    ; b2fe: c5 75
                bne cod330                   ; b300: d0 e9
                dec arr57                    ; b302: c6 74
                bne -                        ; b304: d0 f5
cod332          jsr sub210                   ; b306: 20 5b b2
                jsr $b314                    ; b309: 20 14 b3
                lda ram61                    ; b30c: a5 75
                rts                          ; b30e: 60
sub212          lda #$f0                     ; b30f: a9 f0
                sta ram14                    ; b311: 85 19
                ldx ram147                   ; b313: ae a9 01
                sta ram14                    ; b316: 85 19
                lda #1                       ; b318: a9 01
                sta snd_chn                  ; b31a: 8d 15 40
                lda #$c0                     ; b31d: a9 c0
                sta joypad2                  ; b31f: 8d 17 40
                lda #$ef                     ; b322: a9 ef
                sta sq1_vol                  ; b324: 8d 00 40
                lda #0                       ; b327: a9 00
                sta sq1_sweep                ; b329: 8d 01 40
                lda #$5f                     ; b32c: a9 5f
                sta sq1_lo                   ; b32e: 8d 02 40
                ldy #0                       ; b331: a0 00
                sty sq1_hi                   ; b333: 8c 03 40
-               dey                          ; b336: 88
                bne -                        ; b337: d0 fd
                dec ram14                    ; b339: c6 19
                bne -                        ; b33b: d0 f9
                lda #0                       ; b33d: a9 00
                sta snd_chn                  ; b33f: 8d 15 40
                rts                          ; b342: 60
sub213          lda #0                       ; b343: a9 00
                sta arr58                    ; b345: 85 76
                sta ram52                    ; b347: 85 63
-               jsr sub211                   ; b349: 20 63 b2
                cmp #$0d                     ; b34c: c9 0d
                beq cod333                   ; b34e: f0 1e
                cmp #3                       ; b350: c9 03
                beq +                        ; b352: f0 0a
                cmp #4                       ; b354: c9 04
                beq +                        ; b356: f0 06
                jsr sub195                   ; b358: 20 0d ac
                jmp -                        ; b35b: 4c 49 b3
+               jsr sub195                   ; b35e: 20 0d ac
                ldx arr58                    ; b361: a6 76
                lda #0                       ; b363: a9 00
                sta arr161,x                 ; b365: 9d 01 05
                lda #3                       ; b368: a9 03
                sta arr160,x                 ; b36a: 9d 00 05
                rts                          ; b36d: 60
cod333          lda arr35                    ; b36e: a5 49
                beq +                        ; b370: f0 0c
                tax                          ; b372: aa
                dex                          ; b373: ca
                lda arr169,x                 ; b374: bd 01 06
                beq +                        ; b377: f0 05
                dec arr35                    ; b379: c6 49
                jmp cod333                   ; b37b: 4c 6e b3
+               lda arr35                    ; b37e: a5 49
                sta ram39                    ; b380: 85 47
                lda #2                       ; b382: a9 02
                jsr sub34                    ; b384: 20 08 88
                lda arr49                    ; b387: a5 64
                bne +                        ; b389: d0 0a
                ldx arr58                    ; b38b: a6 76
                dex                          ; b38d: ca
                lda #0                       ; b38e: a9 00
                sta arr160,x                 ; b390: 9d 00 05
                stx arr58                    ; b393: 86 76
+               ldx arr58                    ; b395: a6 76
-               dex                          ; b397: ca
                txa                          ; b398: 8a
                beq +                        ; b399: f0 07
                lda arr160,x                 ; b39b: bd 00 05
                cmp #$20                     ; b39e: c9 20
                beq -                        ; b3a0: f0 f5
+               inx                          ; b3a2: e8
                lda #0                       ; b3a3: a9 00
                sta arr160,x                 ; b3a5: 9d 00 05
                jmp cod297                   ; b3a8: 4c 4e ac
sub214          inc arr76                    ; b3ab: e6 ad
                bne cod334                   ; b3ad: d0 02
                inc ram99                    ; b3af: e6 ae
cod334          rts                          ; b3b1: 60
sub215          inc ram80                    ; b3b2: e6 91
                bne cod334                   ; b3b4: d0 fb
                inc ram81                    ; b3b6: e6 92
                rts                          ; b3b8: 60
sub216          lda arr76                    ; b3b9: a5 ad
                cmp ram100                   ; b3bb: c5 af
                bne cod334                   ; b3bd: d0 f2
                lda ram99                    ; b3bf: a5 ae
                cmp arr77                    ; b3c1: c5 b0
                rts                          ; b3c3: 60
sub217          lda ram204                   ; b3c4: ad 14 05
                sta arr76                    ; b3c7: 85 ad
                clc                          ; b3c9: 18
                adc ram202                   ; b3ca: 6d 12 05
                sta ram100                   ; b3cd: 85 af
                lda ram205                   ; b3cf: ad 15 05
                sta ram99                    ; b3d2: 85 ae
                adc ram203                   ; b3d4: 6d 13 05
                sta arr77                    ; b3d7: 85 b0
                rts                          ; b3d9: 60
sub218          lda #0                       ; b3da: a9 00
                sta arr76                    ; b3dc: 85 ad
                lda #5                       ; b3de: a9 05
                sta ram99                    ; b3e0: 85 ae
                lda #$80                     ; b3e2: a9 80
                sta ram100                   ; b3e4: 85 af
                lda #5                       ; b3e6: a9 05
                sta arr77                    ; b3e8: 85 b0
                rts                          ; b3ea: 60
sub219          lda arr21                    ; b3eb: a5 32
                sta ppu_ctrl                 ; b3ed: 8d 00 20
                rts                          ; b3f0: 60
sub220          lda arr21                    ; b3f1: a5 32
                ora #%10000000               ; b3f3: 09 80
                sta ppu_ctrl                 ; b3f5: 8d 00 20
                rts                          ; b3f8: 60
sub221          jsr sub219                   ; b3f9: 20 eb b3
                lda #1                       ; b3fc: a9 01
                jmp cod335                   ; b3fe: 4c 06 b4
sub222          jsr sub219                   ; b401: 20 eb b3
                lda #0                       ; b404: a9 00
cod335          sta ram101                   ; b406: 85 b1
                lda #0                       ; b408: a9 00
dat32           sta ram81                    ; b40a: 85 92
                jsr sub217                   ; b40c: 20 c4 b3
cod336          lda #$14                     ; b40f: a9 14
                sta ram80                    ; b411: 85 91
-               jsr sub225                   ; b413: 20 c0 b4
                bcs cod338                   ; b416: b0 0d
                bne cod336                   ; b418: d0 f5
                dec ram80                    ; b41a: c6 91
                bne -                        ; b41c: d0 f5
                lda #$14                     ; b41e: a9 14
                sta ram80                    ; b420: 85 91
cod337          jsr sub225                   ; b422: 20 c0 b4
cod338          bcs cod343                   ; b425: b0 71
                beq cod336                   ; b427: f0 e6
                dec ram80                    ; b429: c6 91
                bne cod337                   ; b42b: d0 f5
                jmp cod340                   ; b42d: 4c 58 b4
sub223          jsr sub219                   ; b430: 20 eb b3
                lda #0                       ; b433: a9 00
                sta ram101                   ; b435: 85 b1
                jsr sub218                   ; b437: 20 da b3
cod339          lda #$28                     ; b43a: a9 28
                sta ram80                    ; b43c: 85 91
-               jsr sub225                   ; b43e: 20 c0 b4
                bcs cod343                   ; b441: b0 55
                bne cod339                   ; b443: d0 f5
                dec ram80                    ; b445: c6 91
                bne -                        ; b447: d0 f5
                lda #$28                     ; b449: a9 28
                sta ram80                    ; b44b: 85 91
-               jsr sub225                   ; b44d: 20 c0 b4
                bcs cod343                   ; b450: b0 46
                beq cod339                   ; b452: f0 e6
                dec ram80                    ; b454: c6 91
                bne -                        ; b456: d0 f5
cod340          lda #0                       ; b458: a9 00
                sta ram80                    ; b45a: 85 91
                sta ram81                    ; b45c: 85 92
                jsr sub224                   ; b45e: 20 a6 b4
                jsr sub224                   ; b461: 20 a6 b4
cod341          jsr sub226                   ; b464: 20 d4 b4
                bcs cod343                   ; b467: b0 2f
                ldx ram101                   ; b469: a6 b1
                bne +                        ; b46b: d0 07
                ldy #0                       ; b46d: a0 00
                sta (arr76),y                ; b46f: 91 ad
                jmp cod342                   ; b471: 4c 7a b4
+               ldy #0                       ; b474: a0 00
                cmp (arr76),y                ; b476: d1 ad
                bne cod343                   ; b478: d0 1e
cod342          jsr sub214                   ; b47a: 20 ab b3
                jsr sub216                   ; b47d: 20 b9 b3
                bne cod341                   ; b480: d0 e2
                lda ram80                    ; b482: a5 91
                sta arr18                    ; b484: 85 2c
                lda ram81                    ; b486: a5 92
                sta arr19                    ; b488: 85 2d
                jsr sub226                   ; b48a: 20 d4 b4
                cmp arr19                    ; b48d: c5 2d
                bne cod343                   ; b48f: d0 07
                jsr sub226                   ; b491: 20 d4 b4
                cmp arr18                    ; b494: c5 2c
                beq cod345                   ; b496: f0 07
cod343          jsr sub220                   ; b498: 20 f1 b3
                lda #2                       ; b49b: a9 02
cod344          sec                          ; b49d: 38
                rts                          ; b49e: 60
cod345          jsr sub220                   ; b49f: 20 f1 b3
                lda #0                       ; b4a2: a9 00
                clc                          ; b4a4: 18
                rts                          ; b4a5: 60
sub224          jsr sub26                    ; b4a6: 20 b9 86
dat33           beq cod344                   ; b4a9: f0 f2
                lda joypad1                  ; b4ab: ad 16 40
                and #%00000010               ; b4ae: 29 02
                beq sub224                   ; b4b0: f0 f4
-               jsr sub26                    ; b4b2: 20 b9 86
                beq cod344                   ; b4b5: f0 e6
                lda joypad1                  ; b4b7: ad 16 40
                and #%00000010               ; b4ba: 29 02
                bne -                        ; b4bc: d0 f4
                clc                          ; b4be: 18
                rts                          ; b4bf: 60
sub225          jsr sub224                   ; b4c0: 20 a6 b4
                bcs cod344                   ; b4c3: b0 d8
                ldy #$4e                     ; b4c5: a0 4e
                sty ram61                    ; b4c7: 84 75
-               dec ram61                    ; b4c9: c6 75
                bne -                        ; b4cb: d0 fc
                lda joypad1                  ; b4cd: ad 16 40
                and #%00000010               ; b4d0: 29 02
                clc                          ; b4d2: 18
                rts                          ; b4d3: 60
sub226          lda #8                       ; b4d4: a9 08
                sta arr57                    ; b4d6: 85 74
                lda #0                       ; b4d8: a9 00
                sta ram14                    ; b4da: 85 19
-               lda ram14                    ; b4dc: a5 19
                clc                          ; b4de: 18
                adc ram14                    ; b4df: 65 19
                sta ram14                    ; b4e1: 85 19
                jsr sub225                   ; b4e3: 20 c0 b4
                bcs cod344                   ; b4e6: b0 b5
                bne +                        ; b4e8: d0 05
                jsr sub215                   ; b4ea: 20 b2 b3
                inc ram14                    ; b4ed: e6 19
+               dec arr57                    ; b4ef: c6 74
                bne -                        ; b4f1: d0 e9
                jsr sub224                   ; b4f3: 20 a6 b4
                bcs cod344                   ; b4f6: b0 a5
                lda ram14                    ; b4f8: a5 19
                clc                          ; b4fa: 18
                rts                          ; b4fb: 60
sub227          jsr sub219                   ; b4fc: 20 eb b3
                jsr sub218                   ; b4ff: 20 da b3
                lda #$28                     ; b502: a9 28
                sta ram80                    ; b504: 85 91
                lda #0                       ; b506: a9 00
                sta ram81                    ; b508: 85 92
                jmp cod346                   ; b50a: 4c 1b b5
sub228          jsr sub219                   ; b50d: 20 eb b3
                jsr sub217                   ; b510: 20 c4 b3
                lda #$14                     ; b513: a9 14
                sta ram80                    ; b515: 85 91
                lda #0                       ; b517: a9 00
                sta ram81                    ; b519: 85 92
cod346          lda #$20                     ; b51b: a9 20
                sta ram14                    ; b51d: 85 19
                lda #$4e                     ; b51f: a9 4e
                sta ram15                    ; b521: 85 1a
-               jsr sub230                   ; b523: 20 86 b5
                dec ram14                    ; b526: c6 19
                bne -                        ; b528: d0 f9
                dec ram15                    ; b52a: c6 1a
                bne -                        ; b52c: d0 f5
                lda ram80                    ; b52e: a5 91
                sta ram14                    ; b530: 85 19
-               jsr sub231                   ; b532: 20 90 b5
                dec ram14                    ; b535: c6 19
                bne -                        ; b537: d0 f9
-               jsr sub230                   ; b539: 20 86 b5
                dec ram80                    ; b53c: c6 91
                bne -                        ; b53e: d0 f9
                jsr sub231                   ; b540: 20 90 b5
                lda #0                       ; b543: a9 00
                sta ram80                    ; b545: 85 91
                sta ram81                    ; b547: 85 92
-               ldy #0                       ; b549: a0 00
                lda (arr76),y                ; b54b: b1 ad
                jsr sub229                   ; b54d: 20 6a b5
                jsr sub214                   ; b550: 20 ab b3
                jsr sub216                   ; b553: 20 b9 b3
                bne -                        ; b556: d0 f1
                lda ram80                    ; b558: a5 91
                pha                          ; b55a: 48
                lda ram81                    ; b55b: a5 92
                jsr sub229                   ; b55d: 20 6a b5
                pla                          ; b560: 68
                jsr sub229                   ; b561: 20 6a b5
                jsr sub231                   ; b564: 20 90 b5
                jmp sub220                   ; b567: 4c f1 b3
sub229          jsr sub231                   ; b56a: 20 90 b5
                ldx #8                       ; b56d: a2 08
cod347          sta ram14                    ; b56f: 85 19
                clc                          ; b571: 18
                adc ram14                    ; b572: 65 19
                bcs cod349                   ; b574: b0 07
                jsr sub230                   ; b576: 20 86 b5
cod348          dex                          ; b579: ca
                bne cod347                   ; b57a: d0 f3
                rts                          ; b57c: 60
cod349          jsr sub231                   ; b57d: 20 90 b5
                jsr sub215                   ; b580: 20 b2 b3
                jmp cod348                   ; b583: 4c 79 b5
sub230          pha                          ; b586: 48
                lda #$34                     ; b587: a9 34
                sta ram16                    ; b589: 85 1b
                sta ram17                    ; b58b: 85 1c
                jmp cod350                   ; b58d: 4c 97 b5
sub231          pha                          ; b590: 48
                lda #$6a                     ; b591: a9 6a
                sta ram16                    ; b593: 85 1b
                sta ram17                    ; b595: 85 1c
cod350          lda #4                       ; b597: a9 04
                sta joypad1                  ; b599: 8d 16 40
-               dec ram17                    ; b59c: c6 1c
                bne -                        ; b59e: d0 fc
                lda #$ff                     ; b5a0: a9 ff
                sta joypad1                  ; b5a2: 8d 16 40
-               dec ram16                    ; b5a5: c6 1b
                bne -                        ; b5a7: d0 fc
                pla                          ; b5a9: 68
                rts                          ; b5aa: 60
                lda #0                       ; b5ab: a9 00
                sta ram89                    ; b5ad: 85 9e
cod351          jsr sub170                   ; b5af: 20 df a6
                jsr $aa82                    ; b5b2: 20 82 aa
                lda ram89                    ; b5b5: a5 9e
                cmp #$81                     ; b5b7: c9 81
                beq +                        ; b5b9: f0 03
                jsr sub185                   ; b5bb: 20 71 ab
+               jsr sub182                   ; b5be: 20 fe aa
                jsr sub190                   ; b5c1: 20 e6 ab
                lda arr21                    ; b5c4: a5 32
                ora #%00001000               ; b5c6: 09 08
                sta arr21                    ; b5c8: 85 32
                lda #$24                     ; b5ca: a9 24
                sta arr38                    ; b5cc: 85 4f
                jsr sub220                   ; b5ce: 20 f1 b3
                jsr sub173                   ; b5d1: 20 c0 a7
                lda #0                       ; b5d4: a9 00
                sta ram200                   ; b5d6: 8d 05 05
                sta ram201                   ; b5d9: 8d 06 05
                sta ram74                    ; b5dc: 85 88
                sta ram199                   ; b5de: 8d 04 05
                jmp cod367                   ; b5e1: 4c 82 b8
sub232          lda ram200                   ; b5e4: ad 05 05
                sta arr34                    ; b5e7: 85 48
                lda ram201                   ; b5e9: ad 06 05
                sta arr35                    ; b5ec: 85 49
                rts                          ; b5ee: 60
sub233          sta ram128                   ; b5ef: 85 e0
                sta ram129                   ; b5f1: 85 e1
                jsr sub204                   ; b5f3: 20 a9 ad
                jmp sub211                   ; b5f6: 4c 63 b2
sub234          cmp #$1c                     ; b5f9: c9 1c
                beq +                        ; b5fb: f0 0d
                cmp #$1d                     ; b5fd: c9 1d
                beq cod353                   ; b5ff: f0 16
                cmp #$1e                     ; b601: c9 1e
                beq cod354                   ; b603: f0 22
                cmp #$1f                     ; b605: c9 1f
                beq cod356                   ; b607: f0 2e
                rts                          ; b609: 60
+               lda ram200                   ; b60a: ad 05 05
                cmp #$1b                     ; b60d: c9 1b
                beq cod355                   ; b60f: f0 21
                inc ram200                   ; b611: ee 05 05
cod352          lda #0                       ; b614: a9 00
                rts                          ; b616: 60
cod353          lda ram200                   ; b617: ad 05 05
                beq +                        ; b61a: f0 06
                dec ram200                   ; b61c: ce 05 05
                jmp cod352                   ; b61f: 4c 14 b6
+               lda #$1b                     ; b622: a9 1b
                sta ram200                   ; b624: 8d 05 05
cod354          lda ram201                   ; b627: ad 06 05
                beq cod352                   ; b62a: f0 e8
                dec ram201                   ; b62c: ce 06 05
                jmp cod352                   ; b62f: 4c 14 b6
cod355          lda #0                       ; b632: a9 00
                sta ram200                   ; b634: 8d 05 05
cod356          lda ram201                   ; b637: ad 06 05
                cmp #$14                     ; b63a: c9 14
                beq cod352                   ; b63c: f0 d6
                inc ram201                   ; b63e: ee 06 05
                bne cod352                   ; b641: d0 d1
cod357          jsr sub174                   ; b643: 20 cc a7
                jsr sub235                   ; b646: 20 b5 b6
                jsr sub200                   ; b649: 20 8b ad
                jsr sub240                   ; b64c: 20 01 b8
                jsr sub200                   ; b64f: 20 8b ad
cod358          lda #$3e                     ; b652: a9 3e
                jsr sub233                   ; b654: 20 ef b5
                cmp #$1e                     ; b657: c9 1e
                beq cod359                   ; b659: f0 24
                cmp #$1f                     ; b65b: c9 1f
                beq cod360                   ; b65d: f0 29
                cmp #$20                     ; b65f: c9 20
                beq cod361                   ; b661: f0 2f
                cmp #3                       ; b663: c9 03
                beq +                        ; b665: f0 02
                bne cod358                   ; b667: d0 e9
+               jsr $b6b8                    ; b669: 20 b8 b6
                jsr sub201                   ; b66c: 20 8f ad
                lda #$15                     ; b66f: a9 15
                sta arr35                    ; b671: 85 49
                lda #$1a                     ; b673: a9 1a
                jsr sub195                   ; b675: 20 0d ac
                lda #$81                     ; b678: a9 81
                sta ram89                    ; b67a: 85 9e
                jmp cod2                     ; b67c: 4c ad 80
cod359          lda arr35                    ; b67f: a5 49
                beq cod358                   ; b681: f0 cf
                dec arr35                    ; b683: c6 49
                jmp cod358                   ; b685: 4c 52 b6
cod360          lda arr35                    ; b688: a5 49
                cmp #5                       ; b68a: c9 05
                beq cod358                   ; b68c: f0 c4
                inc arr35                    ; b68e: e6 49
                bne cod358                   ; b690: d0 c0
cod361          lda arr35                    ; b692: a5 49
                asl a                        ; b694: 0a
                tax                          ; b695: aa
                lda dat34,x                  ; b696: bd a3 b6
                sta ram14                    ; b699: 85 19
                lda dat35,x                  ; b69b: bd a4 b6
                sta ram15                    ; b69e: 85 1a
                jmp (ram14)                  ; b6a0: 6c 19 00

dat34           hex 7f                       ; b6a3

dat35           clv                          ; b6a4: b8

                hex 22 bb 1f bb ab           ; b6a5

                lda arr103,x                 ; b6aa: b5 fb

                hex bb                       ; b6ac

                and misc14                   ; b6ad: 2d b7 20
dat36           inc arr75                    ; b6b0: e6 ab
                jmp sub192                   ; b6b2: 4c fa ab
sub235          lda #$ff                     ; b6b5: a9 ff
                ldx_abs ram97                ; b6b7: ae a9 00
                sta arr160                   ; b6ba: 8d 00 05
                jsr sub191                   ; b6bd: 20 f1 ab
                lda #9                       ; b6c0: a9 09
                sta arr57                    ; b6c2: 85 74
                lda #0                       ; b6c4: a9 00
                sta arr26                    ; b6c6: 85 3d
                jsr sub200                   ; b6c8: 20 8b ad
cod362          jsr sub187                   ; b6cb: 20 a6 ab
                jsr sub188                   ; b6ce: 20 d8 ab
                lda arr160                   ; b6d1: ad 00 05
                beq +                        ; b6d4: f0 03
                lda ppu_data                 ; b6d6: ad 07 20
+               ldy #$0a                     ; b6d9: a0 0a
                ldx arr26                    ; b6db: a6 3d
cod363          lda arr160                   ; b6dd: ad 00 05
                beq +                        ; b6e0: f0 09
                lda ppu_data                 ; b6e2: ad 07 20
                sta arr163,x                 ; b6e5: 9d 20 05
                jmp cod364                   ; b6e8: 4c f1 b6
+               lda arr163,x                 ; b6eb: bd 20 05
                sta ppu_data                 ; b6ee: 8d 07 20
cod364          inx                          ; b6f1: e8
                dey                          ; b6f2: 88
                bne cod363                   ; b6f3: d0 e8
                stx arr26                    ; b6f5: 86 3d
                dec arr57                    ; b6f7: c6 74
                beq $b6af                    ; b6f9: f0 b4
                inc arr35                    ; b6fb: e6 49
                bne cod362                   ; b6fd: d0 cc
sub236          jsr sub170                   ; b6ff: 20 df a6
                lda #$b0                     ; b702: a9 b0
                sta arr108                   ; b704: 8d 01 02
                lda #0                       ; b707: a9 00
                sta arr109                   ; b709: 8d 02 02
                lda ram200                   ; b70c: ad 05 05
                clc                          ; b70f: 18
                adc #2                       ; b710: 69 02
                asl a                        ; b712: 0a
                asl a                        ; b713: 0a
                asl a                        ; b714: 0a
                sta arr110                   ; b715: 8d 03 02
                lda ram201                   ; b718: ad 06 05
                clc                          ; b71b: 18
                adc #3                       ; b71c: 69 03
                asl a                        ; b71e: 0a
                asl a                        ; b71f: 0a
                asl a                        ; b720: 0a
                sta arr107                   ; b721: 8d 00 02
                dec arr107                   ; b724: ce 00 02
                jmp sub238                   ; b727: 4c 83 b7
cod365          jmp cod357                   ; b72a: 4c 43 b6
                jsr sub181                   ; b72d: 20 f3 aa
                jsr $b6b8                    ; b730: 20 b8 b6
                lda #5                       ; b733: a9 05
                jsr sub241                   ; b735: 20 1b b8
                jsr sub174                   ; b738: 20 cc a7
                jsr sub232                   ; b73b: 20 e4 b5
-               jsr sub198                   ; b73e: 20 a1 ac
                lda arr34                    ; b741: a5 48
                sta ram200                   ; b743: 8d 05 05
                lda arr35                    ; b746: a5 49
                sta ram201                   ; b748: 8d 06 05
                jsr sub238                   ; b74b: 20 83 b7
                jsr sub199                   ; b74e: 20 aa ac
                jsr sub211                   ; b751: 20 63 b2
                cmp #$0d                     ; b754: c9 0d
                beq +                        ; b756: f0 0f
                cmp #$1b                     ; b758: c9 1b
                beq cod365                   ; b75a: f0 ce
                bcc -                        ; b75c: 90 e0
                jsr sub195                   ; b75e: 20 0d ac
                jsr sub237                   ; b761: 20 70 b7
                jmp -                        ; b764: 4c 3e b7
+               jsr sub194                   ; b767: 20 07 ac
                jsr sub237                   ; b76a: 20 70 b7
                jmp -                        ; b76d: 4c 3e b7
sub237          lda arr35                    ; b770: a5 49
                cmp #$15                     ; b772: c9 15
                bcs +                        ; b774: b0 01
                rts                          ; b776: 60
+               lda #$14                     ; b777: a9 14
                sta arr35                    ; b779: 85 49
                rts                          ; b77b: 60
                cli                          ; b77c: 58

                hex 3a                       ; b77d

                ora misc157                  ; b77e: 0d 0a 59

                hex 3a                       ; b781

                brk                          ; b782: 00
sub238          jsr sub201                   ; b783: 20 8f ad
                lda #$16                     ; b786: a9 16
                sta arr35                    ; b788: 85 49
                lda #$7c                     ; b78a: a9 7c
                sta arr41                    ; b78c: 85 52
                lda #$b7                     ; b78e: a9 b7
                sta arr42                    ; b790: 85 53
                jsr sub32                    ; b792: 20 f8 87
                lda ram200                   ; b795: ad 05 05
                sta ram24                    ; b798: 85 28
                lda #2                       ; b79a: a9 02
                sta arr34                    ; b79c: 85 48
                lda #$16                     ; b79e: a9 16
                sta arr35                    ; b7a0: 85 49
                jsr sub239                   ; b7a2: 20 b0 b7
                lda ram201                   ; b7a5: ad 06 05
                sta ram24                    ; b7a8: 85 28
                lda #2                       ; b7aa: a9 02
                sta arr34                    ; b7ac: 85 48
                inc arr35                    ; b7ae: e6 49
sub239          jsr sub144                   ; b7b0: 20 cd a1
                jsr sub69                    ; b7b3: 20 3c 8d
                lda #$3d                     ; b7b6: a9 3d
                clc                          ; b7b8: 18
                adc #3                       ; b7b9: 69 03
                sta arr41                    ; b7bb: 85 52
                lda #0                       ; b7bd: a9 00
                sta arr42                    ; b7bf: 85 53
                jmp sub32                    ; b7c1: 4c f8 87
                eor misc91                   ; b7c4: 4d 4f 44
                eor arr14                    ; b7c7: 45 20
                jsr misc141                  ; b7c9: 20 00 53
                eor arr36                    ; b7cc: 45 4c
                eor arr30                    ; b7ce: 45 43

                hex 54                       ; b7d0

                brk                          ; b7d1: 00
                eor misc153                  ; b7d2: 4d 4f 56
                eor arr14                    ; b7d5: 45 20
                jsr misc83                   ; b7d7: 20 00 43

                hex 4f                       ; b7da

                bvc cod366                   ; b7db: 50 59
                jsr arr14                    ; b7dd: 20 20 00

                hex 43                       ; b7e0

                pha                          ; b7e1: 48
                eor (arr41,x)                ; b7e2: 41 52
                jsr arr14                    ; b7e4: 20 20 00

                hex 43                       ; b7e7

                jmp misc74                   ; b7e8: 4c 45 41

                hex 52                       ; b7eb

                jsr misc97                   ; b7ec: 20 00 46
                eor #%01001100               ; b7ef: 49 4c
                eor arr14                    ; b7f1: 45 20
                jsr $cb00                    ; b7f3: 20 00 cb

dat37           hex b7                       ; b7f6

                cmp dat114,y                 ; b7f7: d9 b7 d2

                hex b7 e7 b7                 ; b7fa

                inc $e0b7                    ; b7fd: ee b7 e0

                hex b7                       ; b800

sub240          lda #0                       ; b801: a9 00
                sta ram61                    ; b803: 85 75
-               lda #$20                     ; b805: a9 20
                jsr sub31                    ; b807: 20 f0 87
                lda ram61                    ; b80a: a5 75
                jsr sub243                   ; b80c: 20 38 b8
                jsr sub194                   ; b80f: 20 07 ac
                inc ram61                    ; b812: e6 75
                lda ram61                    ; b814: a5 75
                cmp #6                       ; b816: c9 06
                bne -                        ; b818: d0 eb
                rts                          ; b81a: 60
sub241          sta ram64                    ; b81b: 85 7c
sub242          lda #5                       ; b81d: a9 05
                sta arr34                    ; b81f: 85 48
                lda #$16                     ; b821: a9 16
                sta arr35                    ; b823: 85 49
                lda #$c4                     ; b825: a9 c4
                sta arr41                    ; b827: 85 52
                lda #$b7                     ; b829: a9 b7
                sta arr42                    ; b82b: 85 53
                jsr sub32                    ; b82d: 20 f8 87
                lda #5                       ; b830: a9 05
                sta arr34                    ; b832: 85 48
                inc arr35                    ; b834: e6 49
cod366          lda ram64                    ; b836: a5 7c
sub243          asl a                        ; b838: 0a
                tax                          ; b839: aa
                lda $b7f5,x                  ; b83a: bd f5 b7
                sta arr41                    ; b83d: 85 52
                lda dat37,x                  ; b83f: bd f6 b7
                sta arr42                    ; b842: 85 53
                jmp sub32                    ; b844: 4c f8 87
dat38           brk                          ; b847: 00
                php                          ; b848: 08
                bpl $b863                    ; b849: 10 18
                clv                          ; b84b: b8
-               cpy #$c8                     ; b84c: c0 c8
                bne $b828                    ; b84e: d0 d8
                cpx #$e8                     ; b850: e0 e8
                beq -                        ; b852: f0 f8
dat39           jsr sub244                   ; b854: 20 5a b8
                jmp cod368                   ; b857: 4c 9d b8
sub244          jsr sub245                   ; b85a: 20 ed b8
                jsr sub182                   ; b85d: 20 fe aa
                lda #$27                     ; b860: a9 27
                ldx #$2c                     ; b862: a2 2c
                jsr sub9                     ; b864: 20 f8 81
                lda ram74                    ; b867: a5 88
                ora #%00110000               ; b869: 09 30
                jmp sub189                   ; b86b: 4c e3 ab
                jsr sub198                   ; b86e: 20 a1 ac
                jsr sub232                   ; b871: 20 e4 b5
                lda #$20                     ; b874: a9 20
                jsr sub195                   ; b876: 20 0d ac
                jsr sub199                   ; b879: 20 aa ac
                jmp cod368                   ; b87c: 4c 9d b8
                jsr $b6b8                    ; b87f: 20 b8 b6
cod367          jsr sub173                   ; b882: 20 c0 a7
                lda #0                       ; b885: a9 00
                sta ram67                    ; b887: 85 7f
                sta ram65                    ; b889: 85 7d
                jsr sub241                   ; b88b: 20 1b b8
                lda #3                       ; b88e: a9 03
                sta ram74                    ; b890: 85 88
                jsr sub244                   ; b892: 20 5a b8
                lda #$0c                     ; b895: a9 0c
                sta arr34                    ; b897: 85 48
                lda #$17                     ; b899: a9 17
                sta arr35                    ; b89b: 85 49
cod368          jsr sub246                   ; b89d: 20 a2 b9
cod369          jsr sub198                   ; b8a0: 20 a1 ac
                jsr sub236                   ; b8a3: 20 ff b6
                jsr sub199                   ; b8a6: 20 aa ac
                lda #$5e                     ; b8a9: a9 5e
                jsr sub233                   ; b8ab: 20 ef b5
                jsr sub234                   ; b8ae: 20 f9 b5
                ldx #0                       ; b8b1: a2 00
-               cmp dat40,x                  ; b8b3: dd cf b8
                beq +                        ; b8b6: f0 07
                inx                          ; b8b8: e8
                cpx #8                       ; b8b9: e0 08
                bne -                        ; b8bb: d0 f6
                beq cod369                   ; b8bd: f0 e1
+               txa                          ; b8bf: 8a
                asl a                        ; b8c0: 0a
                tax                          ; b8c1: aa
                lda $b8d7,x                  ; b8c2: bd d7 b8
                sta ram14                    ; b8c5: 85 19
                lda dat41,x                  ; b8c7: bd d8 b8
                sta ram15                    ; b8ca: 85 1a
                jmp (ram14)                  ; b8cc: 6c 19 00

dat40           hex 1b                       ; b8cf

                ora ram220                   ; b8d0: 0d 0c 0b
                php                          ; b8d3: 08

                hex 12                       ; b8d4

                jsr ram240                   ; b8d5: 20 44 17
dat41           lda dat39,y                  ; b8d8: b9 54 b8
                rol misc56                   ; b8db: 2e b9 37
                lda dat42,y                  ; b8de: b9 41 b9

                hex 4f                       ; b8e1

                lda dat43,y                  ; b8e2: b9 5d b9
                ror cod288                   ; b8e5: 6e b8 a9
                brk                          ; b8e8: 00
                sta ram74                    ; b8e9: 85 88
                beq cod370                   ; b8eb: f0 08
sub245          inc ram74                    ; b8ed: e6 88
                lda ram74                    ; b8ef: a5 88
                cmp #4                       ; b8f1: c9 04
                beq $b8e7                    ; b8f3: f0 f2
cod370          asl a                        ; b8f5: 0a
                asl a                        ; b8f6: 0a
                ora ram74                    ; b8f7: 05 88
                pha                          ; b8f9: 48
                jsr sub182                   ; b8fa: 20 fe aa
                lda #$27                     ; b8fd: a9 27
                ldx #$f3                     ; b8ff: a2 f3
                jsr sub9                     ; b901: 20 f8 81
                pla                          ; b904: 68
                tax                          ; b905: aa
                and #%11111100               ; b906: 29 fc
                sta ppu_data                 ; b908: 8d 07 20
                txa                          ; b90b: 8a
                ldx #4                       ; b90c: a2 04
-               sta ppu_data                 ; b90e: 8d 07 20
                dex                          ; b911: ca
                bne -                        ; b912: d0 fa
                jmp sub190                   ; b914: 4c e6 ab
                lda #$0c                     ; b917: a9 0c
                sta arr34                    ; b919: 85 48
                lda #$16                     ; b91b: a9 16
                sta arr35                    ; b91d: 85 49
                lda #5                       ; b91f: a9 05
                jsr sub195                   ; b921: 20 0d ac
                inc arr35                    ; b924: e6 49
                lda #5                       ; b926: a9 05
                jsr sub195                   ; b928: 20 0d ac
                jmp cod357                   ; b92b: 4c 43 b6
                lda ram65                    ; b92e: a5 7d
                beq cod371                   ; b930: f0 02
                dec ram65                    ; b932: c6 7d
cod371          jmp cod368                   ; b934: 4c 9d b8
                lda ram65                    ; b937: a5 7d
                cmp #$0c                     ; b939: c9 0c
                beq cod371                   ; b93b: f0 f7
                inc ram65                    ; b93d: e6 7d
                bne cod371                   ; b93f: d0 f3
dat42           lda arr34                    ; b941: a5 48
                cmp #$1a                     ; b943: c9 1a
                beq cod371                   ; b945: f0 ed
                inc arr34                    ; b947: e6 48
                inc arr34                    ; b949: e6 48
                inc ram67                    ; b94b: e6 7f
                bne cod371                   ; b94d: d0 e5
                lda arr34                    ; b94f: a5 48
                cmp #$0c                     ; b951: c9 0c
                beq cod371                   ; b953: f0 df
                dec arr34                    ; b955: c6 48
                dec arr34                    ; b957: c6 48
                dec ram67                    ; b959: c6 7f
                bpl cod371                   ; b95b: 10 d7
dat43           jsr sub198                   ; b95d: 20 a1 ac
                jsr sub232                   ; b960: 20 e4 b5
                jsr sub187                   ; b963: 20 a6 ab
                ldx ram65                    ; b966: a6 7d
                lda dat38,x                  ; b968: bd 47 b8
                clc                          ; b96b: 18
                adc ram67                    ; b96c: 65 7f
                sta arr56                    ; b96e: 85 73
                lda #9                       ; b970: a9 09
                jsr sub34                    ; b972: 20 08 88
                lda ram74                    ; b975: a5 88
                sta ram87                    ; b977: 85 9c
                jsr sub249                   ; b979: 20 67 ba
                inc ram200                   ; b97c: ee 05 05
                lda ram200                   ; b97f: ad 05 05
                cmp #$1c                     ; b982: c9 1c
                beq cod373                   ; b984: f0 06
cod372          jsr sub199                   ; b986: 20 aa ac
                jmp cod368                   ; b989: 4c 9d b8
cod373          lda #0                       ; b98c: a9 00
                sta ram200                   ; b98e: 8d 05 05
                inc ram201                   ; b991: ee 06 05
                lda ram201                   ; b994: ad 06 05
                cmp #$15                     ; b997: c9 15
                bne cod372                   ; b999: d0 eb
                lda #$14                     ; b99b: a9 14
                sta ram201                   ; b99d: 8d 06 05
                bpl cod372                   ; b9a0: 10 e4
sub246          jsr sub198                   ; b9a2: 20 a1 ac
                lda #$0c                     ; b9a5: a9 0c
                sta arr34                    ; b9a7: 85 48
                lda #$16                     ; b9a9: a9 16
                sta arr35                    ; b9ab: 85 49
                ldx ram65                    ; b9ad: a6 7d
                lda dat38,x                  ; b9af: bd 47 b8
                sta ram66                    ; b9b2: 85 7e
                ldy #8                       ; b9b4: a0 08
                ldx #0                       ; b9b6: a2 00
-               lda ram66                    ; b9b8: a5 7e
                sta arr162,x                 ; b9ba: 9d 10 05
                inx                          ; b9bd: e8
                lda #$20                     ; b9be: a9 20
                sta arr162,x                 ; b9c0: 9d 10 05
                inx                          ; b9c3: e8
                inc ram66                    ; b9c4: e6 7e
                dey                          ; b9c6: 88
                bne -                        ; b9c7: d0 ef
                jsr sub187                   ; b9c9: 20 a6 ab
                ldx #0                       ; b9cc: a2 00
                ldy #8                       ; b9ce: a0 08
                jsr sub182                   ; b9d0: 20 fe aa
                jsr sub188                   ; b9d3: 20 d8 ab
-               lda arr162,x                 ; b9d6: bd 10 05
                sta ppu_data                 ; b9d9: 8d 07 20
                inx                          ; b9dc: e8
                lda #$20                     ; b9dd: a9 20
                sta ppu_data                 ; b9df: 8d 07 20
                inx                          ; b9e2: e8
                dey                          ; b9e3: 88
                bne -                        ; b9e4: d0 f0
                jsr sub190                   ; b9e6: 20 e6 ab
                jmp sub199                   ; b9e9: 4c aa ac
sub247          inc arr34                    ; b9ec: e6 48
                inc arr34                    ; b9ee: e6 48
                lda arr35                    ; b9f0: a5 49
                clc                          ; b9f2: 18
                adc #3                       ; b9f3: 69 03
                sta arr35                    ; b9f5: 85 49
                and #%11111100               ; b9f7: 29 fc
                asl a                        ; b9f9: 0a
                sta ram40                    ; b9fa: 85 4a
                lda arr34                    ; b9fc: a5 48
                lsr a                        ; b9fe: 4a
                lsr a                        ; b9ff: 4a
                clc                          ; ba00: 18
                adc ram40                    ; ba01: 65 4a
                adc #$c0                     ; ba03: 69 c0
                sta ram40                    ; ba05: 85 4a
                lda arr38                    ; ba07: a5 4f
                adc #3                       ; ba09: 69 03
                sta ram41                    ; ba0b: 85 4b
                lda #2                       ; ba0d: a9 02
                and arr35                    ; ba0f: 25 49
                sta ram14                    ; ba11: 85 19
                lda arr34                    ; ba13: a5 48
                and #%00000011               ; ba15: 29 03
                lsr a                        ; ba17: 4a
                clc                          ; ba18: 18
                adc ram14                    ; ba19: 65 19
                sta ram14                    ; ba1b: 85 19
                lda #$fc                     ; ba1d: a9 fc
                sta ram15                    ; ba1f: 85 1a
                asl ram14                    ; ba21: 06 19
                ldx ram14                    ; ba23: a6 19
                beq +                        ; ba25: f0 08
-               asl ram87                    ; ba27: 06 9c
                sec                          ; ba29: 38
                rol ram15                    ; ba2a: 26 1a
                dex                          ; ba2c: ca
                bne -                        ; ba2d: d0 f8
+               lda #5                       ; ba2f: a9 05
                jsr sub34                    ; ba31: 20 08 88
                lda arr56                    ; ba34: a5 73
                rts                          ; ba36: 60
sub248          jsr sub247                   ; ba37: 20 ec b9
                sta ram87                    ; ba3a: 85 9c
                lda ram15                    ; ba3c: a5 1a
                eor #%11111111               ; ba3e: 49 ff
                and ram87                    ; ba40: 25 9c
                sta ram87                    ; ba42: 85 9c
                ldy ram14                    ; ba44: a4 19
                beq +                        ; ba46: f0 05
-               lsr ram87                    ; ba48: 46 9c
                dey                          ; ba4a: 88
                bne -                        ; ba4b: d0 fb
+               rts                          ; ba4d: 60
                jsr sub120                   ; ba4e: 20 6d 9c
                pha                          ; ba51: 48
                jsr sub119                   ; ba52: 20 6a 9c
                lda arr144                   ; ba55: ad 00 04
                sta arr35                    ; ba58: 85 49
                pla                          ; ba5a: 68
                sta arr34                    ; ba5b: 85 48
                jsr sub119                   ; ba5d: 20 6a 9c
                lda arr144                   ; ba60: ad 00 04
                and #%00000011               ; ba63: 29 03
                sta ram87                    ; ba65: 85 9c
sub249          jsr sub247                   ; ba67: 20 ec b9
                and ram15                    ; ba6a: 25 1a
                ora ram87                    ; ba6c: 05 9c
                sta arr56                    ; ba6e: 85 73
                lda #9                       ; ba70: a9 09
                jmp sub34                    ; ba72: 4c 08 88
sub250          lda #3                       ; ba75: a9 03
                sta arr160                   ; ba77: 8d 00 05
                lda #0                       ; ba7a: a9 00
                sta ram204                   ; ba7c: 8d 14 05
                sta ram206                   ; ba7f: 8d 16 05
                lda #7                       ; ba82: a9 07
                sta ram205                   ; ba84: 8d 15 05
                sta ram207                   ; ba87: 8d 17 05
                ldx #0                       ; ba8a: a2 00
                stx ram202                   ; ba8c: 8e 12 05
                inx                          ; ba8f: e8
                stx ram203                   ; ba90: 8e 13 05
                lda #0                       ; ba93: a9 00
                sta ram50                    ; ba95: 85 5f
                lda #$24                     ; ba97: a9 24
                sta arr47                    ; ba99: 85 60
                jsr sub104                   ; ba9b: 20 c3 97
cod374          jsr sub191                   ; ba9e: 20 f1 ab
                lda arr47                    ; baa1: a5 60
                ldx ram50                    ; baa3: a6 5f
                jsr sub9                     ; baa5: 20 f8 81
                lda ppu_data                 ; baa8: ad 07 20
                ldx #0                       ; baab: a2 00
-               lda ppu_data                 ; baad: ad 07 20
                sta arr191,x                 ; bab0: 9d 00 07
                inx                          ; bab3: e8
                bne -                        ; bab4: d0 f7
                jsr sub190                   ; bab6: 20 e6 ab
                jsr sub192                   ; bab9: 20 fa ab
                jsr sub227                   ; babc: 20 fc b4
                jsr sub228                   ; babf: 20 0d b5
                inc arr47                    ; bac2: e6 60
                lda arr47                    ; bac4: a5 60
                cmp #$28                     ; bac6: c9 28
                bne cod374                   ; bac8: d0 d4
cod375          rts                          ; baca: 60
cod376          jsr sub106                   ; bacb: 20 dd 97
sub251          lda #0                       ; bace: a9 00
                sta ram50                    ; bad0: 85 5f
                lda #$24                     ; bad2: a9 24
                sta arr47                    ; bad4: 85 60
cod377          jsr sub223                   ; bad6: 20 30 b4
                bcs cod375                   ; bad9: b0 ef
                lda arr160                   ; badb: ad 00 05
                cmp #3                       ; bade: c9 03
                bne cod376                   ; bae0: d0 e9
                jsr sub111                   ; bae2: 20 c8 98
                bcs cod376                   ; bae5: b0 e4
                jsr sub105                   ; bae7: 20 d0 97
                jsr sub222                   ; baea: 20 01 b4
                bcs cod375                   ; baed: b0 db
                jsr sub191                   ; baef: 20 f1 ab
                lda arr47                    ; baf2: a5 60
                ldx ram50                    ; baf4: a6 5f
                jsr sub9                     ; baf6: 20 f8 81
                ldx #0                       ; baf9: a2 00
-               lda arr191,x                 ; bafb: bd 00 07
                sta ppu_data                 ; bafe: 8d 07 20
                inx                          ; bb01: e8
                bne -                        ; bb02: d0 f7
                jsr sub190                   ; bb04: 20 e6 ab
                jsr sub192                   ; bb07: 20 fa ab
                inc arr47                    ; bb0a: e6 60
                lda arr47                    ; bb0c: a5 60
                cmp #$28                     ; bb0e: c9 28
                bne cod377                   ; bb10: d0 c4
                rts                          ; bb12: 60
cod378          lda #0                       ; bb13: a9 00
                sta ram99                    ; bb15: 85 ae
                lda #$f8                     ; bb17: a9 f8
                sta ram152                   ; bb19: 8d 10 02
                jmp cod357                   ; bb1c: 4c 43 b6
                lda #2                       ; bb1f: a9 02
                ldx ram147                   ; bb21: ae a9 01
                sta ram64                    ; bb24: 85 7c
                tax                          ; bb26: aa
                dex                          ; bb27: ca
                stx ram100                   ; bb28: 86 af
                jsr $b6b8                    ; bb2a: 20 b8 b6
                jsr sub173                   ; bb2d: 20 c0 a7
                lda #0                       ; bb30: a9 00
                sta ram99                    ; bb32: 85 ae
                jsr sub242                   ; bb34: 20 1d b8
cod379          jsr sub236                   ; bb37: 20 ff b6
                jsr sub252                   ; bb3a: 20 ad bb
                lda #$20                     ; bb3d: a9 20
                jsr sub233                   ; bb3f: 20 ef b5
                jsr sub234                   ; bb42: 20 f9 b5
                cmp #$1b                     ; bb45: c9 1b
                beq cod378                   ; bb47: f0 ca
                cmp #$12                     ; bb49: c9 12
                beq cod380                   ; bb4b: f0 30
                cmp #8                       ; bb4d: c9 08
                beq +                        ; bb4f: f0 02
                bne cod379                   ; bb51: d0 e4
+               lda ram99                    ; bb53: a5 ae
                beq cod379                   ; bb55: f0 e0
                jsr sub198                   ; bb57: 20 a1 ac
                jsr sub232                   ; bb5a: 20 e4 b5
                jsr sub187                   ; bb5d: 20 a6 ab
                lda ram80                    ; bb60: a5 91
                sta arr56                    ; bb62: 85 73
                lda #9                       ; bb64: a9 09
                jsr sub34                    ; bb66: 20 08 88
                lda ram74                    ; bb69: a5 88
                sta ram87                    ; bb6b: 85 9c
                jsr sub249                   ; bb6d: 20 67 ba
                jsr sub199                   ; bb70: 20 aa ac
                lda ram100                   ; bb73: a5 af
                beq +                        ; bb75: f0 04
                lda #0                       ; bb77: a9 00
                sta ram99                    ; bb79: 85 ae
+               beq cod379                   ; bb7b: f0 ba
cod380          jsr sub198                   ; bb7d: 20 a1 ac
                jsr sub232                   ; bb80: 20 e4 b5
                jsr sub187                   ; bb83: 20 a6 ab
                lda #5                       ; bb86: a9 05
                jsr sub34                    ; bb88: 20 08 88
                lda arr56                    ; bb8b: a5 73
                sta ram80                    ; bb8d: 85 91
                lda ram100                   ; bb8f: a5 af
                beq +                        ; bb91: f0 09
                lda #$20                     ; bb93: a9 20
                sta arr56                    ; bb95: 85 73
                lda #9                       ; bb97: a9 09
                jsr sub34                    ; bb99: 20 08 88
+               lda #$ff                     ; bb9c: a9 ff
                sta ram99                    ; bb9e: 85 ae
                jsr sub248                   ; bba0: 20 37 ba
                lda ram87                    ; bba3: a5 9c
                sta ram74                    ; bba5: 85 88
                jsr sub199                   ; bba7: 20 aa ac
                jmp cod379                   ; bbaa: 4c 37 bb
sub252          lda ram99                    ; bbad: a5 ae
                beq cod381                   ; bbaf: f0 28
                lda ram80                    ; bbb1: a5 91
                sta ram153                   ; bbb3: 8d 11 02
                lda ram74                    ; bbb6: a5 88
                and #%00001111               ; bbb8: 29 0f
dat44           sta ram154                   ; bbba: 8d 12 02
                lda ram200                   ; bbbd: ad 05 05
                clc                          ; bbc0: 18
                adc #2                       ; bbc1: 69 02
                asl a                        ; bbc3: 0a
                asl a                        ; bbc4: 0a
                asl a                        ; bbc5: 0a
                sta ram155                   ; bbc6: 8d 13 02
                lda ram201                   ; bbc9: ad 06 05
                clc                          ; bbcc: 18
                adc #3                       ; bbcd: 69 03
                asl a                        ; bbcf: 0a
                asl a                        ; bbd0: 0a
                asl a                        ; bbd1: 0a
                sta ram152                   ; bbd2: 8d 10 02
                dec ram152                   ; bbd5: ce 10 02
                rts                          ; bbd8: 60
cod381          lda #$f8                     ; bbd9: a9 f8
                sta ram152                   ; bbdb: 8d 10 02
                rts                          ; bbde: 60

                hex 53                       ; bbdf

                eor (arr45,x)                ; bbe0: 41 56
                eor ram24                    ; bbe2: 45 28

                hex 53                       ; bbe4

                and #%00101100               ; bbe5: 29 2c
                jmp misc76                   ; bbe7: 4c 4f 41

                hex 44                       ; bbea

                plp                          ; bbeb: 28
                jmp misc67                   ; bbec: 4c 29 3f
                brk                          ; bbef: 00
                lsr arr35                    ; bbf0: 46 49
                jmp misc5                    ; bbf2: 4c 45 20
                lsr misc114                  ; bbf5: 4e 41 4d
                eor ram20                    ; bbf8: 45 22
                brk                          ; bbfa: 00
                jsr $b6b8                    ; bbfb: 20 b8 b6
                jsr sub201                   ; bbfe: 20 8f ad
                lda #$16                     ; bc01: a9 16
                sta arr35                    ; bc03: 85 49
                lda #$1a                     ; bc05: a9 1a
                jsr sub195                   ; bc07: 20 0d ac
                lda #$20                     ; bc0a: a9 20
                sta arr38                    ; bc0c: 85 4f
                jsr sub220                   ; bc0e: 20 f1 b3
                jsr sub181                   ; bc11: 20 f3 aa
                jsr sub186                   ; bc14: 20 75 ab
                lda #$df                     ; bc17: a9 df
                sta arr41                    ; bc19: 85 52
                lda #$bb                     ; bc1b: a9 bb
                sta arr42                    ; bc1d: 85 53
                jsr sub32                    ; bc1f: 20 f8 87
                jsr sub211                   ; bc22: 20 63 b2
                cmp #$53                     ; bc25: c9 53
                beq +                        ; bc27: f0 06
                cmp #$4c                     ; bc29: c9 4c
                beq cod383                   ; bc2b: f0 12
                bne cod382                   ; bc2d: d0 09
+               jsr sub195                   ; bc2f: 20 0d ac
                jsr sub253                   ; bc32: 20 4b bc
                jsr sub250                   ; bc35: 20 75 ba
cod382          lda #$81                     ; bc38: a9 81
                sta ram89                    ; bc3a: 85 9e
                jmp cod351                   ; bc3c: 4c af b5
cod383          jsr sub195                   ; bc3f: 20 0d ac
                jsr sub253                   ; bc42: 20 4b bc
                jsr sub251                   ; bc45: 20 ce ba
                jmp cod382                   ; bc48: 4c 38 bc
sub253          jsr sub194                   ; bc4b: 20 07 ac
                lda #$f0                     ; bc4e: a9 f0
                sta arr41                    ; bc50: 85 52
                lda #$bb                     ; bc52: a9 bb
                sta arr42                    ; bc54: 85 53
                jsr sub32                    ; bc56: 20 f8 87
                jsr sub213                   ; bc59: 20 43 b3
                lda arr160                   ; bc5c: ad 00 05
                cmp #3                       ; bc5f: c9 03
                beq +                        ; bc61: f0 0d
                jsr sub36                    ; bc63: 20 32 8a
                lda #9                       ; bc66: a9 09
                sta ram4                     ; bc68: 85 09
                jsr sub108                   ; bc6a: 20 69 98
                jmp sub110                   ; bc6d: 4c b4 98
+               pla                          ; bc70: 68
                pla                          ; bc71: 68
                jmp cod382                   ; bc72: 4c 38 bc
dat45           lda arr79                    ; bc75: a5 bc
                lda arr79                    ; bc77: a5 bc
                lda (arr79),y                ; bc79: b1 bc

                hex b7                       ; bc7b

                ldy dat48,x                  ; bc7c: bc bd bc

                hex ab                       ; bc7f

                ldy dat46,x                  ; bc80: bc b7 bc
                lda (arr79),y                ; bc83: b1 bc

                hex c3                       ; bc85

                ldy dat49,x                  ; bc86: bc c3 bc
                lda (arr79),y                ; bc89: b1 bc
                lda (arr79),y                ; bc8b: b1 bc
                cmp #$bc                     ; bc8d: c9 bc

                hex ab                       ; bc8f

                ldy $bcb1,x                  ; bc90: bc b1 bc

                hex ab                       ; bc93

                ldy arr210,x                 ; bc94: bc 00 1c
                brk                          ; bc97: 00
                brk                          ; bc98: 00
                brk                          ; bc99: 00
                brk                          ; bc9a: 00
                sec                          ; bc9b: 38
                cli                          ; bc9c: 58
                brk                          ; bc9d: 00

                hex 0c                       ; bc9e

                sei                          ; bc9f: 78
                jsr misc104                  ; bca0: 20 00 48
                dey                          ; bca3: 88
                cli                          ; bca4: 58

                hex f3                       ; bca5

                ldy $bd29,x                  ; bca6: bc 29 bd

                hex cf                       ; bca9

                ldy $bcfc,x                  ; bcaa: bc fc bc
                sta arr80,x                  ; bcad: 95 bd
                nop                          ; bcaf: ea
                ldy $bcfc,x                  ; bcb0: bc fc bc

                hex 3b                       ; bcb3

                lda dat50,x                  ; bcb4: bd d8 bc

dat46           hex fc                       ; bcb7

dat47           ldy dat53,x                  ; bcb8: bc 4d bd
                sbc (arr79,x)                ; bcbb: e1 bc
dat48           asl misc163                  ; bcbd: 0e bd 5f
                lda dat52,x                  ; bcc0: bd ea bc
dat49           ora arr80                    ; bcc3: 05 bd
                adc (arr80),y                ; bcc5: 71 bd
                sbc (arr79,x)                ; bcc7: e1 bc
                ora arr80                    ; bcc9: 05 bd

                hex 83                       ; bccb

                lda dat51,x                  ; bccc: bd e1 bc
                brk                          ; bccf: 00
                brk                          ; bcd0: 00
                rti                          ; bcd1: 40
                rti                          ; bcd2: 40
                rti                          ; bcd3: 40
                brk                          ; bcd4: 00
                brk                          ; bcd5: 00
                brk                          ; bcd6: 00
                brk                          ; bcd7: 00
dat50           brk                          ; bcd8: 00
                brk                          ; bcd9: 00
                brk                          ; bcda: 00
                brk                          ; bcdb: 00
                brk                          ; bcdc: 00
                brk                          ; bcdd: 00
                brk                          ; bcde: 00
                brk                          ; bcdf: 00
                brk                          ; bce0: 00
dat51           brk                          ; bce1: 00
                brk                          ; bce2: 00
                rti                          ; bce3: 40
                rti                          ; bce4: 40
                cpy #$80                     ; bce5: c0 80

                hex 80                       ; bce7

                brk                          ; bce8: 00
                brk                          ; bce9: 00
dat52           brk                          ; bcea: 00
                brk                          ; bceb: 00
                rti                          ; bcec: 40
                rti                          ; bced: 40
                rti                          ; bcee: 40
                brk                          ; bcef: 00
                brk                          ; bcf0: 00
                brk                          ; bcf1: 00
                brk                          ; bcf2: 00
                bpl $bd15                    ; bcf3: 10 20
                bpl cod387                   ; bcf5: 10 30
                bpl +                        ; bcf7: 10 20
                bpl $bd2b                    ; bcf9: 10 30
                bpl cod385                   ; bcfb: 10 20
                jsr misc3                    ; bcfd: 20 20 20
                jsr misc3                    ; bd00: 20 20 20
                jsr ram234                   ; bd03: 20 20 10
                bpl $bd18                    ; bd06: 10 10
                bpl cod384                   ; bd08: 10 10
                bpl $bd1c                    ; bd0a: 10 10
                bpl cod386                   ; bd0c: 10 10
                bpl $bd30                    ; bd0e: 10 20
                jsr misc3                    ; bd10: 20 20 20
                jsr misc3                    ; bd13: 20 20 20
                jsr arr1                     ; bd16: 20 00 00
+               brk                          ; bd19: 00
cod384          inc $fe02,x                  ; bd1a: fe 02 fe

cod385          hex 02                       ; bd1d

cod386          brk                          ; bd1e: 00

                hex 02 02                    ; bd1f

                brk                          ; bd21: 00

                hex 02                       ; bd22

                inc $fe02,x                  ; bd23: fe 02 fe
                brk                          ; bd26: 00
cod387          inc $c7fe,x                  ; bd27: fe fe c7
                lda dat59,x                  ; bd2a: bd c3 bd

                hex cf                       ; bd2d

                lda dat58,x                  ; bd2e: bd bf bd

                hex cf                       ; bd31

                lda dat59,x                  ; bd32: bd c3 bd

                hex cb                       ; bd35

                lda dat57,x                  ; bd36: bd bb bd

                hex cb                       ; bd39

                lda $bdd7,x                  ; bd3a: bd d7 bd

                hex d7                       ; bd3d

                lda $bdd7,x                  ; bd3e: bd d7 bd

                hex d7                       ; bd41

                lda $bdd7,x                  ; bd42: bd d7 bd

                hex d7                       ; bd45

                lda $bdd7,x                  ; bd46: bd d7 bd

                hex d7                       ; bd49

                lda $bdd7,x                  ; bd4a: bd d7 bd

dat53           hex e3                       ; bd4d

                lda dat60,x                  ; bd4e: bd db bd

                hex ef                       ; bd51

                lda dat63,x                  ; bd52: bd e7 bd

                hex f7                       ; bd55

                lda dat61,x                  ; bd56: bd df bd

                hex f3                       ; bd59

                lda dat62,x                  ; bd5a: bd e3 bd

                hex eb                       ; bd5d

                lda $be1b,x                  ; bd5e: bd 1b be

                hex 1f                       ; bd61

                ldx dat69,y                  ; bd62: be 27 be

                hex 27                       ; bd65

                ldx dat69,y                  ; bd66: be 27 be

                hex 1b                       ; bd69

                ldx dat68,y                  ; bd6a: be 23 be

                hex 23                       ; bd6d

                ldx dat68,y                  ; bd6e: be 23 be

                hex fb                       ; bd71

                lda dat64,x                  ; bd72: bd fb bd

                hex 0f                       ; bd75

                ldx dat67,y                  ; bd76: be 07 be

                hex 17                       ; bd79

                ldx dat65,y                  ; bd7a: be ff bd

                hex 13                       ; bd7d

                ldx dat66,y                  ; bd7e: be 03 be

                hex 0b                       ; bd81

                ldx dat55,y                  ; bd82: be af bd

                hex af                       ; bd85

                lda dat56,x                  ; bd86: bd b7 bd

                hex b3                       ; bd89

                lda dat56,x                  ; bd8a: bd b7 bd

                hex af                       ; bd8d

                lda dat56,x                  ; bd8e: bd b7 bd

                hex b3                       ; bd91

                lda dat56,x                  ; bd92: bd b7 bd

                hex a7                       ; bd95

                lda $bda7,x                  ; bd96: bd a7 bd

                hex ab                       ; bd99

                lda dat54,x                  ; bd9a: bd ab bd

                hex ab                       ; bd9d

                lda $bda7,x                  ; bd9e: bd a7 bd

                hex a7                       ; bda1

                lda $bda7,x                  ; bda2: bd a7 bd

                hex a7                       ; bda5

                lda misc249,x                ; bda6: bd 70 71

                hex 72 73                    ; bda9

dat54           adc (arr53),y                ; bdab: 71 70

                hex 73 72                    ; bdad
dat55           hex d4 ef ef ef              ; bdaf

                bne $bda4                    ; bdb3: d0 ef

                hex ef ef                    ; bdb5
dat56           hex d2 ef ef ef              ; bdb7

dat57           brk                          ; bdbb: 00
                ora (arr3,x)                 ; bdbc: 01 02

                hex 03                       ; bdbe

dat58           ora (arr1,x)                 ; bdbf: 01 00

                hex 03 02                    ; bdc1
dat59           hex 14                       ; bdc3

                ora arr11,x                  ; bdc4: 15 16

                hex 17                       ; bdc6

                clc                          ; bdc7: 18
                ora arr209,y                 ; bdc8: 19 1a 1b

                hex 0c                       ; bdcb

                ora ram232                   ; bdcc: 0d 0e 0f
                ora ram231                   ; bdcf: 0d 0c 0f
                asl ram236                   ; bdd2: 0e 15 14

                hex 17                       ; bdd5

                asl arr24,x                  ; bdd6: 16 38
                and misc61,y                 ; bdd8: 39 3a 3b
dat60           bvc cod388                   ; bddb: 50 51

                hex 52 53                    ; bddd
dat61           hex 52 53                    ; bddf

                bvc cod390                   ; bde1: 50 51
dat62           rti                          ; bde3: 40
                eor (arr29,x)                ; bde4: 41 42

                hex 43                       ; bde6

dat63           eor (ram37,x)                ; bde7: 41 40

                hex 43 42                    ; bde9

                pha                          ; bdeb: 48
                eor #%01001010               ; bdec: 49 4a

                hex 4b                       ; bdee

                eor #%01001000               ; bdef: 49 48

                hex 4b                       ; bdf1

                lsr a                        ; bdf2: 4a
                lsr a                        ; bdf3: 4a

                hex 4b                       ; bdf4

                pha                          ; bdf5: 48
                eor #%01001011               ; bdf6: 49 4b
                lsr a                        ; bdf8: 4a
                eor #%01001000               ; bdf9: 49 48
dat64           ldy #$a1                     ; bdfb: a0 a1
                ldx #$a3                     ; bdfd: a2 a3
dat65           ldx #$a3                     ; bdff: a2 a3
                ldy #$a1                     ; be01: a0 a1
dat66           tya                          ; be03: 98
                sta dat13,y                  ; be04: 99 9a 9b
dat67           sta $9b98,y                  ; be07: 99 98 9b
                txs                          ; be0a: 9a

                hex 9c                       ; be0b

                sta $9f9e,x                  ; be0c: 9d 9e 9f
                sta $9f9c,x                  ; be0f: 9d 9c 9f

                hex 9e 9e 9f 9c              ; be12

                sta dat15,x                  ; be16: 9d 9f 9e
                sta misc204,x                ; be19: 9d 9c 68
                adc #$6a                     ; be1c: 69 6a

                hex 6b                       ; be1e

                jmp (misc228)                ; be1f: 6c 6d 6e

                hex 6f                       ; be22

dat68           rts                          ; be23: 60
                adc (arr48,x)                ; be24: 61 62

                hex 63                       ; be26

dat69           adc (arr47,x)                ; be27: 61 60

                hex 63 62                    ; be29

                adc misc231                  ; be2b: 6d 6c 6f
cod388          ror misc202                  ; be2e: 6e 69 68

                hex 6b                       ; be31

                ror a                        ; be32: 6a
cod389          txa                          ; be33: 8a
cod390          pha                          ; be34: 48
                tya                          ; be35: 98
                pha                          ; be36: 48
                jsr sub254                   ; be37: 20 44 be
                pla                          ; be3a: 68
                tay                          ; be3b: a8
                pla                          ; be3c: 68
                tax                          ; be3d: aa
                lda #0                       ; be3e: a9 00
                sta arr75                    ; be40: 85 ab
                pla                          ; be42: 68
                rti                          ; be43: 40
sub254          ldx #0                       ; be44: a2 00
                stx ram97                    ; be46: 86 a9
                lda #8                       ; be48: a9 08
                sta ram48                    ; be4a: 85 5d
cod391          ldx ram97                    ; be4c: a6 a9
                lda arr178,x                 ; be4e: bd 45 06
                and #%00010000               ; be51: 29 10
                bne cod395                   ; be53: d0 26
                dec ram48                    ; be55: c6 5d
                beq cod393                   ; be57: f0 0a
                inx                          ; be59: e8
cod392          inc ram97                    ; be5a: e6 a9
                lda ram97                    ; be5c: a5 a9
                cmp #8                       ; be5e: c9 08
                bne cod391                   ; be60: d0 ea
                rts                          ; be62: 60
cod393          lda #0                       ; be63: a9 00
                sta ram98                    ; be65: 85 ac
                rts                          ; be67: 60
cod394          lda arr187,x                 ; be68: bd c5 06
                sta arr185,x                 ; be6b: 9d c3 06
                ldx ram97                    ; be6e: a6 a9
                lda arr178,x                 ; be70: bd 45 06
                and #%11101111               ; be73: 29 ef
                sta arr178,x                 ; be75: 9d 45 06
                jmp cod392                   ; be78: 4c 5a be
cod395          lda ram97                    ; be7b: a5 a9
                asl a                        ; be7d: 0a
                asl a                        ; be7e: 0a
                asl a                        ; be7f: 0a
                sta ram95                    ; be80: 85 a6
                tax                          ; be82: aa
                dec arr184,x                 ; be83: de c2 06
                bne cod392                   ; be86: d0 d2
                lda arr186,x                 ; be88: bd c4 06
                sta arr184,x                 ; be8b: 9d c2 06
                dec arr185,x                 ; be8e: de c3 06
                beq cod394                   ; be91: f0 d5
                lda arr183,x                 ; be93: bd c1 06
                and #%00001111               ; be96: 29 0f
                tay                          ; be98: a8
                lda $bc95,y                  ; be99: b9 95 bc
                sta arr96                    ; be9c: 85 dd
                tya                          ; be9e: 98
                asl a                        ; be9f: 0a
                tay                          ; bea0: a8
                lda dat45,y                  ; bea1: b9 75 bc
                sta ram96                    ; bea4: 85 a7
                lda $bc76,y                  ; bea6: b9 76 bc
                sta arr73                    ; bea9: 85 a8
                lda arr182,x                 ; beab: bd c0 06
                asl a                        ; beae: 0a
                tay                          ; beaf: a8
                lda $bd17,y                  ; beb0: b9 17 bd
                clc                          ; beb3: 18
                adc arr188,x                 ; beb4: 7d c6 06
                sta arr188,x                 ; beb7: 9d c6 06
                clc                          ; beba: 18
                lda $bd18,y                  ; bebb: b9 18 bd
dat70           adc arr189,x                 ; bebe: 7d c7 06
                sta arr189,x                 ; bec1: 9d c7 06
                ldy #0                       ; bec4: a0 00
                lda (ram96),y                ; bec6: b1 a7
                sta arr92                    ; bec8: 85 d5
                iny                          ; beca: c8
                lda (ram96),y                ; becb: b1 a7
                sta ram123                   ; becd: 85 d6
                lda arr182,x                 ; becf: bd c0 06
                tay                          ; bed2: a8
                lda (arr92),y                ; bed3: b1 d5
                sta arr93                    ; bed5: 85 d7
                beq cod396                   ; bed7: f0 20
                lda arr183,x                 ; bed9: bd c1 06
                and #%11110000               ; bedc: 29 f0
                clc                          ; bede: 18
                adc #$10                     ; bedf: 69 10
                cmp arr93                    ; bee1: c5 d7
                bne +                        ; bee3: d0 02
                lda #0                       ; bee5: a9 00
+               pha                          ; bee7: 48
                lda #$0f                     ; bee8: a9 0f
                and arr183,x                 ; beea: 3d c1 06
                sta arr183,x                 ; beed: 9d c1 06
                pla                          ; bef0: 68
                pha                          ; bef1: 48
                ora arr183,x                 ; bef2: 1d c1 06
                sta arr183,x                 ; bef5: 9d c1 06
                pla                          ; bef8: 68
cod396          lsr a                        ; bef9: 4a
                lsr a                        ; befa: 4a
                sta arr93                    ; befb: 85 d7
                ldy #2                       ; befd: a0 02
                lda (ram96),y                ; beff: b1 a7
                sta ram125                   ; bf01: 85 d9
                iny                          ; bf03: c8
                lda (ram96),y                ; bf04: b1 a7
                sta arr94                    ; bf06: 85 da
                lda arr182,x                 ; bf08: bd c0 06
                asl a                        ; bf0b: 0a
                tay                          ; bf0c: a8
                lda (ram125),y               ; bf0d: b1 d9
                sta ram126                   ; bf0f: 85 db
                iny                          ; bf11: c8
                lda (ram125),y               ; bf12: b1 d9
                sta arr95                    ; bf14: 85 dc
                lda arr182,x                 ; bf16: bd c0 06
                cmp #1                       ; bf19: c9 01
                beq +                        ; bf1b: f0 04
                cmp #5                       ; bf1d: c9 05
                bne cod400                   ; bf1f: d0 50
+               lda arr183,x                 ; bf21: bd c1 06
                and #%00001111               ; bf24: 29 0f
                beq cod397                   ; bf26: f0 23
                cmp #1                       ; bf28: c9 01
                beq cod397                   ; bf2a: f0 1f
                cmp #4                       ; bf2c: c9 04
                bne cod400                   ; bf2e: d0 41
                lda arr93                    ; bf30: a5 d7
                beq cod399                   ; bf32: f0 33
                lda arr182,x                 ; bf34: bd c0 06
                cmp #5                       ; bf37: c9 05
                beq +                        ; bf39: f0 08
                lda #$2b                     ; bf3b: a9 2b
                sta ram126                   ; bf3d: 85 db
                lda #$be                     ; bf3f: a9 be
                bne cod398                   ; bf41: d0 12
+               lda #$2f                     ; bf43: a9 2f
                sta ram126                   ; bf45: 85 db
                lda #$be                     ; bf47: a9 be
                bne cod398                   ; bf49: d0 0a
cod397          lda arr93                    ; bf4b: a5 d7
                beq cod399                   ; bf4d: f0 18
                lda #$d3                     ; bf4f: a9 d3
                sta ram126                   ; bf51: 85 db
                lda #$bd                     ; bf53: a9 bd
cod398          sta arr95                    ; bf55: 85 dc
                ldy ram97                    ; bf57: a4 a9
                lda #$40                     ; bf59: a9 40
                ora arr178,y                 ; bf5b: 19 45 06
                sta arr178,y                 ; bf5e: 99 45 06
                lda #0                       ; bf61: a9 00
                sta arr93                    ; bf63: 85 d7
                beq cod400                   ; bf65: f0 0a
cod399          ldy ram97                    ; bf67: a4 a9
                lda arr178,y                 ; bf69: b9 45 06
                and #%00111111               ; bf6c: 29 3f
                sta arr178,y                 ; bf6e: 99 45 06
cod400          lda ram97                    ; bf71: a5 a9
                jsr sub169                   ; bf73: 20 c5 a6
                tax                          ; bf76: aa
                ldy #0                       ; bf77: a0 00
                lda (ram126),y               ; bf79: b1 db
                clc                          ; bf7b: 18
                adc arr96                    ; bf7c: 65 dd
                adc arr93                    ; bf7e: 65 d7
                sta arr114,x                 ; bf80: 9d 81 02
                iny                          ; bf83: c8
                lda (ram126),y               ; bf84: b1 db
                clc                          ; bf86: 18
                adc arr96                    ; bf87: 65 dd
                adc arr93                    ; bf89: 65 d7
                sta arr118,x                 ; bf8b: 9d 85 02
                iny                          ; bf8e: c8
                lda (ram126),y               ; bf8f: b1 db
                clc                          ; bf91: 18
                adc arr96                    ; bf92: 65 dd
                adc arr93                    ; bf94: 65 d7
                sta arr122,x                 ; bf96: 9d 89 02
                iny                          ; bf99: c8
                lda (ram126),y               ; bf9a: b1 db
                clc                          ; bf9c: 18
                adc arr96                    ; bf9d: 65 dd
                adc arr93                    ; bf9f: 65 d7
                sta arr126,x                 ; bfa1: 9d 8d 02
                ldy ram97                    ; bfa4: a4 a9
                lda arr178,y                 ; bfa6: b9 45 06
                sta arr115,x                 ; bfa9: 9d 82 02
                sta arr119,x                 ; bfac: 9d 86 02
                sta arr123,x                 ; bfaf: 9d 8a 02
                sta arr127,x                 ; bfb2: 9d 8e 02
                ldy ram95                    ; bfb5: a4 a6
                lda arr188,y                 ; bfb7: b9 c6 06
                sta arr116,x                 ; bfba: 9d 83 02
                sta arr124,x                 ; bfbd: 9d 8b 02
                clc                          ; bfc0: 18
                adc #8                       ; bfc1: 69 08
                sta arr120,x                 ; bfc3: 9d 87 02
                sta arr128,x                 ; bfc6: 9d 8f 02
                lda arr189,y                 ; bfc9: b9 c7 06
                sta arr113,x                 ; bfcc: 9d 80 02
                sta arr117,x                 ; bfcf: 9d 84 02
                clc                          ; bfd2: 18
                adc #8                       ; bfd3: 69 08
                sta arr121,x                 ; bfd5: 9d 88 02
                sta arr125,x                 ; bfd8: 9d 8c 02
                jmp cod392                   ; bfdb: 4c 5a be
cod401          jmp $8370                    ; bfde: 4c 70 83
cod402          jmp cod24                    ; bfe1: 4c 6d 83
cod403          jsr sub60                    ; bfe4: 20 a1 8c
                jsr $a289                    ; bfe7: 20 89 a2
                jsr sub120                   ; bfea: 20 6d 9c
                jsr sub171                   ; bfed: 20 3b a7
                jsr sub148                   ; bff0: 20 93 a2
                lda arr144                   ; bff3: ad 00 04
                tax                          ; bff6: aa
                lda #0                       ; bff7: a9 00
                sta arr178,x                 ; bff9: 9d 45 06
                txa                          ; bffc: 8a
                sta ram93                    ; bffd: 85 a4
                asl a                        ; bfff: 0a
                asl a                        ; c000: 0a
                asl a                        ; c001: 0a
                sta ram94                    ; c002: 85 a5
                jsr sub21                    ; c004: 20 a2 85
                jsr sub64                    ; c007: 20 d4 8c
                cmp #$8a                     ; c00a: c9 8a
                bne cod402                   ; c00c: d0 d3
                jsr sub60                    ; c00e: 20 a1 8c
                jsr $a289                    ; c011: 20 89 a2
                jsr sub256                   ; c014: 20 a2 c0
                and #%00001111               ; c017: 29 0f
                sta arr183,x                 ; c019: 9d c1 06
                jsr sub255                   ; c01c: 20 9f c0
                cmp #9                       ; c01f: c9 09
                bcs cod401                   ; c021: b0 bb
                sta arr182,x                 ; c023: 9d c0 06
                lda arr183,x                 ; c026: bd c1 06
                asl a                        ; c029: 0a
                tay                          ; c02a: a8
                lda dat45,y                  ; c02b: b9 75 bc
                sta ram14                    ; c02e: 85 19
                lda $bc76,y                  ; c030: b9 76 bc
                sta ram15                    ; c033: 85 1a
                ldy #4                       ; c035: a0 04
                lda (ram14),y                ; c037: b1 19
                sta ram16                    ; c039: 85 1b
                iny                          ; c03b: c8
                lda (ram14),y                ; c03c: b1 19
                sta ram17                    ; c03e: 85 1c
                lda arr182,x                 ; c040: bd c0 06
                tay                          ; c043: a8
                lda (ram16),y                ; c044: b1 1b
                ldy ram93                    ; c046: a4 a4
                sta arr178,y                 ; c048: 99 45 06
                jsr sub257                   ; c04b: 20 a8 c0
                bcs cod404                   ; c04e: b0 4e
                jsr sub255                   ; c050: 20 9f c0
                sta arr184,x                 ; c053: 9d c2 06
                sta arr186,x                 ; c056: 9d c4 06
                jsr sub255                   ; c059: 20 9f c0
                clc                          ; c05c: 18
                adc #1                       ; c05d: 69 01
                sta arr185,x                 ; c05f: 9d c3 06
                sta arr187,x                 ; c062: 9d c5 06
                jsr sub257                   ; c065: 20 a8 c0
                bcs cod404                   ; c068: b0 34
                jsr sub255                   ; c06a: 20 9f c0
                ldy #0                       ; c06d: a0 00
                lda arr144                   ; c06f: ad 00 04
                beq +                        ; c072: f0 02
                ldy #$20                     ; c074: a0 20
+               ldx ram93                    ; c076: a6 a4
                tya                          ; c078: 98
                ora arr178,x                 ; c079: 1d 45 06
                sta arr178,x                 ; c07c: 9d 45 06
                jsr sub257                   ; c07f: 20 a8 c0
                bcs cod404                   ; c082: b0 1a
                jsr sub255                   ; c084: 20 9f c0
                and #%00000011               ; c087: 29 03
                ldx ram93                    ; c089: a6 a4
                ora arr178,x                 ; c08b: 1d 45 06
                sta arr178,x                 ; c08e: 9d 45 06
                jsr sub148                   ; c091: 20 93 a2
                lda #$78                     ; c094: a9 78
                ldx ram94                    ; c096: a6 a5
                sta arr188,x                 ; c098: 9d c6 06
                sta arr189,x                 ; c09b: 9d c7 06
cod404          rts                          ; c09e: 60
sub255          jsr sub165                   ; c09f: 20 94 a5
sub256          jsr sub120                   ; c0a2: 20 6d 9c
                ldx ram94                    ; c0a5: a6 a5
                rts                          ; c0a7: 60
sub257          jsr sub64                    ; c0a8: 20 d4 8c
                cmp #$29                     ; c0ab: c9 29
                beq +                        ; c0ad: f0 02
                clc                          ; c0af: 18
                rts                          ; c0b0: 60
+               jsr sub60                    ; c0b1: 20 a1 8c
                sec                          ; c0b4: 38
                rts                          ; c0b5: 60
                jsr sub120                   ; c0b6: 20 6d 9c
                jsr sub171                   ; c0b9: 20 3b a7
                asl a                        ; c0bc: 0a
                asl a                        ; c0bd: 0a
                asl a                        ; c0be: 0a
                sta ram94                    ; c0bf: 85 a5
                jsr sub255                   ; c0c1: 20 9f c0
                sta arr188,x                 ; c0c4: 9d c6 06
                jsr sub255                   ; c0c7: 20 9f c0
                sta arr189,x                 ; c0ca: 9d c7 06
                rts                          ; c0cd: 60
-               jsr sub120                   ; c0ce: 20 6d 9c
                jsr sub171                   ; c0d1: 20 3b a7
                tax                          ; c0d4: aa
                lda #$10                     ; c0d5: a9 10
                ora arr178,x                 ; c0d7: 1d 45 06
                sta arr178,x                 ; c0da: 9d 45 06
                jsr sub13                    ; c0dd: 20 78 83
                beq +                        ; c0e0: f0 06
                jsr sub165                   ; c0e2: 20 94 a5
                jmp -                        ; c0e5: 4c ce c0
+               lda #$ff                     ; c0e8: a9 ff
                sta ram98                    ; c0ea: 85 ac
cod405          rts                          ; c0ec: 60
-               lda #$ff                     ; c0ed: a9 ff
                ldx_abs ram97                ; c0ef: ae a9 00
                sta ram61                    ; c0f2: 85 75
                jsr sub120                   ; c0f4: 20 6d 9c
                jsr sub171                   ; c0f7: 20 3b a7
                tay                          ; c0fa: a8
                lda arr178,y                 ; c0fb: b9 45 06
                and #%11101111               ; c0fe: 29 ef
                sta arr178,y                 ; c100: 99 45 06
                lda ram61                    ; c103: a5 75
                beq +                        ; c105: f0 13
                tya                          ; c107: 98
                jsr sub169                   ; c108: 20 c5 a6
                tay                          ; c10b: a8
                lda #$f8                     ; c10c: a9 f8
                sta arr113,y                 ; c10e: 99 80 02
                sta arr117,y                 ; c111: 99 84 02
                sta arr121,y                 ; c114: 99 88 02
                sta arr125,y                 ; c117: 99 8c 02
+               jsr sub13                    ; c11a: 20 78 83
                beq cod405                   ; c11d: f0 cd
                jsr sub165                   ; c11f: 20 94 a5
                lda ram61                    ; c122: a5 75
                beq $c0f0                    ; c124: f0 ca
                bne -                        ; c126: d0 c5

                hex 80 47 4f 54 4f           ; c128

                sta (ram39,x)                ; c12d: 81 47

                hex 4f 53                    ; c12f

                eor arr29,x                  ; c131: 55 42

                hex 82 52                    ; c133

                eor arr37,x                  ; c135: 55 4e

                hex 83 52                    ; c137

                eor arr43                    ; c139: 45 54
                eor arr41,x                  ; c13b: 55 52
                lsr misc140                  ; c13d: 4e 84 52
                eor arr42                    ; c140: 45 53

                hex 54 4f 52                 ; c142

                eor ram71                    ; c145: 45 85

                hex 54                       ; c147

                pha                          ; c148: 48
                eor arr37                    ; c149: 45 4e
                stx arr36                    ; c14b: 86 4c
                eor #%01010011               ; c14d: 49 53

                hex 54 87 53                 ; c14f

                eor misc150,y                ; c152: 59 53 54
                eor ram42                    ; c155: 45 4d
                dey                          ; c157: 88

                hex 54 4f 89 53 54           ; c158

                eor arr39                    ; c15d: 45 50
                txa                          ; c15f: 8a

                hex 53                       ; c160

                bvc $c1b5                    ; c161: 50 52
                eor #%01010100               ; c163: 49 54
                eor ram77                    ; c165: 45 8b
                bvc $c1bb                    ; c167: 50 52
                eor #%01001110               ; c169: 49 4e

                hex 54                       ; c16b

                sty misc126                  ; c16c: 8c 46 4f

                hex 52                       ; c16f

                sta misc95                   ; c170: 8d 4e 45
                cli                          ; c173: 58

                hex 54                       ; c174

                stx misc77                   ; c175: 8e 50 41
                eor arr42,x                  ; c178: 55 53
                eor ram78                    ; c17a: 45 8f
                eor #%01001110               ; c17c: 49 4e
                bvc cod406                   ; c17e: 50 55

                hex 54                       ; c180

                bcc +                        ; c181: 90 4c
                eor #%01001110               ; c183: 49 4e
                bvc cod407                   ; c185: 50 55

                hex 54                       ; c187

                sta (arr31),y                ; c188: 91 44
                eor (arr43,x)                ; c18a: 41 54
                eor (ram81,x)                ; c18c: 41 92
                eor #%01000110               ; c18e: 49 46

                hex 93 52                    ; c190

                eor ram38                    ; c192: 45 41

                hex 44                       ; c194

                sty arr31,x                  ; c195: 94 44
                eor #%01001101               ; c197: 49 4d
                sta arr41,x                  ; c199: 95 52
                eor ram42                    ; c19b: 45 4d
                stx arr42,y                  ; c19d: 96 53

                hex 54 4f                    ; c19f

                bvc $c13a                    ; c1a1: 50 97

                hex 43 4f                    ; c1a3

                lsr $9854                    ; c1a5: 4e 54 98

                hex 43                       ; c1a8

                jmp cod180                   ; c1a9: 4c 53 99

                hex 43                       ; c1ac

                jmp misc74                   ; c1ad: 4c 45 41

                hex 52                       ; c1b0

                txs                          ; c1b1: 9a

                hex 4f                       ; c1b2

                lsr misc129                  ; c1b3: 4e 9b 4f
                lsr arr33                    ; c1b6: 46 46

                hex 9c 43                    ; c1b8

                eor arr43,x                  ; c1ba: 55 54
                sta misc95,x                 ; c1bc: 9d 4e 45

                hex 57 9e                    ; c1bf

                bvc $c212                    ; c1c1: 50 4f

                hex 4b                       ; c1c3

                eor arr71                    ; c1c4: 45 9f

                hex 43 47 53                 ; c1c6

                eor arr43                    ; c1c9: 45 54
                ldy #$56                     ; c1cb: a0 56
                eor #%01000101               ; c1cd: 49 45

+               hex 57                       ; c1cf

                lda (ram42,x)                ; c1d0: a1 4d

                hex 4f                       ; c1d2

                lsr arr32,x                  ; c1d3: 56 45
cod406          ldx #$45                     ; c1d5: a2 45
                lsr dat20                    ; c1d7: 4e 44 a3
                bvc cod408                   ; c1da: 50 4c
cod407          eor (ram44,x)                ; c1dc: 41 59
                ldy arr29                    ; c1de: a4 42
                eor arr32                    ; c1e0: 45 45
                bvc $c189                    ; c1e2: 50 a5
                jmp misc76                   ; c1e4: 4c 4f 41

                hex 44                       ; c1e7

                ldx arr42                    ; c1e8: a6 53
                eor (arr45,x)                ; c1ea: 41 56
                eor ram96                    ; c1ec: 45 a7
                bvc cod409                   ; c1ee: 50 4f

                hex 53                       ; c1f0

                eor #%01010100               ; c1f1: 49 54
                eor #%01001111               ; c1f3: 49 4f
                lsr misc107                  ; c1f5: 4e a8 4b
                eor ram44                    ; c1f8: 45 59
                lda #$43                     ; c1fa: a9 43

                hex 4f                       ; c1fc

                jmp misc139                  ; c1fd: 4c 4f 52
                tax                          ; c200: aa

                hex 44                       ; c201

                eor arr33                    ; c202: 45 46

                hex ab 43 47                 ; c204

                eor arr37                    ; c207: 45 4e
                ldy misc155                  ; c209: ac 53 57
                eor (arr39,x)                ; c20c: 41 50
                lda misc73                   ; c20e: ad 43 41
                jmp $ae4c                    ; c211: 4c 4c ae
                jmp misc84                   ; c214: 4c 4f 43
                eor (arr43,x)                ; c217: 41 54
                eor ram100                   ; c219: 45 af
                bvc cod410                   ; c21b: 50 41
                jmp misc147                  ; c21d: 4c 45 54
                bcs $c267                    ; c220: b0 45

dat71           hex 52                       ; c222

                eor (ram133,x)               ; c223: 41 ef
                cli                          ; c225: 58

                hex 4f 52                    ; c226

cod408          beq cod411                   ; c228: f0 4f

                hex 52                       ; c22a

                sbc (ram38),y                ; c22b: f1 41
                lsr $f244                    ; c22d: 4e 44 f2
                lsr misc148                  ; c230: 4e 4f 54

                hex f3 3c                    ; c233

                rol misc65,x                 ; c235: 3e f4 3e
                and misc62,x                 ; c238: 3d f5 3c
                and misc64,x                 ; c23b: 3d f6 3d

                hex f7                       ; c23e

cod409          rol misc63,x                 ; c23f: 3e f8 3c
                sbc cod733,y                 ; c242: f9 2b fa
                and misc117                  ; c245: 2d fb 4d

                hex 4f 44 fc 2f              ; c248

                sbc $ca2a,x                  ; c24c: fd 2a ca
                eor (arr29,x)                ; c24f: 41 42

                hex 53 cb                    ; c251

                eor (arr42,x)                ; c253: 41 53

                hex 43                       ; c255

                cpy misc150                  ; c256: cc 53 54

                hex 52                       ; c259

                bit ram120                   ; c25a: 24 cd
                lsr arr41                    ; c25c: 46 52
cod410          eor arr87                    ; c25e: 45 ce
                jmp misc120                  ; c260: 4c 45 4e

                hex cf                       ; c263

                bvc cod412                   ; c264: 50 45
                eor ram41                    ; c266: 45 4b
                bne $c2bc                    ; c268: d0 52
                lsr $d144                    ; c26a: 4e 44 d1

                hex 53 47                    ; c26d

                lsr misc146                  ; c26f: 4e d2 53
                bvc cod413                   ; c272: 50 43

                hex d3 54                    ; c274

                eor (arr29,x)                ; c276: 41 42

                hex d4                       ; c278

cod411          eor misc89                   ; c279: 4d 49 44
                bit arr92                    ; c27c: 24 d5

                hex 53 54                    ; c27e

                eor #%01000011               ; c280: 49 43

                hex 4b                       ; c282

                dec arr42,x                  ; c283: d6 53

                hex 54 52                    ; c285

                eor #%01000111               ; c287: 49 47

                hex d7                       ; c289

                cli                          ; c28a: 58
                bvc cod414                   ; c28b: 50 4f

                hex 53                       ; c28d

                cld                          ; c28e: d8
                eor misc128,y                ; c28f: 59 50 4f

                hex 53                       ; c292

                cmp misc78,y                 ; c293: d9 56 41
                jmp misc134                  ; c296: 4c da 50

                hex 4f 53 db 43 53 52        ; c299

                jmp misc121                  ; c29f: 4c 49 4e

                hex dc 43                    ; c2a2

                pha                          ; c2a4: 48

                hex 52                       ; c2a5

                bit arr96                    ; c2a6: 24 dd
                pha                          ; c2a8: 48
                eor arr46                    ; c2a9: 45 58
cod412          bit arr97                    ; c2ab: 24 de
                eor #%01001110               ; c2ad: 49 4e

                hex 4b                       ; c2af

                eor ram44                    ; c2b0: 45 59
                bit ram127                   ; c2b2: 24 df

                hex 52                       ; c2b4

                eor #%01000111               ; c2b5: 49 47
cod413          pha                          ; c2b7: 48

                hex 54                       ; c2b8

                bit ram128                   ; c2b9: 24 e0
                jmp misc99                   ; c2bb: 4c 45 46

                hex 54                       ; c2be

                bit ram129                   ; c2bf: 24 e1

                hex 53 43 52                 ; c2c1

                bit arr105                   ; c2c4: 24 ff
dat72           lsr ram80                    ; c2c6: 46 91
                dec ram79                    ; c2c8: c6 90

                hex 7c                       ; c2ca

                sta ram22                    ; c2cb: 85 26
                sta (ram128),y               ; c2cd: 91 e0
                tya                          ; c2cf: 98
                adc $af83                    ; c2d0: 6d 83 af
                sta arr93                    ; c2d3: 85 d7

                hex 80                       ; c2d5

                adc misc224                  ; c2d6: 6d 83 6d

                hex 83 f3 a7                 ; c2d9

cod414          rti                          ; c2dc: 40

                hex 87                       ; c2dd

                ror arr202,x                 ; c2de: 7e 92 0d

                hex 93                       ; c2e1

                tya                          ; c2e2: 98
                sta (ram114),y               ; c2e3: 91 c2

                hex 93                       ; c2e5

                inc arr68,x                  ; c2e6: f6 94

                hex 43 83 04 92              ; c2e8

                eor misc123                  ; c2ec: 4d 99 4e
                stx arr30,y                  ; c2ef: 96 43

                hex 83 da                    ; c2f1

                stx ram13                    ; c2f3: 86 17

                hex 87                       ; c2f5

                adc arr75,x                  ; c2f6: 75 ab
                rol ram81                    ; c2f8: 26 92
                eor misc225                  ; c2fa: 4d 95 6d

                hex 83                       ; c2fd

                beq $c2c0                    ; c2fe: f0 c0

                hex 82 83 df                 ; c300

                sta (arr33),y                ; c303: 91 46

                hex a7 32                    ; c305

                lda #$ce                     ; c307: a9 ce
                cpy #$0b                     ; c309: c0 0b

                hex 82                       ; c30b

                ora arr205,x                 ; c30c: 1d 9a 0f

                hex b3 fc 97                 ; c30f

                sty $b697                    ; c312: 8c 97 b6
                cpy #$aa                     ; c315: c0 aa
                sta arr37,x                  ; c317: 95 4e
                tsx                          ; c319: ba

                hex 87                       ; c31a

                tay                          ; c31b: a8
                dex                          ; c31c: ca
                ldx ram82                    ; c31d: a6 96
                sty arr64,x                  ; c31f: 94 8c
                sta (arr85),y                ; c321: 91 ca
                sta (ram132),y               ; c323: 91 ea
                ldx arr98                    ; c325: a6 ed
                cpy #$69                     ; c327: c0 69

dat73           hex a3                       ; c329

                asl a                        ; c32a: 0a
                ldy ram71                    ; c32b: a4 85
                ldy ram15                    ; c32d: a4 1a

                hex a3 ff a3                 ; c32f

                cli                          ; c332: 58

                hex a3 9f a3                 ; c333

                adc misc226,y                ; c336: 79 a3 6d

                hex 83                       ; c339

                adc $fb83                    ; c33a: 6d 83 fb
                lda arr74                    ; c33d: a5 aa
                ldx arr78                    ; c33f: a6 b9
                ldx arr33                    ; c341: a6 46

                hex a3 4f a3                 ; c343

                ldx misc45,y                 ; c346: be a4 2e

                hex a3 f3                    ; c349

                ldx #$61                     ; c34b: a2 61
                ldy ram105                   ; c34d: a4 b5
                ldy arr14                    ; c34f: a4 20
                lda arr80                    ; c351: a5 bd
                lda arr57                    ; c353: a5 74
                lda ram18                    ; c355: a5 1d
                ldy arr37                    ; c357: a4 4e

                hex 53                       ; c359

                and misc152                  ; c35a: 2d 48 55

                hex 42                       ; c35d

                eor (arr42,x)                ; c35e: 41 53
                eor #%01000011               ; c360: 49 43
                jsr misc50                   ; c362: 20 56 32
                rol misc71                   ; c365: 2e 31 41
                ora dat32                    ; c368: 0d 0a b4
                jsr misc105                  ; c36b: 20 4e 49
                lsr misc96                   ; c36e: 4e 54 45
                lsr misc125                  ; c371: 4e 44 4f

                hex 2f 53                    ; c374

                pha                          ; c376: 48
                eor (arr41,x)                ; c377: 41 52
                bvc cod415                   ; c379: 50 2f
                pha                          ; c37b: 48
                eor arr31,x                  ; c37c: 55 44

                hex 53 4f                    ; c37e

                lsr ram219                   ; c380: 4e 0d 0a
                brk                          ; c383: 00
                jsr misc75                   ; c384: 20 47 41
                eor misc5                    ; c387: 4d 45 20

                hex 42                       ; c38a

                eor (arr42,x)                ; c38b: 41 53
                eor #%01000011               ; c38d: 49 43
                jsr ram217                   ; c38f: 20 00 08

dat74           hex 03                       ; c392

dat75           sty arr82                    ; c393: 84 c3

                hex 07 07                    ; c395

                ror ram216                   ; c397: 6e 81 07
                ora #%01110111               ; c39a: 09 77
                sta (ram3,x)                 ; c39c: 81 07

                hex 0b                       ; c39e

                sta ram68                    ; c39f: 85 81
                asl ram10                    ; c3a1: 06 12
                sty $af81                    ; c3a3: 8c 81 af

dat76           hex c3 bf c3                 ; c3a6
dat77           hex cf                       ; c3a9
cod415          hex c3 df c3 ef c3 0f        ; c3aa

                bit arr192                   ; c3b0: 2c 15 07

                hex 0f 27                    ; c3b3

                and (ram10,x)                ; c3b5: 21 12

                hex 0f                       ; c3b7

                and #%00110110               ; c3b8: 29 36

                hex 17 0f                    ; c3ba

                bmi +                        ; c3bc: 30 26

                hex 07 0f                    ; c3be

                bmi $c3e3                    ; c3c0: 30 21

                hex 02 0f                    ; c3c2

                bmi $c3ed                    ; c3c4: 30 27
                clc                          ; c3c6: 18

                hex 0f                       ; c3c7

                bmi $c3f1                    ; c3c8: 30 27
                asl arr9,x                   ; c3ca: 16 0f
                and #%00110110               ; c3cc: 29 36

                hex 17 0f                    ; c3ce

                rol arr11,x                  ; c3d0: 36 16

                hex 02 0f 27                 ; c3d2

                bmi cod416                   ; c3d5: 30 19

                hex 0f                       ; c3d7

                and arr17,x                  ; c3d8: 35 25

                hex 17 0f                    ; c3da

                bmi $c405                    ; c3dc: 30 27
                asl arr9,x                   ; c3de: 16 0f
                bmi cod417                   ; c3e0: 30 16
                ora (arr9,x)                 ; c3e2: 01 0f
+               bpl +                        ; c3e4: 10 00
+               ora (arr9,x)                 ; c3e6: 01 0f
                bmi cod419                   ; c3e8: 30 29
                ora #%00001111               ; c3ea: 09 0f
                bmi cod418                   ; c3ec: 30 16

                hex 07 0f                    ; c3ee

cod416          bmi $c418                    ; c3f0: 30 26

                hex 12 0f                    ; c3f2

                bmi $c40b                    ; c3f4: 30 15

                hex 12 0f                    ; c3f6

cod417          bmi $c40c                    ; c3f8: 30 12
                asl arr9,x                   ; c3fa: 16 0f
                bmi $c424                    ; c3fc: 30 26
                ora misc274,y                ; c3fe: 19 ff 78
                cld                          ; c401: d8
                lda #$10                     ; c402: a9 10
cod418          sta ppu_ctrl                 ; c404: 8d 00 20
                ldx #$ff                     ; c407: a2 ff
                txs                          ; c409: 9a
-               lda ppu_status               ; c40a: ad 02 20
                and #%10000000               ; c40d: 29 80
                beq -                        ; c40f: f0 f9
                ldy #7                       ; c411: a0 07
cod419          sty arr2                     ; c413: 84 01
                ldy #0                       ; c415: a0 00
                sty arr1                     ; c417: 84 00
                tya                          ; c419: 98
-               sta (arr1),y                 ; c41a: 91 00
                dey                          ; c41c: 88
                bne -                        ; c41d: d0 fb
                dec arr2                     ; c41f: c6 01
                bpl -                        ; c421: 10 f7
                lda #$ff                     ; c423: a9 ff
                sta ram62                    ; c425: 85 7a
                jsr sub261                   ; c427: 20 94 cd
                lda #$fd                     ; c42a: a9 fd
                sta ram128                   ; c42c: 85 e0
                lda #$5f                     ; c42e: a9 5f
                sta ram129                   ; c430: 85 e1
                lda ram8                     ; c432: a5 10
                eor #%10000000               ; c434: 49 80
                jsr sub388                   ; c436: 20 7a ec
                lda #$0f                     ; c439: a9 0f
                sta snd_chn                  ; c43b: 8d 15 40
                lda #$4c                     ; c43e: a9 4c
                sta arr98                    ; c440: 85 ed
                lda #$a7                     ; c442: a9 a7
                sta arr99                    ; c444: 85 ee
                lda #$cd                     ; c446: a9 cd
                sta ram133                   ; c448: 85 ef
cod420          lda arr47                    ; c44a: a5 60
                cmp #1                       ; c44c: c9 01
                bne +                        ; c44e: d0 0a
                lda ram8                     ; c450: a5 10
                and #%01111111               ; c452: 29 7f
                jsr sub388                   ; c454: 20 7a ec
                jmp cod1                     ; c457: 4c 00 80
+               jsr sub398                   ; c45a: 20 e8 ed
                lda ram38                    ; c45d: a5 41
                beq cod422                   ; c45f: f0 14
                jsr sub326                   ; c461: 20 a6 df
                lda arr78                    ; c464: a5 b9
                beq +                        ; c466: f0 06
                jsr sub319                   ; c468: 20 01 de
                jmp cod421                   ; c46b: 4c 71 c4
+               jsr sub318                   ; c46e: 20 a9 dd
cod421          lda #0                       ; c471: a9 00
                sta ram38                    ; c473: 85 41
cod422          jmp cod420                   ; c475: 4c 4a c4
dat78           cmp ram134                   ; c478: c5 f0
                brk                          ; c47a: 00
                sec                          ; c47b: 38
                cmp arr100                   ; c47c: c5 f1
                brk                          ; c47e: 00
                pla                          ; c47f: 68
                cmp ram135                   ; c480: c5 f2
                brk                          ; c482: 00
                ldy #$c5                     ; c483: a0 c5

                hex f3                       ; c485

                brk                          ; c486: 00
                bne $c498                    ; c487: d0 0f

                hex 07 73 ab                 ; c489

                sed                          ; c48c: f8

                hex 02                       ; c48d

                dec dat36,x                  ; c48e: de b0 b6
                ldy arr206,x                 ; c491: bc c2 10

                hex df                       ; c494

                inx                          ; c495: e8
dat79           sec                          ; c496: 38
                bvs $c441                    ; c497: 70 a8

                hex bf                       ; c499
dat80           hex 63 73 83                 ; c49a

                bcc cod424                   ; c49d: 90 62

                hex 72 82 92                 ; c49f
dat81           hex 0c 0c 0c 1c              ; c4a2

dat82           asl arr5,x                   ; c4a6: 16 06

                hex 07                       ; c4a8

                php                          ; c4a9: 08

                hex 0f                       ; c4aa

                php                          ; c4ab: 08

                hex 07                       ; c4ac

                asl arr1                     ; c4ad: 06 00
                bvs $c4c1                    ; c4af: 70 10
dat83           jsr misc19                   ; c4b1: 20 20 21
                and (arr15,x)                ; c4b4: 21 21
                and (arr15,x)                ; c4b6: 21 21
                and (ram20,x)                ; c4b8: 21 22

                hex 22 22                    ; c4ba

dat84           dec ram130                   ; c4bc: c6 e6
                asl ram22                    ; c4be: 06 26
                lsr ram54                    ; c4c0: 46 66
                stx ram95                    ; c4c2: 86 a6
                lsr ram54                    ; c4c4: 46 66
                stx ram129                   ; c4c6: 86 e1
                sbc (ram129,x)               ; c4c8: e1 e1
                sbc (ram129,x)               ; c4ca: e1 e1
                sbc ram131                   ; c4cc: e5 e9
                inc $f7f3                    ; c4ce: ee f3 f7

                hex fb ff 03                 ; c4d1

dat85           cpy ram115                   ; c4d4: c4 c4
                cpy ram115                   ; c4d6: c4 c4
                cpy ram115                   ; c4d8: c4 c4
                cpy ram115                   ; c4da: c4 c4
                cpy ram115                   ; c4dc: c4 c4
                cpy ram115                   ; c4de: c4 c4
                cmp arr7                     ; c4e0: c5 0c

                hex 3f 07                    ; c4e2

                cmp arr7                     ; c4e4: c5 0c

                hex 3f 0c                    ; c4e6

                cmp ram55                    ; c4e8: c5 68
                bit arr101                   ; c4ea: 24 f4
                adc (arr1,x)                 ; c4ec: 61 00
                pla                          ; c4ee: 68
                sty ram141                   ; c4ef: 84 fa
                adc (arr12,x)                ; c4f1: 61 18
                dec arr14                    ; c4f3: c6 20
                bvc $c4fa                    ; c4f5: 50 03

                hex 14                       ; c4f7
cod423          hex 3f                       ; c4f8

                bvc $c4fe                    ; c4f9: 50 03

                hex 44 23                    ; c4fb

                ora (arr83),y                ; c4fd: 11 c5

                hex 67 22                    ; c4ff

cod424          ora (arr83),y                ; c501: 11 c5

                hex 44 23 17                 ; c503

                cmp arr10                    ; c506: c5 14

                hex 0f                       ; c508

                asl arr3,x                   ; c509: 16 02
                rol a                        ; c50b: 2a

                hex 14 0f 0f 0f 0f           ; c50c

                ora arr14,x                  ; c511: 15 20
                jsr misc3                    ; c513: 20 20 20
                jsr sub466                   ; c516: 20 15 ff

                hex ff ff ff ff              ; c519

dat86           dec arr85                    ; c51d: c6 ca
                dec $d6d2                    ; c51f: ce d2 d6
                cpy dat115                   ; c522: cc d0 d4

dat87           hex ff                       ; c525

                inc $fd20,x                  ; c526: fe 20 fd
dat88           lda (ram105,x)               ; c529: a1 b5

                hex c2                       ; c52b

                cmp #$cd                     ; c52c: c9 cd

                hex d4 e2 fc 07 13 22        ; c52e

                and #%01000111               ; c534: 29 47
                eor arr51,x                  ; c536: 55 6a

                hex 80                       ; c538

                stx arr68                    ; c539: 86 94

                hex 9f                       ; c53b

                bcs cod423                   ; c53c: b0 ba
                dex                          ; c53e: ca

                hex db                       ; c53f

                cpx arr99                    ; c540: e4 ee
                sed                          ; c542: f8
                bit ram38                    ; c543: 24 41
                eor misc252                  ; c545: 4d 5a 72
                lda (arr87,x)                ; c548: a1 ce

                hex f7                       ; c54a

                ora misc180,y                ; c54b: 19 40 62
                sty $ebb7                    ; c54e: 8c b7 eb

                hex 03 0c                    ; c551

                plp                          ; c553: 28
                eor arr41                    ; c554: 45 52
                adc ram63                    ; c556: 65 7b

                hex 7c                       ; c558

                txa                          ; c559: 8a
                sta dat33,x                  ; c55a: 9d a9 b4

                hex b7                       ; c55d

                ldx $d2cf,y                  ; c55e: be cf d2
                sbc (arr1,x)                 ; c561: e1 00
                ora (ram24),y                ; c563: 11 28
dat89           cmp arr83                    ; c565: c5 c5
                cmp arr83                    ; c567: c5 c5
                cmp arr83                    ; c569: c5 c5
                cmp arr83                    ; c56b: c5 c5
                dec arr84                    ; c56d: c6 c6
                dec arr84                    ; c56f: c6 c6
                dec arr84                    ; c571: c6 c6
                dec arr84                    ; c573: c6 c6
                dec arr84                    ; c575: c6 c6
                dec arr84                    ; c577: c6 c6
                dec arr84                    ; c579: c6 c6
                dec arr84                    ; c57b: c6 c6
                dec arr84                    ; c57d: c6 c6

                hex c7 c7 c7 c7 c7 c7 c7 c7  ; c57f

                iny                          ; c587: c8
                iny                          ; c588: c8
                iny                          ; c589: c8
                iny                          ; c58a: c8
                iny                          ; c58b: c8
                iny                          ; c58c: c8
                cmp #$c9                     ; c58d: c9 c9
                cmp #$c9                     ; c58f: c9 c9
                cmp #$c9                     ; c591: c9 c9
                cmp #$c9                     ; c593: c9 c9
                cmp #$c9                     ; c595: c9 c9
                cmp #$c9                     ; c597: c9 c9
                cmp #$c9                     ; c599: c9 c9
                cmp #$c9                     ; c59b: c9 c9
                cmp #$ca                     ; c59d: c9 ca
                dex                          ; c59f: ca
                dex                          ; c5a0: ca

                hex 8b 6f 6b                 ; c5a1

                adc misc278,y                ; c5a4: 79 0d 7b
                stx $877f                    ; c5a7: 8e 7f 87
                and $8c69                    ; c5aa: 2d 69 8c
                ldy misc41                   ; c5ad: ac 94 2d

                hex 6f                       ; c5b0

                jsr misc222                  ; c5b1: 20 a4 6c

                hex ff                       ; c5b4

                lda arr48                    ; c5b5: a5 62
                ror a                        ; c5b7: 6a
                sta misc191                  ; c5b8: 8d 20 65
                adc (ram57,x)                ; c5bb: 61 6b
                jsr misc282                  ; c5bd: 20 6b 7e
                jmp ($8bff)                  ; c5c0: 6c ff 8b
                adc ram73                    ; c5c3: 65 87
                ror misc230,x                ; c5c5: 7e 6b 6f

                hex ff                       ; c5c8

                adc misc21,y                 ; c5c9: 79 61 21

                hex ff 87                    ; c5cc

                sta arr48,x                  ; c5ce: 95 62
                adc ram51                    ; c5d0: 65 61
                and (arr105,x)               ; c5d2: 21 ff
                ror a                        ; c5d4: 6a
                tya                          ; c5d5: 98
                sta arr48,x                  ; c5d6: 95 62
                sta misc191                  ; c5d8: 8d 20 65
                adc (ram57,x)                ; c5db: 61 6b
                jsr misc282                  ; c5dd: 20 6b 7e
                jmp (misc169)                ; c5e0: 6c ff 60

                hex 74 6f                    ; c5e3

                adc dat18,y                  ; c5e5: 79 20 a1

                hex 89                       ; c5e8

                ldy ram58                    ; c5e9: a4 6c
                adc arr28                    ; c5eb: 65 3f
                ora misc283                  ; c5ed: 0d 74 7e

                hex 63                       ; c5f0

                sta misc171                  ; c5f1: 8d 20 61

                hex 89 72                    ; c5f4

                jsr $a167                    ; c5f6: 20 67 a1
                ror a                        ; c5f9: 6a
                adc (arr105,x)               ; c5fa: 61 ff

                hex 82 62                    ; c5fc

                adc (arr53,x)                ; c5fe: 61 70
                lda arr14                    ; c600: a5 20
                ror ram54                    ; c602: 66 66
                ror $ff6c,x                  ; c604: 7e 6c ff

                hex 22 c2 22                 ; c607

                adc arr8,x                   ; c60a: 75 0d
                jsr misc282                  ; c60c: 20 6b 7e
                jmp (misc68)                 ; c60f: 6c 65 3f

                hex ff                       ; c612

                ror a                        ; c613: 6a
                tya                          ; c614: 98
                sta arr48,x                  ; c615: 95 62
                sta misc236                  ; c617: 8d 20 70
                sty arr48,x                  ; c61a: 94 62

                hex 6b                       ; c61c

                jsr misc282                  ; c61d: 20 6b 7e
                jmp (misc211)                ; c620: 6c ff 6a
                sta arr48                    ; c623: 85 62

                hex 74                       ; c625

                stx arr15                    ; c626: 86 21

                hex ff                       ; c628

                adc ram59                    ; c629: 65 6d
                stx arr56,y                  ; c62b: 96 73
                sei                          ; c62d: 78
                jsr sub101                   ; c62e: 20 a6 96

                hex 67                       ; c631

                rts                          ; c632: 60
                stx arr76,y                  ; c633: 96 ad
                jmp ($9661)                  ; c635: 6c 61 96
                bvs $c5c7                    ; c638: 70 8d
                ora misc100                  ; c63a: 0d 4f 46
                lsr ram61                    ; c63d: 46 75
                jsr misc254                  ; c63f: 20 6b 72

                hex 67                       ; c642

                lda (arr51,x)                ; c643: a1 6a
                adc (arr105,x)               ; c645: 61 ff

                hex 22 c2 22                 ; c647

                sta misc2                    ; c64a: 8d 0d 20
                adc ram51                    ; c64d: 65 61

                hex 6b                       ; c64f

                jsr misc282                  ; c650: 20 6b 7e
                jmp (misc24)                 ; c653: 6c ff 22

                hex c2 22                    ; c656

                adc misc2,y                  ; c658: 79 0d 20
                adc (ram66,x)                ; c65b: 61 7e
                jsr $946b                    ; c65d: 20 6b 94

                hex 62 87                    ; c660

                sta arr48,x                  ; c662: 95 62
                jsr misc282                  ; c664: 20 6b 7e

                hex 6b 6f ff                 ; c667

                rts                          ; c66a: 60
                rts                          ; c66b: 60
                and (arr8,x)                 ; c66c: 21 0d
                ror misc264,x                ; c66e: 7e 63 75
                jsr misc167                  ; c671: 20 64 60
                adc (ram57,x)                ; c674: 61 6b

                hex 6f                       ; c676

                adc #$73                     ; c677: 69 73

                hex 97                       ; c679

                jsr $8760                    ; c67a: 20 60 87
                ror $ff6c,x                  ; c67d: 7e 6c ff
                adc #$8c                     ; c680: 69 8c
                adc arr53,x                  ; c682: 75 70
                adc misc250,y                ; c684: 79 ff 71
                tya                          ; c687: 98
                adc misc259,y                ; c688: 79 20 74
                adc arr65,x                  ; c68b: 75 8d
                jsr misc282                  ; c68d: 20 6b 7e

                hex 6b                       ; c690

                sta arr48,x                  ; c691: 95 62

                hex ff 87                    ; c693

                adc ram51                    ; c695: 65 61
                jsr misc200                  ; c697: 20 a4 66
                ror $8c6d,x                  ; c69a: 7e 6d 8c
                and (arr105,x)               ; c69d: 21 ff

                hex 3a 7b                    ; c69f

                stx misc279                  ; c6a1: 8e 8c 7b
                stx $892d                    ; c6a4: 8e 2d 89

                hex 3a                       ; c6a7

                sta misc259                  ; c6a8: 8d 20 74
                stx ram57                    ; c6ab: 86 6b
                ror $ff6c,x                  ; c6ad: 7e 6c ff

                hex 63                       ; c6b0

                and misc69                   ; c6b1: 2d 73 3f
                jsr misc38                   ; c6b4: 20 63 2d

                hex 73 3f ff 8b 6f 6b        ; c6b7

                adc misc179,y                ; c6bd: 79 20 62
                stx arr57                    ; c6c0: 86 74
                adc (arr70,x)                ; c6c2: 61 97
                jsr misc200                  ; c6c4: 20 a4 66
                ror $ff6c,x                  ; c6c7: 7e 6c ff
                cpy #$0d                     ; c6ca: c0 0d
                ror a                        ; c6cc: 6a
                sty misc179                  ; c6cd: 8c 20 62
                stx arr57                    ; c6d0: 86 74
                adc (arr65,x)                ; c6d2: 61 8d
                jsr misc282                  ; c6d4: 20 6b 7e
                jmp (misc68)                 ; c6d7: 6c 65 3f

                hex ff                       ; c6da

                sta $8c65,x                  ; c6db: 9d 65 8c
                tya                          ; c6de: 98

                hex 89                       ; c6df

                jsr misc222                  ; c6e0: 20 a4 6c

                hex ff 64 82                 ; c6e3

                adc (ram90,x)                ; c6e6: 61 a1

                hex 6b                       ; c6e8

                ror misc230,x                ; c6e9: 7e 6b 6f
                and (arr105,x)               ; c6ec: 21 ff
                ror $a489                    ; c6ee: 6e 89 a4
                adc misc164,y                ; c6f1: 79 20 60

                hex 72                       ; c6f4

                ror $ff6c,x                  ; c6f5: 7e 6c ff
                ldy arr19                    ; c6f8: a4 2d

                hex 6f                       ; c6fa

                sta misc273                  ; c6fb: 8d 20 78
                adc #$6b                     ; c6fe: 69 6b

                hex 6f                       ; c700

                adc (arr14,x)                ; c701: 61 20

                hex 73                       ; c703

                ror arr61                    ; c704: 66 79
                ora misc223                  ; c706: 0d 65 6d
                stx arr56,y                  ; c709: 96 73
                sei                          ; c70b: 78
                jsr sub101                   ; c70c: 20 a6 96

                hex 67                       ; c70f

                rts                          ; c710: 60
                stx arr76,y                  ; c711: 96 ad
                jmp ($9661)                  ; c713: 6c 61 96
                bvs $c6a5                    ; c716: 70 8d
                ora misc122                  ; c718: 0d 4f 4e
                adc arr14,x                  ; c71b: 75 20

                hex 6b 72 67                 ; c71d

                lda (arr51,x)                ; c720: a1 6a
                adc (arr105,x)               ; c722: 61 ff
                adc #$78                     ; c724: 69 78
                jsr misc223                  ; c726: 20 65 6d
                stx arr56,y                  ; c729: 96 73
                adc arr61,x                  ; c72b: 75 79
                ora dat71                    ; c72d: 0d 22 c2

                hex 22                       ; c730

                sei                          ; c731: 78
                jsr misc42                   ; c732: 20 a4 2d

                hex 6f 97                    ; c735

                ora misc209                  ; c737: 0d 78 69
                stx arr55,y                  ; c73a: 96 72
                jsr misc281                  ; c73c: 20 61 7e
                jmp (misc185)                ; c73f: 6c ff 62
                stx arr57                    ; c742: 86 74
                adc (arr65,x)                ; c744: 61 8d
                jsr $9d79                    ; c746: 20 79 9d
                sta (ram66,x)                ; c749: 81 7e
                jmp (misc285)                ; c74b: 6c ff 7e
                lda (arr14,x)                ; c74e: a1 20

                hex 62                       ; c750

                ror misc255,x                ; c751: 7e 89 72
                jsr misc281                  ; c754: 20 61 7e
                adc dat165                   ; c757: 6d 8c ff
                jmp (misc266)                ; c75a: 6c a4 75
                jsr misc260                  ; c75d: 20 64 74

                hex 67 74 87                 ; c760

                adc arr14,x                  ; c763: 75 20

                hex 74                       ; c765

                stx ram75                    ; c766: 86 89

                hex 72                       ; c768

                ora dat9                     ; c769: 0d 61 88
                ldy ram57                    ; c76c: a4 6b
                sta arr48,x                  ; c76e: 95 62
                and (arr105,x)               ; c770: 21 ff
                adc ram72                    ; c772: 65 86
                lda (arr60,x)                ; c774: a1 78
                jsr sub99                    ; c776: 20 70 95

                hex 62 6b 97                 ; c779

                jsr misc178                  ; c77c: 20 85 61
                sei                          ; c77f: 78
                ldy arr8                     ; c780: a4 0d
                jmp (misc44)                 ; c782: 6c af 2d
                adc (arr14),y                ; c785: 71 20

                hex 6b 9b 73                 ; c787

                jsr $8ca9                    ; c78a: 20 a9 8c
                ror arr69                    ; c78d: 66 95

                hex 62                       ; c78f

                ora $a96c                    ; c790: 0d 6c a9

                hex 72                       ; c793

                adc arr14,x                  ; c794: 75 20

                hex 97                       ; c796

                sty cod40                    ; c797: 8c a6 87

                hex 97                       ; c79a

                jsr misc196                  ; c79b: 20 66 66
                ror $ff6c,x                  ; c79e: 7e 6c ff
                adc ram72                    ; c7a1: 65 86
                lda (arr60,x)                ; c7a3: a1 78
                jsr sub99                    ; c7a5: 20 70 95

                hex 62 6b 97                 ; c7a8

                jsr misc168                  ; c7ab: 20 7b 60
                sty misc176                  ; c7ae: 8c 72 61
                ldy ram58                    ; c7b1: a4 6c

                hex a7                       ; c7b3

                sta arr48,x                  ; c7b4: 95 62
                ror ram61                    ; c7b6: 66 75
                jsr misc193                  ; c7b8: 20 65 65
                stx arr57                    ; c7bb: 86 74
                adc (ram71,x)                ; c7bd: 61 85

                hex 62                       ; c7bf

                adc arr8,x                   ; c7c0: 75 0d
                ror arr65                    ; c7c2: 66 8d
                jsr misc203                  ; c7c4: 20 71 68

                hex 72                       ; c7c7

                jsr $a167                    ; c7c8: 20 67 a1
                ror a                        ; c7cb: 6a
                adc (arr105,x)               ; c7cc: 61 ff

                hex 6f                       ; c7ce

                adc (ram73,x)                ; c7cf: 61 87
                sta arr50,x                  ; c7d1: 95 67

                hex 97                       ; c7d3

                jsr misc207                  ; c7d4: 20 6c 69

                hex 6b                       ; c7d7

                jsr $8b85                    ; c7d8: 20 85 8b
                stx arr55,y                  ; c7db: 96 72
                adc (ram66,x)                ; c7dd: 61 7e
                jmp ($8780)                  ; c7df: 6c 80 87
                sta misc213                  ; c7e2: 8d 20 6b

                hex 74                       ; c7e5

                adc (ram71,x)                ; c7e6: 61 85

                hex 62                       ; c7e8

                adc arr14,x                  ; c7e9: 75 20
                adc #$69                     ; c7eb: 69 69
                txa                          ; c7ed: 8a

                hex 97                       ; c7ee

                pla                          ; c7ef: 68

                hex 72                       ; c7f0

                ora $a167                    ; c7f1: 0d 67 a1
                ror a                        ; c7f4: 6a
                adc (arr105,x)               ; c7f5: 61 ff
                ror arr73                    ; c7f7: 66 a8
                sty misc9                    ; c7f9: 8c 79 20
                ror misc192                  ; c7fc: 6e 62 65
                adc (arr8,x)                 ; c7ff: 61 0d
                adc misc199                  ; c801: 6d 96 66
                sta arr50,x                  ; c804: 95 67

                hex 72                       ; c806

                ror ram61                    ; c807: 66 75
                ora misc265                  ; c809: 0d 74 75

                hex 9b 73 82                 ; c80c

                jsr misc220                  ; c80f: 20 6c 6c
                sta (arr55,x)                ; c812: 81 72

                hex 67                       ; c814

                lda (arr51,x)                ; c815: a1 6a
                adc (arr105,x)               ; c817: 61 ff
                adc misc214                  ; c819: 6d 61 6b
                sty misc198                  ; c81c: 8c 72 66
                adc arr14,x                  ; c81f: 75 20

                hex 7b                       ; c821

                rts                          ; c822: 60
                sty misc176                  ; c823: 8c 72 61
                ldy ram58                    ; c826: a4 6c
                ora dat4                     ; c828: 0d 61 86
                adc (ram72,x)                ; c82b: 61 86
                jsr misc261                  ; c82d: 20 6b 74
                adc (ram71,x)                ; c830: 61 85

                hex 62                       ; c832

                adc arr14,x                  ; c833: 75 20
                ror arr65                    ; c835: 66 8d
                adc (ram55),y                ; c837: 71 68

                hex 72                       ; c839

                ora $a167                    ; c83a: 0d 67 a1
                ror a                        ; c83d: 6a
                adc (arr105,x)               ; c83e: 61 ff
                ror arr73                    ; c840: 66 a8
                sty misc13                   ; c842: 8c 97 20
                ror a                        ; c845: 6a

                hex 63                       ; c846

                ror $8c6d,x                  ; c847: 7e 6d 8c
                ora misc175                  ; c84a: 0d 6f 61
                sta misc11,x                 ; c84d: 9d 8c 20
                adc arr64                    ; c850: 65 8c
                pla                          ; c852: 68
                adc (ram61,x)                ; c853: 61 75
                ora dat11                    ; c855: 0d 66 8d
                jsr misc203                  ; c858: 20 71 68

                hex 72                       ; c85b

                jsr $a167                    ; c85c: 20 67 a1
                ror a                        ; c85f: 6a
                adc (arr105,x)               ; c860: 61 ff

                hex 82                       ; c862

                sei                          ; c863: 78

                hex 9b 73                    ; c864

                sta misc191                  ; c866: 8d 20 65
                sty misc187                  ; c869: 8c 97 63
                dey                          ; c86c: 88
                sei                          ; c86d: 78
                adc arr8,x                   ; c86e: 75 0d

                hex 72                       ; c870

                ror ram57                    ; c871: 66 6b

                hex 72                       ; c873

                jsr misc281                  ; c874: 20 61 7e
                jmp (dat2)                   ; c877: 6c 0d 80

                hex 9e                       ; c87a

                adc ram57                    ; c87b: 65 6b
                adc (arr14,x)                ; c87d: 61 20
                adc #$73                     ; c87f: 69 73

                hex 82                       ; c881

                jsr misc174                  ; c882: 20 65 61
                pla                          ; c885: 68
                adc (arr14),y                ; c886: 71 20

                hex 6b                       ; c888

                ror $ff6c,x                  ; c889: 7e 6c ff

                hex 64 64                    ; c88c

                ror arr57                    ; c88e: 66 74
                jsr misc221                  ; c890: 20 7f 6c
                sta misc188                  ; c893: 8d 20 64
                adc ram57                    ; c896: 65 6b

                hex 83                       ; c898

                jmp (ram224)                 ; c899: 6c 61 0d

                hex 7a                       ; c89c

                ldy ram58                    ; c89d: a4 6c
                ora $9662                    ; c89f: 0d 62 96
                adc ram73                    ; c8a2: 65 87
                jsr misc261                  ; c8a4: 20 6b 74
                adc (ram71,x)                ; c8a7: 61 85

                hex 62                       ; c8a9

                adc arr14,x                  ; c8aa: 75 20
                ror arr65                    ; c8ac: 66 8d
                jsr misc203                  ; c8ae: 20 71 68

                hex 72 67                    ; c8b1

                lda (arr51,x)                ; c8b3: a1 6a
                adc (arr105,x)               ; c8b5: 61 ff
                rts                          ; c8b7: 60

                hex 6f                       ; c8b8

                ror misc8,x                  ; c8b9: 7e 78 20
                adc ram51                    ; c8bc: 65 61

                hex 72                       ; c8be

                sty misc13                   ; c8bf: 8c 97 20
                adc arr73,x                  ; c8c2: 75 a8
                stx arr55,y                  ; c8c4: 96 72
                adc (ram66,x)                ; c8c6: 61 7e
                jmp (misc182)                ; c8c8: 6c 78 62

                hex 87                       ; c8cb

                adc (arr70),y                ; c8cc: 71 97
                jsr $9760                    ; c8ce: 20 60 97

                hex 87                       ; c8d1

                ror $8c6d,x                  ; c8d2: 7e 6d 8c
                adc ram72                    ; c8d5: 65 86
                ora $8780                    ; c8d7: 0d 80 87
                adc arr14,x                  ; c8da: 75 20
                rts                          ; c8dc: 60

                hex 6f                       ; c8dd

                ror misc12,x                 ; c8de: 7e 8d 20
                adc (ram53),y                ; c8e1: 71 65

                hex 8b 74                    ; c8e3

                adc (arr14,x)                ; c8e5: 61 20
                sta arr48                    ; c8e7: 85 62
                adc arr105,x                 ; c8e9: 75 ff
                ror misc277                  ; c8eb: 6e 78 7a
                sei                          ; c8ee: 78
                jsr sub24                    ; c8ef: 20 62 86

                hex 74                       ; c8f2

                adc (arr61,x)                ; c8f3: 61 79
                jsr $9871                    ; c8f5: 20 71 98
                sei                          ; c8f8: 78
                jsr misc183                  ; c8f9: 20 85 62
                adc arr57,x                  ; c8fc: 75 74

                hex 87                       ; c8fe

                ror misc230,x                ; c8ff: 7e 6b 6f

                hex ff 62                    ; c902

                stx arr57                    ; c904: 86 74
                adc (arr14,x)                ; c906: 61 20

                hex 64 8b 87 ff 74           ; c908

                adc arr57                    ; c90d: 65 74
                adc arr14                    ; c90f: 65 20
                sta ram51                    ; c911: 85 61
                jsr $9668                    ; c913: 20 68 96
                adc arr70                    ; c916: 65 97
                jsr misc284                  ; c918: 20 a4 7e

                hex 6b 6f                    ; c91b

                ora misc195                  ; c91d: 0d 85 65
                stx arr52,y                  ; c920: 96 6f
                jsr misc222                  ; c922: 20 a4 6c

                hex 77                       ; c925

                and (arr105,x)               ; c926: 21 ff
                rts                          ; c928: 60
                ror misc10,x                 ; c929: 7e 87 20
                sta arr50                    ; c92c: 85 67
                rts                          ; c92e: 60

                hex 87                       ; c92f

                ror $8c6d,x                  ; c930: 7e 6d 8c

                hex 77                       ; c933

                ora dat11                    ; c934: 0d 66 8d
                jsr misc257                  ; c937: 20 64 73
                ror a                        ; c93a: 6a

                hex 74                       ; c93b

                adc (ram93,x)                ; c93c: 61 a4
                jsr $a167                    ; c93e: 20 67 a1
                ror a                        ; c941: 6a
                adc (arr15,x)                ; c942: 61 21

                hex ff 62                    ; c944

                stx arr57                    ; c946: 86 74
                adc (arr61,x)                ; c948: 61 79
                jsr $8183                    ; c94a: 20 83 81
                ror dat12,x                  ; c94d: 7e 6b 95

                hex 62 ff                    ; c950

                adc (ram83),y                ; c952: 71 98
                sei                          ; c954: 78
                jsr misc248                  ; c955: 20 6b 71

                hex 82                       ; c958

                sty misc7                    ; c959: 8c 75 20
                adc #$6f                     ; c95c: 69 6f

                hex 63 72 67                 ; c95e

                lda (arr51,x)                ; c961: a1 6a
                adc (arr105,x)               ; c963: 61 ff

                hex 8b 6f 6b                 ; c965

                adc misc259,y                ; c968: 79 20 74
                adc arr65,x                  ; c96b: 75 8d
                jsr misc254                  ; c96d: 20 6b 72
                adc (ram74,x)                ; c970: 61 88
                jsr misc208                  ; c972: 20 73 69
                txa                          ; c975: 8a
                ora misc217                  ; c976: 0d a4 6b

                hex 6f                       ; c979

                adc arr105                   ; c97a: 65 ff
                rts                          ; c97c: 60

                hex 74 6f                    ; c97d

                adc $c00d,y                  ; c97f: 79 0d c0
                ora dat10                    ; c982: 0d 6a 8c
                jsr misc222                  ; c985: 20 a4 6c

                hex 77 ff                    ; c988

                cpy #$0d                     ; c98a: c0 0d
                ror a                        ; c98c: 6a
                sty misc280                  ; c98d: 8c 20 7e

                hex 6f                       ; c990

                jsr $a785                    ; c991: 20 85 a7
                lda (ram57,x)                ; c994: a1 6b

                hex 72                       ; c996

                jsr $a167                    ; c997: 20 67 a1
                ror a                        ; c99a: 6a
                adc (arr105,x)               ; c99b: 61 ff
                adc misc272                  ; c99d: 6d 61 77
                sty $9697                    ; c9a0: 8c 97 96
                ldy ram225                   ; c9a3: ac 79 0d
                cmp (ram29,x)                ; c9a6: c1 2f

                hex ff                       ; c9a8

                ora dat127                   ; c9a9: 0d 0d e5
                cpy #$2f                     ; c9ac: c0 2f
                cmp (arr14,x)                ; c9ae: c1 20
                ldy ram58                    ; c9b0: a4 6c

                hex 77 ff                    ; c9b2

                cpy #$2f                     ; c9b4: c0 2f

                hex ff                       ; c9b6

                sbc ram112                   ; c9b7: e5 c0

                hex 2f                       ; c9b9

                cmp (arr14,x)                ; c9ba: c1 20
                adc misc185,y                ; c9bc: 79 ff 62
                ror misc255,x                ; c9bf: 7e 89 72
                jsr misc15                   ; c9c2: 20 c0 20
                adc arr53,x                  ; c9c5: 75 70
                sta (ram61,x)                ; c9c7: 81 75
                ora dat5                     ; c9c9: 0d 74 87
                ror $ff6c,x                  ; c9cc: 7e 6c ff
                cpy #$21                     ; c9cf: c0 21

                hex ff                       ; c9d1

                ora ram227                   ; c9d2: 0d c0 0d
                ror a                        ; c9d5: 6a
                sty misc188                  ; c9d6: 8c 20 64
                txs                          ; c9d9: 9a
                sty cod264                   ; c9da: 8c 66 a4
                jmp (misc68)                 ; c9dd: 6c 65 3f

                hex ff                       ; c9e0

                adc (ram66,x)                ; c9e1: 61 7e
                jsr misc232                  ; c9e3: 20 8b 6f

                hex 6b                       ; c9e6

                adc $c00d,y                  ; c9e7: 79 0d c0
                ora dat10                    ; c9ea: 0d 6a 8c
                sei                          ; c9ed: 78
                jsr sub129                   ; c9ee: 20 6b 9d
                lda arr48                    ; c9f1: a5 62

                hex 87                       ; c9f3

                jsr misc184                  ; c9f4: 20 a5 62
                ror a                        ; c9f7: 6a
                sta misc212                  ; c9f8: 8d 0d 6b

                hex 72                       ; c9fb

                adc (ram66,x)                ; c9fc: 61 7e
                jmp (misc227)                ; c9fe: 6c ff 6d
                adc (arr59,x)                ; ca01: 61 77
                sty $9697                    ; ca03: 8c 97 96
                ldy misc12                   ; ca06: ac 8d 20
                adc (ram75,x)                ; ca09: 61 89

                hex 72 67                    ; ca0b

                lda (arr51,x)                ; ca0d: a1 6a
                adc (arr105,x)               ; ca0f: 61 ff

                hex 62                       ; ca11

                stx arr57                    ; ca12: 86 74
                stx arr55,y                  ; ca14: 96 72
                jsr misc215                  ; ca16: 20 7d 6b
                adc (arr14,x)                ; ca19: 61 20

                hex 7a                       ; ca1b

                adc arr53,x                  ; ca1c: 75 70
                sta misc170                  ; ca1e: 8d 0d 61

                hex 89 72 67                 ; ca21

                lda (arr51,x)                ; ca24: a1 6a
                adc (arr105,x)               ; ca26: 61 ff

                hex 62                       ; ca28

                stx arr57                    ; ca29: 86 74
                adc (arr65,x)                ; ca2b: 61 8d
                jsr $a371                    ; ca2d: 20 71 a3
                pla                          ; ca30: 68
                ror misc194,x                ; ca31: 7e 6c 65

                hex 3f ff                    ; ca34

                ora (arr5,x)                 ; ca36: 01 06
                brk                          ; ca38: 00

                hex ff 22 04                 ; ca39

                brk                          ; ca3c: 00

                hex ff                       ; ca3d

                brk                          ; ca3e: 00
                php                          ; ca3f: 08
                cpy #$ff                     ; ca40: c0 ff
                ora (arr6,x)                 ; ca42: 01 08
                cpy #$ff                     ; ca44: c0 ff
dat90           asl a                        ; ca46: 0a

                hex 12                       ; ca47

                asl a                        ; ca48: 0a
                asl a                        ; ca49: 0a
                bpl $ca8c                    ; ca4a: 10 40
                jsr misc70                   ; ca4c: 20 40 40
                jsr misc166                  ; ca4f: 20 5c 60

                hex 5c                       ; ca52

                cli                          ; ca53: 58
dat91           dex                          ; ca54: ca
                dex                          ; ca55: ca
                dex                          ; ca56: ca
                dex                          ; ca57: ca

                hex 04                       ; ca58

                ora arr8                     ; ca59: 05 0d

                hex 03                       ; ca5b

                bpl cod425                   ; ca5c: 10 10
                bpl cod426                   ; ca5e: 10 10

                hex 04                       ; ca60

                ora ram8                     ; ca61: 05 10
                bpl cod427                   ; ca63: 10 44
                lsr a                        ; ca65: 4a
                eor (ram43),y                ; ca66: 51 57

                hex 67                       ; ca68

dat92           ora (arr101,x)               ; ca69: 01 f4
                lda ram65                    ; ca6b: a5 7d

                hex fa                       ; ca6d
cod425          hex 22 32                    ; ca6e
cod426          hex 42 77                    ; ca70

                cpy cod504                   ; ca72: cc 03 d7
                cmp dat116,y                 ; ca75: d9 ca d9

                hex da da da da da 23 db 42  ; ca78

                brk                          ; ca80: 00
                and (ram119,x)               ; ca81: 21 cc
                asl arr41                    ; ca83: 06 52
                eor (ram42,x)                ; ca85: 41 4d
                jsr misc106                  ; ca87: 20 4f 4b
                brk                          ; ca8a: 00          Select RAM test data $00, $55, $AA
dat93           eor arr74,x                  ; ca8b: 55 aa       Select RAM test data $00, $55, $AA
dat94           brk                          ; ca8d: 00

                hex 13                       ; ca8e

                rol ram107                   ; ca8f: 26 b7

                hex bb                       ; ca91

                ldx dat108,y                 ; ca92: be c2 cd
                cmp $eee4,y                  ; ca95: d9 e4 ee

                hex f2                       ; ca98

                sed                          ; ca99: f8
                sbc arr197,x                 ; ca9a: fd 03 09
                ora #%00001010               ; ca9d: 09 0a
                bpl cod428                   ; ca9f: 10 15

sub258          hex 1a                       ; caa1

dat95           bvs $cb14                    ; caa2: 70 70
                bvs cod426                   ; caa4: 70 ca
                dex                          ; caa6: ca
                dex                          ; caa7: ca
                dex                          ; caa8: ca
cod427          dex                          ; caa9: ca
                dex                          ; caaa: ca
                dex                          ; caab: ca
                dex                          ; caac: ca
                dex                          ; caad: ca
                dex                          ; caae: ca
                dex                          ; caaf: ca

                hex cb cb cb cb cb cb        ; cab0
cod428          hex cb 64 8b 87              ; cab6

                ora misc177                  ; caba: 0d 79 61
sub259          ora misc173                  ; cabd: 0d 61 61

                hex 63                       ; cac0

                ora misc75                   ; cac1: 0d 47 41
                eor misc5                    ; cac4: 4d 45 20

                hex 42                       ; cac7

                eor (arr42,x)                ; cac8: 41 53
                eor #%01000011               ; caca: 49 43
                ora $8765                    ; cacc: 0d 65 87
                ror arr68                    ; cacf: 66 94

                hex 89                       ; cad1

                and misc6                    ; cad2: 2d 6f 20
                tax                          ; cad5: aa
                and ram226                   ; cad6: 2d a5 0d

                hex 7f                       ; cad9

                sty arr19,x                  ; cada: 94 2d
                sta misc201,x                ; cadc: 9d 96 67
                jsr misc43                   ; cadf: 20 aa 2d
                lda arr8                     ; cae2: a5 0d
                sta (ram82,x)                ; cae4: 81 96
                adc $9d2d                    ; cae6: 6d 2d 9d
                jsr misc43                   ; cae9: 20 aa 2d
                lda arr8                     ; caec: a5 0d
                eor arr37                    ; caee: 45 4e

                hex 44                       ; caf0

                ora misc94                   ; caf1: 0d 48 45
                jmp misc127                  ; caf4: 4c 4c 4f
                ora misc275                  ; caf7: 0d 64 79
                sta arr48                    ; cafa: 85 62
                ora $8c69                    ; cafc: 0d 69 8c
                adc arr53,x                  ; caff: 75 70
                adc misc205,y                ; cb01: 79 0d 69
                sty $8ca6                    ; cb04: 8c a6 8c
                adc arr200,y                 ; cb07: 79 0d 0d

                hex 42                       ; cb0a

                eor (arr42,x)                ; cb0b: 41 53
                eor #%01000011               ; cb0d: 49 43
                ora misc73                   ; cb0f: 0d 43 41
                jmp ram221                   ; cb12: 4c 2e 0d
                eor misc145                  ; cb15: 4d 55 53
                rol misc113                  ; cb18: 2e 0d 4d
                eor arr42                    ; cb1b: 45 53
                rol misc190                  ; cb1d: 2e 0d 65

                hex 67 6b                    ; cb20

                sty arr14,x                  ; cb22: 94 20
                tax                          ; cb24: aa
                and ram226                   ; cb25: 2d a5 0d
dat96           dey                          ; cb28: 88
                stx $ba92                    ; cb29: 8e 92 ba
                ora arr84,x                  ; cb2c: 15 c6

                hex cb cb                    ; cb2e

                inc ram130                   ; cb30: e6 e6

                hex eb                       ; cb32

                brk                          ; cb33: 00

                hex 07 0b 22                 ; cb34

                tya                          ; cb37: 98
                rol misc60                   ; cb38: 2e 3a 3a

                hex 3f 3f                    ; cb3b

                pha                          ; cb3d: 48
                pha                          ; cb3e: 48
                pha                          ; cb3f: 48

                hex 4b 92 92                 ; cb40

                cld                          ; cb43: d8

                hex 9b 9f                    ; cb44

                cpx ram96                    ; cb46: e4 a7

                hex af                       ; cb48

                ldy arr78,x                  ; cb49: b4 b9
                lda dat70,y                  ; cb4b: b9 be be
                ldx dat117,y                 ; cb4e: be be da
                cpx dat124                   ; cb51: ec e6 dd
                ldx $fdfd,y                  ; cb54: be fd fd
                lda (arr86,x)                ; cb57: a1 cb

                hex cb cb cb                 ; cb59

                cpy dat97                    ; cb5c: cc cb cb

                hex cb cb cb cb              ; cb5f

                cpy $cccc                    ; cb63: cc cc cc
                cpy dat100                   ; cb66: cc cb cc
                cpy $cccc                    ; cb69: cc cc cc
                cpy $cccc                    ; cb6c: cc cc cc
                cpy $cccc                    ; cb6f: cc cc cc
                cpy dat100                   ; cb72: cc cb cc
                cpy dat100                   ; cb75: cc cb cc
                cpy $cccc                    ; cb78: cc cc cc
                cpy $cccc                    ; cb7b: cc cc cc
                cpy $cccc                    ; cb7e: cc cc cc
                cpy $cccc                    ; cb81: cc cc cc
                cpy $cccc                    ; cb84: cc cc cc

                hex cb                       ; cb87

                ora #%00000000               ; cb88: 09 00
                php                          ; cb8a: 08
                ora (arr9,x)                 ; cb8b: 01 0f
                brk                          ; cb8d: 00
                asl arr198,x                 ; cb8e: 1e 00 0a
                ora (arr5,x)                 ; cb91: 01 06
                brk                          ; cb93: 00
                brk                          ; cb94: 00
                asl arr1                     ; cb95: 06 00
                ora (arr10,x)                ; cb97: 01 14
                brk                          ; cb99: 00
                asl arr1                     ; cb9a: 06 00

                hex 0b                       ; cb9c

                ora arr5                     ; cb9d: 05 06

                hex ff 0f                    ; cb9f

                asl arr1                     ; cba1: 06 00
                asl arr4                     ; cba3: 06 05

                hex 03                       ; cba5

                bpl $cbab                    ; cba6: 10 03

                hex 13                       ; cba8

                brk                          ; cba9: 00
                ora arr168                   ; cbaa: 0d 00 06
                brk                          ; cbad: 00

                hex 04                       ; cbae

                asl arr1                     ; cbaf: 06 00

                hex 2f                       ; cbb1

                ora (arr1),y                 ; cbb2: 11 00
                asl arr1                     ; cbb4: 06 00
                asl_abs arr5                 ; cbb6: 0e 06 00

                hex 0f                       ; cbb9

                asl arr1                     ; cbba: 06 00
                ora ram2                     ; cbbc: 05 04
                brk                          ; cbbe: 00
                asl arr1                     ; cbbf: 06 00

                hex 1a 17                    ; cbc1

                brk                          ; cbc3: 00

                hex ff                       ; cbc4

                asl arr5                     ; cbc5: 06 06
                brk                          ; cbc7: 00
                bpl cod429                   ; cbc8: 10 20
                brk                          ; cbca: 00
dat97           asl arr1                     ; cbcb: 06 00
                php                          ; cbcd: 08
                ora ram1                     ; cbce: 05 03

                hex 0c 03                    ; cbd0

                ora arr1,x                   ; cbd2: 15 00

                hex 0c                       ; cbd4

                brk                          ; cbd5: 00

                hex 12                       ; cbd6

                brk                          ; cbd7: 00

                hex 0c                       ; cbd8

                brk                          ; cbd9: 00
                asl arr1                     ; cbda: 06 00

                hex 04                       ; cbdc

                asl arr1                     ; cbdd: 06 00

                hex 0c                       ; cbdf

                ora ram3                     ; cbe0: 05 07
                ora #%00000000               ; cbe2: 09 00

                hex 12                       ; cbe4

                brk                          ; cbe5: 00

                hex 0c                       ; cbe6

                brk                          ; cbe7: 00
                asl arr1                     ; cbe8: 06 00
cod429          php                          ; cbea: 08

                hex 0c                       ; cbeb

                brk                          ; cbec: 00
dat98           asl arr1                     ; cbed: 06 00
                ora #%00000110               ; cbef: 09 06
                brk                          ; cbf1: 00
                ora arr13,y                  ; cbf2: 19 1f 00
                asl arr1                     ; cbf5: 06 00
                bmi $cbff                    ; cbf7: 30 06
                brk                          ; cbf9: 00
                asl a                        ; cbfa: 0a
                asl arr1                     ; cbfb: 06 00
                rol ram149                   ; cbfd: 2e ff 01

                hex 0c                       ; cc00

                brk                          ; cc01: 00
                asl arr1                     ; cc02: 06 00

                hex 02 ff                    ; cc04

                asl a                        ; cc06: 0a
                asl ram144                   ; cc07: 0e 00 01
                brk                          ; cc0a: 00

                hex 1c                       ; cc0b

                brk                          ; cc0c: 00
                asl ram218                   ; cc0d: 0e 02 08
                ora arr9                     ; cc10: 05 0f
                brk                          ; cc12: 00

                hex 02                       ; cc13

                brk                          ; cc14: 00
                ora #%00000000               ; cc15: 09 00
                asl a                        ; cc17: 0a

                hex 03                       ; cc18

                php                          ; cc19: 08
                ora (arr9,x)                 ; cc1a: 01 0f
                brk                          ; cc1c: 00
                asl arr1                     ; cc1d: 06 00
                ora ram209                   ; cc1f: 0d ff 05
                php                          ; cc22: 08

                hex 04                       ; cc23

                php                          ; cc24: 08

                hex 07                       ; cc25

                ora arr203,x                 ; cc26: 1d 00 0f
                brk                          ; cc29: 00

                hex 0b                       ; cc2a

                brk                          ; cc2b: 00

                hex ff 04                    ; cc2c

                php                          ; cc2e: 08
                ora #%00001000               ; cc2f: 09 08
                asl arr17                    ; cc31: 06 25
                brk                          ; cc33: 00

                hex 0f                       ; cc34

                brk                          ; cc35: 00
                rol arr1                     ; cc36: 26 00

                hex ff 04 0c                 ; cc38

                brk                          ; cc3b: 00
                asl arr1                     ; cc3c: 06 00
                bit_abs arr5                 ; cc3e: 2c 06 00
                and arr135,y                 ; cc41: 39 05 03
                ora arr207,y                 ; cc44: 19 14 18
                brk                          ; cc47: 00
                asl arr1                     ; cc48: 06 00

                hex 04 0c                    ; cc4a

                brk                          ; cc4c: 00
                asl arr1                     ; cc4d: 06 00

                hex 3a                       ; cc4f

                ora ram1                     ; cc50: 05 03
                ora arr172,y                 ; cc52: 19 18 06
                brk                          ; cc55: 00

                hex 04                       ; cc56

                asl arr1                     ; cc57: 06 00

                hex 1b                       ; cc59

                ora arr4                     ; cc5a: 05 05
                and (ram8,x)                 ; cc5c: 21 10
                asl arr1                     ; cc5e: 06 00

                hex 02                       ; cc60

                asl arr1                     ; cc61: 06 00
                clc                          ; cc63: 18
                asl ram70                    ; cc64: 06 84
                and (ram1),y                 ; cc66: 31 03
                txs                          ; cc68: 9a

                hex 32                       ; cc69

                asl arr39                    ; cc6a: 06 50

                hex 33 03                    ; cc6c

                ldy arr174,x                 ; cc6e: bc 34 06
                brk                          ; cc71: 00

                hex 13 22                    ; cc72

                brk                          ; cc74: 00
                asl arr89                    ; cc75: 06 d0
                and arr5,x                   ; cc77: 35 06
                brk                          ; cc79: 00

                hex 27                       ; cc7a

                asl arr1                     ; cc7b: 06 00

                hex 12                       ; cc7d

                ora ram2                     ; cc7e: 05 04

                hex 1b                       ; cc80

                bpl +                        ; cc81: 10 23
                brk                          ; cc83: 00

                hex 23                       ; cc84

                brk                          ; cc85: 00

                hex 23                       ; cc86

                brk                          ; cc87: 00

                hex 23                       ; cc88

                brk                          ; cc89: 00
                asl arr1                     ; cc8a: 06 00
                plp                          ; cc8c: 28
                bit arr1                     ; cc8d: 24 00
                asl arr1                     ; cc8f: 06 00
                rol a                        ; cc91: 2a
                asl arr1                     ; cc92: 06 00

                hex 3b                       ; cc94

                ora ram1                     ; cc95: 05 03

                hex 0c                       ; cc97

                ora (ram15,x)                ; cc98: 01 1a

                hex 1a 0c                    ; cc9a

                brk                          ; cc9c: 00

                hex ff                       ; cc9d

                rol a                        ; cc9e: 2a
                asl arr1                     ; cc9f: 06 00
                ora (arr5),y                 ; cca1: 11 06
                brk                          ; cca3: 00

                hex 07 12                    ; cca4

+               brk                          ; cca6: 00
                asl arr1                     ; cca7: 06 00

                hex 1c                       ; cca9

                asl arr1                     ; ccaa: 06 00

                hex 07 ff 13                 ; ccac

                asl arr1                     ; ccaf: 06 00
                ora arr208,x                 ; ccb1: 1d ff 1a
                asl arr1                     ; ccb4: 06 00
                and #%11111111               ; ccb6: 29 ff
                ora arr5,y                   ; ccb8: 19 06 00

                hex 04 12                    ; ccbb

                brk                          ; ccbd: 00

                hex 0c                       ; ccbe

                brk                          ; ccbf: 00
                asl arr1                     ; ccc0: 06 00

                hex 03                       ; ccc2

                asl arr53                    ; ccc3: 06 70
                rol arr13,x                  ; ccc5: 36 1f
                brk                          ; ccc7: 00

dat99           hex 03                       ; ccc8

                brk                          ; ccc9: 00

                hex 37                       ; ccca

dat100          asl arr1                     ; cccb: 06 00
                brk                          ; cccd: 00

                hex 1f                       ; ccce

                brk                          ; cccf: 00
                asl arr1                     ; ccd0: 06 00
                sec                          ; ccd2: 38

                hex 1f                       ; ccd3

                brk                          ; ccd4: 00

                hex ff                       ; ccd5

                plp                          ; ccd6: 28
                brk                          ; ccd7: 00

                hex ff                       ; ccd8

                and #%00000110               ; ccd9: 29 06
                brk                          ; ccdb: 00

                hex 14                       ; ccdc

                asl arr1                     ; ccdd: 06 00
                ora arr4,x                   ; ccdf: 15 05

                hex 03 0c                    ; cce1

                ora (ram15,x)                ; cce3: 01 1a

                hex 2b                       ; cce5

                asl arr1                     ; cce6: 06 00

                hex 04                       ; cce8

                asl arr1                     ; cce9: 06 00

                hex 2b                       ; cceb

                asl arr1                     ; ccec: 06 00

                hex 13                       ; ccee

                asl arr1                     ; ccef: 06 00
                and_abs arr5                 ; ccf1: 2d 06 00

                hex 13                       ; ccf4

                asl arr1                     ; ccf5: 06 00

                hex 17                       ; ccf7

                asl arr1                     ; ccf8: 06 00
                ora ram23                    ; ccfa: 05 27
                brk                          ; ccfc: 00

                hex 0c                       ; ccfd

                brk                          ; ccfe: 00
                asl arr1                     ; ccff: 06 00
dat101          asl arr105,x                 ; cd01: 16 ff
cod430          asl a                        ; cd03: 0a

                hex 0b                       ; cd04

dat102          brk                          ; cd05: 00
                brk                          ; cd06: 00
                brk                          ; cd07: 00
                brk                          ; cd08: 00
                brk                          ; cd09: 00
                brk                          ; cd0a: 00

                hex 0b                       ; cd0b

                bit misc35                   ; cd0c: 2c 2c 2c
                bit_abs arr1                 ; cd0f: 2c 00 00
                brk                          ; cd12: 00
                brk                          ; cd13: 00
                brk                          ; cd14: 00
                brk                          ; cd15: 00

dat103          hex 0c                       ; cd16

                ora ram229                   ; cd17: 0d 10 0e
dat104          brk                          ; cd1a: 00
                and $dedc,x                  ; cd1b: 3d dc de
                jsr sub260                   ; cd1e: 20 30 cd
                bvc cod430                   ; cd21: 50 e0
                ldy ram96                    ; cd23: a4 a7

                hex d4 d7                    ; cd25

                tax                          ; cd27: aa

                hex 1f c2                    ; cd28

                cmp $e4d9                    ; cd2a: cd d9 e4
                asl a                        ; cd2d: 0a
dat105          ora arr5                     ; cd2e: 05 06
sub260          brk                          ; cd30: 00
                brk                          ; cd31: 00
                ora arr4                     ; cd32: 05 05
                brk                          ; cd34: 00
                ora arr56                    ; cd35: 05 73
                brk                          ; cd37: 00
                brk                          ; cd38: 00
                brk                          ; cd39: 00
                brk                          ; cd3a: 00
                brk                          ; cd3b: 00

                hex cb                       ; cd3c

                dex                          ; cd3d: ca
                dex                          ; cd3e: ca
                dex                          ; cd3f: ca
                dex                          ; cd40: ca

                hex cb                       ; cd41

                brk                          ; cd42: 00

dat106          hex 12                       ; cd43

dat107          bit arr67                    ; cd44: 24 93
                cmp dat123                   ; cd46: cd 77 dc
                eor ram120                   ; cd49: 45 cd

                hex 5b cf                    ; cd4b

                cmp arr87,x                  ; cd4d: d5 ce
                ldy arr90                    ; cd4f: a4 d2
                sei                          ; cd51: 78

                hex cf                       ; cd52

                sed                          ; cd53: f8
                dec dat109                   ; cd54: ce 06 cf
                ora arr92,x                  ; cd57: 15 d5

                hex 97 db                    ; cd59

                lsr a                        ; cd5b: 4a

                hex d4 1f cf                 ; cd5c

                sed                          ; cd5f: f8
                dec dat111                   ; cd60: ce 18 cf
                inx                          ; cd63: e8
                bne cod431                   ; cd64: d0 2a
                bne $cd6f                    ; cd66: d0 07
                cmp (ram115),y               ; cd68: d1 c4

                hex cf                       ; cd6a

                and misc229                  ; cd6b: 2d cf 6e
                bne +                        ; cd6e: d0 10

                hex cf da                    ; cd70

                bne cod432                   ; cd72: d0 34
                inc arr8,x                   ; cd74: f6 0d

                hex fa                       ; cd76

                lsr ram137                   ; cd77: 46 f6

                hex 7a                       ; cd79

                inc arr9,x                   ; cd7a: f6 0f
                cmp (ram21),y                ; cd7c: d1 24
                cmp (ram101),y               ; cd7e: d1 b1

+               hex f4                       ; cd80

                inx                          ; cd81: e8
                dec dat112                   ; cd82: ce 0c d1

                hex 89                       ; cd85

                inc arr66,x                  ; cd86: f6 8e
                sbc dat159,y                 ; cd88: f9 af f9

                hex e2                       ; cd8b

                sbc dat113,y                 ; cd8c: f9 39 d1

                hex 23                       ; cd8f

cod431          cpx ram1                     ; cd90: e4 03
                cmp (arr47),y                ; cd92: d1 60
sub261          lda #0                       ; cd94: a9 00
                sta dmc_raw                  ; cd96: 8d 11 40
                lda #6                       ; cd99: a9 06
                sta ppu_mask                 ; cd9b: 8d 01 20
                jsr sub386                   ; cd9e: 20 5a ec
                jsr sub387                   ; cda1: 20 6f ec
                jmp cod640                   ; cda4: 4c 69 ec
                php                          ; cda7: 08
cod432          pha                          ; cda8: 48
                txa                          ; cda9: 8a
                pha                          ; cdaa: 48
                tya                          ; cdab: 98
                pha                          ; cdac: 48
                ldx #$0f                     ; cdad: a2 0f
-               lda arr1,x                   ; cdaf: b5 00
                pha                          ; cdb1: 48
                dex                          ; cdb2: ca
                bpl -                        ; cdb3: 10 fa
                lda ram8                     ; cdb5: a5 10
                and #%01111111               ; cdb7: 29 7f
                jsr sub388                   ; cdb9: 20 7a ec
                lda arr60                    ; cdbc: a5 78
                bne cod433                   ; cdbe: d0 09
                lda ram9                     ; cdc0: a5 11
dat108          ora #%00011110               ; cdc2: 09 1e
                sta ppu_mask                 ; cdc4: 8d 01 20
                sta ram9                     ; cdc7: 85 11
cod433          lda #0                       ; cdc9: a9 00
                sta oam_addr                 ; cdcb: 8d 03 20
                lda #2                       ; cdce: a9 02
                sta oam_dma                  ; cdd0: 8d 14 40
                ldx ram76                    ; cdd3: a6 8a
                lda dat92,x                  ; cdd5: bd 69 ca
                sta arr1                     ; cdd8: 85 00
                lda $ca73,x                  ; cdda: bd 73 ca
                sta arr2                     ; cddd: 85 01
                jsr sub399                   ; cddf: 20 43 ee
                lda #0                       ; cde2: a9 00
                sta ram76                    ; cde4: 85 8a
                sta ram164                   ; cde6: 8d 00 03
                sta arr131                   ; cde9: 8d 01 03
                lda ram63                    ; cdec: a5 7b
                beq +                        ; cdee: f0 03
                jmp cod1                     ; cdf0: 4c 00 80
+               lda arr33                    ; cdf3: a5 46
                beq +                        ; cdf5: f0 08
                jsr sub267                   ; cdf7: 20 48 cf
                beq +                        ; cdfa: f0 03
                jmp $c400                    ; cdfc: 4c 00 c4
+               inc ram35                    ; cdff: e6 3b
                lda arr40                    ; ce01: a5 51
                bne +                        ; ce03: d0 04
                lda #$0f                     ; ce05: a9 0f
                sta arr40                    ; ce07: 85 51
+               jsr sub1                     ; ce09: 20 03 80
                sta arr23                    ; ce0c: 85 37
                ldx ram62                    ; ce0e: a6 7a
                beq +                        ; ce10: f0 0a
                cmp #$54                     ; ce12: c9 54
                bne +                        ; ce14: d0 06
                jsr sub262                   ; ce16: 20 46 ce
                jmp cod434                   ; ce19: 4c 29 ce
+               cmp #3                       ; ce1c: c9 03
                beq cod434                   ; ce1e: f0 09
                jsr sub397                   ; ce20: 20 d2 ed
                jsr sub457                   ; ce23: 20 06 fc
                jsr sub263                   ; ce26: 20 6e ce
cod434          lda ppu_status               ; ce29: ad 02 20
                lda ram8                     ; ce2c: a5 10
                eor #%10000000               ; ce2e: 49 80
                jsr sub388                   ; ce30: 20 7a ec
                ldx #0                       ; ce33: a2 00
                stx ram62                    ; ce35: 86 7a
-               pla                          ; ce37: 68
                sta arr1,x                   ; ce38: 95 00
                inx                          ; ce3a: e8
                cpx #$10                     ; ce3b: e0 10
                bne -                        ; ce3d: d0 f8
                pla                          ; ce3f: 68
                tay                          ; ce40: a8
                pla                          ; ce41: 68
                tax                          ; ce42: aa
                pla                          ; ce43: 68
                plp                          ; ce44: 28
                rti                          ; ce45: 40
sub262          ldx #1                       ; ce46: a2 01  RAM TEST?
cod435          ldy #$70                     ; ce48: a0 70
                sty arr2                     ; ce4a: 84 01
                ldy #0                       ; ce4c: a0 00
                sty arr1                     ; ce4e: 84 00
-               lda dat93,x                  ; ce50: bd 8b ca
                sta (arr1),y                 ; ce53: 91 00
                cmp (arr1),y                 ; ce55: d1 00
                bne +                        ; ce57: d0 12
                dey                          ; ce59: 88
                bne -                        ; ce5a: d0 f4
                inc arr2                     ; ce5c: e6 01
                lda #$78                     ; ce5e: a9 78
                cmp arr2                     ; ce60: c5 01
                bne -                        ; ce62: d0 ec
                dex                          ; ce64: ca
                bpl cod435                   ; ce65: 10 e1
                lda #3                       ; ce67: a9 03
                sta ram76                    ; ce69: 85 8a
+               sta ram63                    ; ce6b: 85 7b
                rts                          ; ce6d: 60
sub263          jsr sub264                   ; ce6e: 20 82 ce
                lda arr47                    ; ce71: a5 60
                asl a                        ; ce73: 0a
                tax                          ; ce74: aa
                lda dat106,x                 ; ce75: bd 43 cd
                sta arr3                     ; ce78: 85 02
                lda dat107,x                 ; ce7a: bd 44 cd
                sta ram1                     ; ce7d: 85 03
                jmp (arr3)                   ; ce7f: 6c 02 00
sub264          lda arr47                    ; ce82: a5 60
                beq cod436                   ; ce84: f0 05
                lda #0                       ; ce86: a9 00
                sta arr56                    ; ce88: 85 73
                rts                          ; ce8a: 60
cod436          lda #0                       ; ce8b: a9 00
                sta arr84                    ; ce8d: 85 c6
                lda #1                       ; ce8f: a9 01
                sta arr56                    ; ce91: 85 73
                ldx arr48                    ; ce93: a6 62
                lda dat96,x                  ; ce95: bd 28 cb
                sta arr5                     ; ce98: 85 06
                lda $cb58,x                  ; ce9a: bd 58 cb
                sta ram3                     ; ce9d: 85 07
                ldy arr49                    ; ce9f: a4 64
                lda (arr5),y                 ; cea1: b1 06
                cmp #3                       ; cea3: c9 03
                bne +                        ; cea5: d0 06
                ldx #$ff                     ; cea7: a2 ff
                stx arr84                    ; cea9: 86 c6
                lda #6                       ; ceab: a9 06
+               cmp #$ff                     ; cead: c9 ff
                beq cod438                   ; ceaf: f0 18
                sta arr47                    ; ceb1: 85 60
                tax                          ; ceb3: aa
                iny                          ; ceb4: c8
                lda (arr5),y                 ; ceb5: b1 06
                sta ram57                    ; ceb7: 85 6b
                cpx #6                       ; ceb9: e0 06
                bne cod437                   ; cebb: d0 07
                iny                          ; cebd: c8
                lda (arr5),y                 ; cebe: b1 06
                sta arr82                    ; cec0: 85 c3
sub265          inc arr49                    ; cec2: e6 64
cod437          inc arr49                    ; cec4: e6 64
                inc arr49                    ; cec6: e6 64
                rts                          ; cec8: 60
cod438          iny                          ; cec9: c8
                lda (arr5),y                 ; ceca: b1 06
                sta arr48                    ; cecc: 85 62
                lda #0                       ; cece: a9 00
                sta arr49                    ; ced0: 85 64
                jmp cod436                   ; ced2: 4c 8b ce
cod439          lda arr56                    ; ced5: a5 73
                beq +                        ; ced7: f0 04
                lda ram57                    ; ced9: a5 6b
                sta arr19                    ; cedb: 85 2d
+               jsr sub303                   ; cedd: 20 09 d7
                lda arr19                    ; cee0: a5 2d
                bne +                        ; cee2: d0 03
                jsr sub266                   ; cee4: 20 13 cf
+               rts                          ; cee7: 60
                lda #$12                     ; cee8: a9 12
                sta ram69                    ; ceea: 85 82
                lda arr59                    ; ceec: a5 77
                cmp #$ff                     ; ceee: c9 ff
                bne +                        ; cef0: d0 03
                jsr sub265                   ; cef2: 20 c2 ce
+               jmp sub266                   ; cef5: 4c 13 cf
                lda #1                       ; cef8: a9 01
                sta arr60                    ; cefa: 85 78
                jsr sub389                   ; cefc: 20 80 ec
                ldx ram57                    ; ceff: a6 6b
                stx ram76                    ; cf01: 86 8a
                jmp sub266                   ; cf03: 4c 13 cf
dat109          lda #1                       ; cf06: a9 01
                sta arr60                    ; cf08: 85 78
dat110          jsr sub389                   ; cf0a: 20 80 ec
                jsr sub394                   ; cf0d: 20 2d ed
                jsr sub386                   ; cf10: 20 5a ec
sub266          lda #0                       ; cf13: a9 00
                sta arr47                    ; cf15: 85 60
                rts                          ; cf17: 60
dat111          lda #0                       ; cf18: a9 00
                sta arr60                    ; cf1a: 85 78
                sta arr47                    ; cf1c: 85 60
                rts                          ; cf1e: 60
                ldx #$12                     ; cf1f: a2 12
-               lda arr176,x                 ; cf21: bd 3d 06
                sta arr160,x                 ; cf24: 9d 00 05
                dex                          ; cf27: ca
                bpl -                        ; cf28: 10 f7
                jmp sub266                   ; cf2a: 4c 13 cf
                jsr sub267                   ; cf2d: 20 48 cf
                bne +                        ; cf30: d0 13
                sta arr33                    ; cf32: 85 46
                lda arr49                    ; cf34: a5 64
                clc                          ; cf36: 18
                adc #7                       ; cf37: 69 07
                sta arr49                    ; cf39: 85 64
                lda misc239                  ; cf3b: ad 3a 70
                cmp #$5a                     ; cf3e: c9 5a
                beq +                        ; cf40: f0 03
                jsr sub281                   ; cf42: 20 60 d2
+               jmp sub266                   ; cf45: 4c 13 cf
sub267          lda #$55                     ; cf48: a9 55
                sta misc238                  ; cf4a: 8d 39 70
                cmp misc238                  ; cf4d: cd 39 70
                bne +                        ; cf50: d0 08
                lda #$aa                     ; cf52: a9 aa
                sta misc238                  ; cf54: 8d 39 70
                cmp misc238                  ; cf57: cd 39 70
+               rts                          ; cf5a: 60
                lda misc239                  ; cf5b: ad 3a 70
                cmp #$5a                     ; cf5e: c9 5a
                bne +                        ; cf60: d0 0c
                lda misc240                  ; cf62: ad 3b 70
                cmp #$cc                     ; cf65: c9 cc
                bne cod440                   ; cf67: d0 08
                lda #$0e                     ; cf69: a9 0e
                jmp cod441                   ; cf6b: 4c 73 cf
+               jsr sub265                   ; cf6e: 20 c2 ce
cod440          lda #$13                     ; cf71: a9 13
cod441          sta ram74                    ; cf73: 85 88
                jmp sub266                   ; cf75: 4c 13 cf
sub268          lda arr56                    ; cf78: a5 73
                beq +                        ; cf7a: f0 03
                jsr $eefb                    ; cf7c: 20 fb ee
+               lda arr23                    ; cf7f: a5 37
                cmp #$0d                     ; cf81: c9 0d
                beq cod442                   ; cf83: f0 20
                lda #$68                     ; cf85: a9 68
                sta arr104                   ; cf87: 85 fc
                ldx #3                       ; cf89: a2 03
                jsr sub402                   ; cf8b: 20 2c ef
                jsr sub435                   ; cf8e: 20 46 f5
                jsr sub305                   ; cf91: 20 7b d7
                jsr sub303                   ; cf94: 20 09 d7
                lda arr23                    ; cf97: a5 37
                beq +                        ; cf99: f0 05
                lda #$10                     ; cf9b: a9 10
                sta ram21                    ; cf9d: 85 24
                rts                          ; cf9f: 60
+               lda #0                       ; cfa0: a9 00
                jmp cod509                   ; cfa2: 4c 75 d7
cod442          lda #$10                     ; cfa5: a9 10
                sta ram143                   ; cfa7: 85 fe
                lda #0                       ; cfa9: a9 00
                sta arr104                   ; cfab: 85 fc
                ldx #$ff                     ; cfad: a2 ff
-               lda arr176,x                 ; cfaf: bd 3d 06
                cmp #$20                     ; cfb2: c9 20
                bne +                        ; cfb4: d0 03
                dex                          ; cfb6: ca
                bne -                        ; cfb7: d0 f6
+               inx                          ; cfb9: e8
                stx ram29                    ; cfba: 86 2f
                lda #$0d                     ; cfbc: a9 0d
                sta arr176,x                 ; cfbe: 9d 3d 06
                jmp sub266                   ; cfc1: 4c 13 cf
sub269          ldx #$14                     ; cfc4: a2 14
                stx arr1                     ; cfc6: 86 00
-               ldx arr1                     ; cfc8: a6 00
                jsr sub270                   ; cfca: 20 e6 cf
                cmp #0                       ; cfcd: c9 00
                beq cod444                   ; cfcf: f0 0b
                dec arr1                     ; cfd1: c6 00
                lda #2                       ; cfd3: a9 02
                cmp arr1                     ; cfd5: c5 00
                bne -                        ; cfd7: d0 ef
cod443          jmp sub266                   ; cfd9: 4c 13 cf
cod444          ldx arr1                     ; cfdc: a6 00
                lda dat101,x                 ; cfde: bd 01 cd
                beq cod443                   ; cfe1: f0 f6
                jmp sub282                   ; cfe3: 4c 9c d2
sub270          lda dat94,x                  ; cfe6: bd 8d ca
                sta arr3                     ; cfe9: 85 02
                lda dat95,x                  ; cfeb: bd a2 ca
                sta ram1                     ; cfee: 85 03
                ldx #$ff                     ; cff0: a2 ff
                ldy #$ff                     ; cff2: a0 ff
                stx ram104                   ; cff4: 86 b4
-               inx                          ; cff6: e8
                lda arr176,x                 ; cff7: bd 3d 06
                cmp #$0d                     ; cffa: c9 0d
                beq +                        ; cffc: f0 26
                cmp #$20                     ; cffe: c9 20
                beq -                        ; d000: f0 f4
-               iny                          ; d002: c8
                lda (arr3),y                 ; d003: b1 02
                cmp #$20                     ; d005: c9 20
                beq -                        ; d007: f0 f9
-               lda arr176,x                 ; d009: bd 3d 06
                cmp (arr3),y                 ; d00c: d1 02
                bne +                        ; d00e: d0 14
                inc ram104                   ; d010: e6 b4
                stx ram105                   ; d012: 86 b5
                ldx ram104                   ; d014: a6 b4
                sta arr166,x                 ; d016: 9d 50 05
                ldx ram105                   ; d019: a6 b5
                cmp #$0d                     ; d01b: c9 0d
                beq cod445                   ; d01d: f0 08
                inx                          ; d01f: e8
                iny                          ; d020: c8
                jmp -                        ; d021: 4c 09 d0
+               lda #$ff                     ; d024: a9 ff
                rts                          ; d026: 60
cod445          lda #0                       ; d027: a9 00
                rts                          ; d029: 60
                lda #2                       ; d02a: a9 02
                sta arr1                     ; d02c: 85 00
                sta arr59                    ; d02e: 85 77
-               ldx arr1                     ; d030: a6 00
                jsr sub270                   ; d032: 20 e6 cf
                cmp #0                       ; d035: c9 00
                beq +                        ; d037: f0 21
                dec arr1                     ; d039: c6 00
                bpl -                        ; d03b: 10 f3
                ldx #0                       ; d03d: a2 00
-               lda misc235,x                ; d03f: bd 13 70
                sta misc233,x                ; d042: 9d 00 70
                inx                          ; d045: e8
                cpx #$26                     ; d046: e0 26
                bne -                        ; d048: d0 f5
                ldx #$12                     ; d04a: a2 12
-               lda arr176,x                 ; d04c: bd 3d 06
                sta misc237,x                ; d04f: 9d 26 70
                dex                          ; d052: ca
                bpl -                        ; d053: 10 f7
                lda #3                       ; d055: a9 03
                jmp sub282                   ; d057: 4c 9c d2
+               jmp sub266                   ; d05a: 4c 13 cf
sub271          lda arr56                    ; d05d: a5 73
                beq +                        ; d05f: f0 04
                lda #$ff                     ; d061: a9 ff
                sta arr19                    ; d063: 85 2d
+               jsr sub291                   ; d065: 20 ba d4
                jsr sub268                   ; d068: 20 78 cf
                lda arr47                    ; d06b: a5 60
                rts                          ; d06d: 60
                lda #7                       ; d06e: a9 07
                sta ram73                    ; d070: 85 87
                sta arr32                    ; d072: 85 45
                jsr sub271                   ; d074: 20 5d d0
                beq +                        ; d077: f0 03
                jmp cod453                   ; d079: 4c f7 d0
+               jsr sub269                   ; d07c: 20 c4 cf
                lda arr49                    ; d07f: a5 64
                beq cod450                   ; d081: f0 39
                lda arr1                     ; d083: a5 00
                cmp #4                       ; d085: c9 04
                beq cod448                   ; d087: f0 24
                cmp #5                       ; d089: c9 05
                beq cod451                   ; d08b: f0 30
                cmp #6                       ; d08d: c9 06
                bmi +                        ; d08f: 30 08
                cmp #$0a                     ; d091: c9 0a
                bmi cod446                   ; d093: 30 09
                cmp #$11                     ; d095: c9 11
                bpl cod447                   ; d097: 10 08
+               lda #$1d                     ; d099: a9 1d
                jmp sub282                   ; d09b: 4c 9c d2
cod446          clc                          ; d09e: 18
                adc #$0b                     ; d09f: 69 0b
cod447          tax                          ; d0a1: aa
                sec                          ; d0a2: 38
                sbc #2                       ; d0a3: e9 02
                sta ram74                    ; d0a5: 85 88
                lda dat102,x                 ; d0a7: bd 05 cd
                jmp cod449                   ; d0aa: 4c b2 d0
cod448          ldx arr30                    ; d0ad: a6 43
                lda dat103,x                 ; d0af: bd 16 cd
cod449          sta ram73                    ; d0b2: 85 87
                jsr sub273                   ; d0b4: 20 dd d0
                lda #$1b                     ; d0b7: a9 1b
                jmp sub282                   ; d0b9: 4c 9c d2
cod450          rts                          ; d0bc: 60
cod451          lda #$1e                     ; d0bd: a9 1e
                jsr sub282                   ; d0bf: 20 9c d2
                lda #7                       ; d0c2: a9 07
                sta ram73                    ; d0c4: 85 87
                inc arr30                    ; d0c6: e6 43
                lda arr30                    ; d0c8: a5 43
                cmp #4                       ; d0ca: c9 04
                bne cod452                   ; d0cc: d0 04
sub272          lda #0                       ; d0ce: a9 00
                sta arr30                    ; d0d0: 85 43
cod452          clc                          ; d0d2: 18
                adc #$0f                     ; d0d3: 69 0f
                sta ram74                    ; d0d5: 85 88
                jmp sub266                   ; d0d7: 4c 13 cf
                jsr sub272                   ; d0da: 20 ce d0
sub273          ldx #6                       ; d0dd: a2 06
                jsr sub266                   ; d0df: 20 13 cf
-               sta arr62,x                  ; d0e2: 95 80
                dex                          ; d0e4: ca
                bpl -                        ; d0e5: 10 fb
                rts                          ; d0e7: 60
                lda #$2f                     ; d0e8: a9 2f
                sta ram73                    ; d0ea: 85 87
                sta arr32                    ; d0ec: 85 45
                lda #$ff                     ; d0ee: a9 ff
                sta arr59                    ; d0f0: 85 77
                jsr sub271                   ; d0f2: 20 5d d0
                beq cod454                   ; d0f5: f0 0b
cod453          lda arr19                    ; d0f7: a5 2d
                bne cod454                   ; d0f9: d0 07
                sta arr104                   ; d0fb: 85 fc
                lda #$2e                     ; d0fd: a9 2e
                jmp sub282                   ; d0ff: 4c 9c d2
cod454          rts                          ; d102: 60
                lda arr32                    ; d103: a5 45
                sta ram73                    ; d105: 85 87
                lda ram73                    ; d107: a5 87
                jmp sub282                   ; d109: 4c 9c d2
dat112          jmp cod451                   ; d10c: 4c bd d0
                jsr $eefb                    ; d10f: 20 fb ee
                ldx #8                       ; d112: a2 08
                jsr sub431                   ; d114: 20 b3 f4
                jsr sub278                   ; d117: 20 fe d1
                lda #1                       ; d11a: a9 01
                ldx #0                       ; d11c: a2 00
                stx ram38                    ; d11e: 86 41
                stx arr55                    ; d120: 86 72
                beq cod455                   ; d122: f0 3b
                lda #$3a                     ; d124: a9 3a
                sta arr1                     ; d126: 85 00
                lda #$ca                     ; d128: a9 ca
                jsr sub276                   ; d12a: 20 92 d1
                jsr $eefb                    ; d12d: 20 fb ee
                jsr sub279                   ; d130: 20 0d d2
                lda #2                       ; d133: a9 02
                ldx #1                       ; d135: a2 01
                bne cod455                   ; d137: d0 26
dat113          jsr $eefb                    ; d139: 20 fb ee
                jsr sub345                   ; d13c: 20 b0 e4
                lda #$36                     ; d13f: a9 36
                sta arr1                     ; d141: 85 00
                lda #$ca                     ; d143: a9 ca
                jsr sub276                   ; d145: 20 92 d1
                ldx #$10                     ; d148: a2 10
                jsr sub431                   ; d14a: 20 b3 f4
                lda #$b7                     ; d14d: a9 b7
                sta ram30                    ; d14f: 85 31
                ldx #2                       ; d151: a2 02
                stx arr64                    ; d153: 86 8c
                jsr sub354                   ; d155: 20 d2 e6
                jsr sub352                   ; d158: 20 87 e6
                lda #0                       ; d15b: a9 00
                ldx #4                       ; d15d: a2 04
cod455          sta arr104                   ; d15f: 85 fc
                stx ram33                    ; d161: 86 36
                jsr sub274                   ; d163: 20 83 d1
                jsr sub266                   ; d166: 20 13 cf
                ldy #$40                     ; d169: a0 40
                sty arr61                    ; d16b: 84 79
-               sta arr71,y                  ; d16d: 99 9f 00
                dey                          ; d170: 88
                bne -                        ; d171: d0 fa
                lda #1                       ; d173: a9 01
                sta ram143                   ; d175: 85 fe
                sta misc239                  ; d177: 8d 3a 70
                sta misc240                  ; d17a: 8d 3b 70
                jsr sub401                   ; d17d: 20 0d ef
                jmp sub434                   ; d180: 4c 0f f5
sub274          lda #$3e                     ; d183: a9 3e
                sta arr1                     ; d185: 85 00
                lda #$ca                     ; d187: a9 ca
                jmp sub276                   ; d189: 4c 92 d1
sub275          lda #$42                     ; d18c: a9 42
                sta arr1                     ; d18e: 85 00
                lda #$ca                     ; d190: a9 ca
sub276          sta arr2                     ; d192: 85 01
                jmp cod641                   ; d194: 4c 86 ec
sub277          ldx ram33                    ; d197: a6 36
                lda ram65                    ; d199: a5 7d
                cmp #$ff                     ; d19b: c9 ff
                beq cod458                   ; d19d: f0 41
                cmp #1                       ; d19f: c9 01
                bne cod460                   ; d1a1: d0 45
                lda #$20                     ; d1a3: a9 20
                sta arr131                   ; d1a5: 8d 01 03
                sta ram64                    ; d1a8: 85 7c
                lda #$e3                     ; d1aa: a9 e3
                sta arr132                   ; d1ac: 8d 02 03
                lda #$5a                     ; d1af: a9 5a
                sta arr133                   ; d1b1: 8d 03 03
                lda #$20                     ; d1b4: a9 20
                sta arr134                   ; d1b6: 8d 04 03
                lda #0                       ; d1b9: a9 00
                sta arr135                   ; d1bb: 8d 05 03
                jsr $eefb                    ; d1be: 20 fb ee
cod456          lda ram33                    ; d1c1: a5 36
                cmp #4                       ; d1c3: c9 04
                bne +                        ; d1c5: d0 0b
                lda ram65                    ; d1c7: a5 7d
                and #%00000011               ; d1c9: 29 03
                bne +                        ; d1cb: d0 05
                sta arr131                   ; d1cd: 8d 01 03
                beq cod457                   ; d1d0: f0 05
+               lda #4                       ; d1d2: a9 04
                sta ram164                   ; d1d4: 8d 00 03
cod457          inc ram65                    ; d1d7: e6 7d
                lda dat90,x                  ; d1d9: bd 46 ca
                cmp ram65                    ; d1dc: c5 7d
                bne cod459                   ; d1de: d0 07
cod458          jsr sub401                   ; d1e0: 20 0d ef
                lda #0                       ; d1e3: a9 00
                sta ram65                    ; d1e5: 85 7d
cod459          rts                          ; d1e7: 60
cod460          clc                          ; d1e8: 18
                lda $ca4b,x                  ; d1e9: bd 4b ca
                adc arr132                   ; d1ec: 6d 02 03
                sta arr132                   ; d1ef: 8d 02 03
                lda ram64                    ; d1f2: a5 7c
                adc #0                       ; d1f4: 69 00
                sta arr131                   ; d1f6: 8d 01 03
                sta ram64                    ; d1f9: 85 7c
                jmp cod456                   ; d1fb: 4c c1 d1
sub278          jsr sub281                   ; d1fe: 20 60 d2
                ldx #$d8                     ; d201: a2 d8
-               lda misc247,x                ; d203: bd ff 70
                sta arr175,x                 ; d206: 9d 3c 06
                dex                          ; d209: ca
                bne -                        ; d20a: d0 f7
                rts                          ; d20c: 60
sub279          jsr sub281                   ; d20d: 20 60 d2
                ldx #0                       ; d210: a2 00
-               lda misc258,x                ; d212: bd 00 74
                sta arr176,x                 ; d215: 9d 3d 06
                inx                          ; d218: e8
                bne -                        ; d219: d0 f7
-               lda misc262,x                ; d21b: bd 00 75
                sta arr195,x                 ; d21e: 9d 3d 07
                inx                          ; d221: e8
                cpx #$98                     ; d222: e0 98
                bne -                        ; d224: d0 f5
                rts                          ; d226: 60
sub280          ldx ram29                    ; d227: a6 2f
                lda ram28                    ; d229: a5 2e
                beq +                        ; d22b: f0 06
                lda arr195,x                 ; d22d: bd 3d 07
                jmp cod461                   ; d230: 4c 36 d2
+               lda arr176,x                 ; d233: bd 3d 06
cod461          sta arr24                    ; d236: 85 38
                cmp #$21                     ; d238: c9 21
                bcc +                        ; d23a: 90 03
                jsr sub418                   ; d23c: 20 88 f2
+               jsr sub412                   ; d23f: 20 10 f2
                cmp #2                       ; d242: c9 02
                bne +                        ; d244: d0 07
                lda #0                       ; d246: a9 00
                sta arr61                    ; d248: 85 79
                jmp sub401                   ; d24a: 4c 0d ef
+               jsr sub416                   ; d24d: 20 73 f2
                ldx ram33                    ; d250: a6 36
                cpx #4                       ; d252: e0 04
                bne +                        ; d254: d0 03
                jsr sub405                   ; d256: 20 d4 f0
+               lda arr24                    ; d259: a5 38
                cmp #$21                     ; d25b: c9 21
                bcc sub280                   ; d25d: 90 c8
                rts                          ; d25f: 60
sub281          lda #$5a                     ; d260: a9 5a
                cmp misc239                  ; d262: cd 3a 70
                bne +                        ; d265: d0 08
                lda misc240                  ; d267: ad 3b 70
                cmp #$cc                     ; d26a: c9 cc
                bne cod462                   ; d26c: d0 11
                rts                          ; d26e: 60
+               lda #$20                     ; d26f: a9 20
                sta misc233                  ; d271: 8d 00 70
                lda #$0d                     ; d274: a9 0d
                sta misc234                  ; d276: 8d 01 70
                sta misc235                  ; d279: 8d 13 70
                sta misc237                  ; d27c: 8d 26 70
cod462          ldy #0                       ; d27f: a0 00
                lda #$3c                     ; d281: a9 3c
                sta arr6                     ; d283: 85 08
                lda #$70                     ; d285: a9 70
                sta ram4                     ; d287: 85 09
-               lda #$20                     ; d289: a9 20
                sta (arr6),y                 ; d28b: 91 08
                inc arr6                     ; d28d: e6 08
                bne -                        ; d28f: d0 f8
                inc ram4                     ; d291: e6 09
                lda ram4                     ; d293: a5 09
                cmp #$78                     ; d295: c9 78
                bne -                        ; d297: d0 f0
                rts                          ; d299: 60
                lda #$19                     ; d29a: a9 19
sub282          sta arr48                    ; d29c: 85 62
                jsr sub266                   ; d29e: 20 13 cf
                sta arr49                    ; d2a1: 85 64
                rts                          ; d2a3: 60
                lda arr82                    ; d2a4: a5 c3
                cmp #$19                     ; d2a6: c9 19
                bne +                        ; d2a8: d0 04
                lda #0                       ; d2aa: a9 00
                sta arr33                    ; d2ac: 85 46
+               jsr sub303                   ; d2ae: 20 09 d7
                lda arr84                    ; d2b1: a5 c6
                beq cod463                   ; d2b3: f0 0c
                bpl cod464                   ; d2b5: 10 0d
dat114          lda #$0a                     ; d2b7: a9 0a
                sta ram107                   ; d2b9: 85 b7
                jsr sub286                   ; d2bb: 20 fe d3
                jmp sub287                   ; d2be: 4c 2b d4
cod463          jmp cod478                   ; d2c1: 4c f1 d3
cod464          lda arr56                    ; d2c4: a5 73
                beq +                        ; d2c6: f0 03
                jsr sub287                   ; d2c8: 20 2b d4
+               lda #0                       ; d2cb: a9 00
                jsr sub306                   ; d2cd: 20 81 d7
                jsr sub288                   ; d2d0: 20 43 d4
                lda ram114                   ; d2d3: a5 c2
                beq +                        ; d2d5: f0 03
                jmp cod474                   ; d2d7: 4c b0 d3
+               jsr sub285                   ; d2da: 20 e0 d3
                sta arr1                     ; d2dd: 85 00
cod465          lda arr1                     ; d2df: a5 00
                pha                          ; d2e1: 48
                lda #0                       ; d2e2: a9 00
                jsr sub306                   ; d2e4: 20 81 d7
                pla                          ; d2e7: 68
                sta arr1                     ; d2e8: 85 00
                lda ram110                   ; d2ea: a5 bb
                sta ram109                   ; d2ec: 85 ba
                lda arr79                    ; d2ee: a5 bc
                sta arr78                    ; d2f0: 85 b9
                inc arr83                    ; d2f2: e6 c5
                lda arr1                     ; d2f4: a5 00
                cmp #$0d                     ; d2f6: c9 0d
                beq cod470                   ; d2f8: f0 60
                cmp #$ff                     ; d2fa: c9 ff
                beq cod466                   ; d2fc: f0 29
                and #%11100000               ; d2fe: 29 e0
                cmp #$e0                     ; d300: c9 e0
                bcs cod469                   ; d302: b0 4c
                lda arr1                     ; d304: a5 00
                and #%11000000               ; d306: 29 c0
                cmp #$c0                     ; d308: c9 c0
                bcs cod471                   ; d30a: b0 72
                lda #6                       ; d30c: a9 06
                sta ram25                    ; d30e: 85 29
                lda arr1                     ; d310: a5 00
                pha                          ; d312: 48
                cmp #$20                     ; d313: c9 20
                beq +                        ; d315: f0 04
                lda #2                       ; d317: a9 02
                sta arr105                   ; d319: 85 ff
+               pla                          ; d31b: 68
                jsr sub309                   ; d31c: 20 d9 d7
                lda #1                       ; d31f: a9 01
                jsr sub284                   ; d321: 20 a4 d3
                jmp cod477                   ; d324: 4c cf d3
cod466          ldy #1                       ; d327: a0 01
                lda arr82                    ; d329: a5 c3
                cmp #$31                     ; d32b: c9 31
                beq cod468                   ; d32d: f0 15
                cmp #$33                     ; d32f: c9 33
                beq cod468                   ; d331: f0 11
                cmp #$2e                     ; d333: c9 2e
                beq cod467                   ; d335: f0 0b
                cmp #$36                     ; d337: c9 36
                bne +                        ; d339: d0 06
                lda arr59                    ; d33b: a5 77
                cmp #$ff                     ; d33d: c9 ff
                bne cod468                   ; d33f: d0 03
+               iny                          ; d341: c8
cod467          sty ram143                   ; d342: 84 fe
cod468          lda #$58                     ; d344: a9 58
                sta ram26                    ; d346: 85 2a
                jsr sub266                   ; d348: 20 13 cf
                sta arr84                    ; d34b: 85 c6
                jmp cod509                   ; d34d: 4c 75 d7
cod469          lda arr1                     ; d350: a5 00
                and #%00011111               ; d352: 29 1f
                jsr sub284                   ; d354: 20 a4 d3
                jmp cod477                   ; d357: 4c cf d3
cod470          lda ram110                   ; d35a: a5 bb
                and #%00011111               ; d35c: 29 1f
                cmp #7                       ; d35e: c9 07
                bne sub283                   ; d360: d0 11
                dec arr83                    ; d362: c6 c5
                dec arr83                    ; d364: c6 c5
                jsr sub285                   ; d366: 20 e0 d3
                inc arr83                    ; d369: e6 c5
                inc arr83                    ; d36b: e6 c5
                and #%11110000               ; d36d: 29 f0
                cmp #$c0                     ; d36f: c9 c0
                beq cod473                   ; d371: f0 3c
sub283          lda ram110                   ; d373: a5 bb
                and #%11100000               ; d375: 29 e0
                sta ram110                   ; d377: 85 bb
                lda #$27                     ; d379: a9 27
                jmp sub284                   ; d37b: 4c a4 d3
cod471          lda ram74                    ; d37e: a5 88
                ldy arr1                     ; d380: a4 00
                cpy #$c2                     ; d382: c0 c2
                beq cod472                   ; d384: f0 0c
                lda ram57                    ; d386: a5 6b
                cpy #$c1                     ; d388: c0 c1
                beq +                        ; d38a: f0 04
                lsr a                        ; d38c: 4a
                lsr a                        ; d38d: 4a
                lsr a                        ; d38e: 4a
                lsr a                        ; d38f: 4a
+               and #%00001111               ; d390: 29 0f
cod472          tax                          ; d392: aa
                lda dat104,x                 ; d393: bd 1a cd
                sta ram112                   ; d396: 85 c0
                lda dat105,x                 ; d398: bd 2e cd
                sta ram113                   ; d39b: 85 c1
                lda #0                       ; d39d: a9 00
                sta ram115                   ; d39f: 85 c4
                inc ram114                   ; d3a1: e6 c2
                rts                          ; d3a3: 60
sub284          clc                          ; d3a4: 18
                adc ram110                   ; d3a5: 65 bb
                sta ram110                   ; d3a7: 85 bb
                lda arr79                    ; d3a9: a5 bc
                adc #0                       ; d3ab: 69 00
                sta arr79                    ; d3ad: 85 bc
cod473          rts                          ; d3af: 60
cod474          jsr sub288                   ; d3b0: 20 43 d4
                ldy ram115                   ; d3b3: a4 c4
                lda (ram112),y               ; d3b5: b1 c0
                cmp #$0d                     ; d3b7: c9 0d
                beq cod475                   ; d3b9: f0 0f
                cmp #$bf                     ; d3bb: c9 bf
                bcc +                        ; d3bd: 90 02
                lda #$20                     ; d3bf: a9 20
+               inc ram115                   ; d3c1: e6 c4
                dec arr83                    ; d3c3: c6 c5
                sta arr1                     ; d3c5: 85 00
                jmp cod465                   ; d3c7: 4c df d2
cod475          lda #0                       ; d3ca: a9 00
                sta ram114                   ; d3cc: 85 c2
cod476          rts                          ; d3ce: 60
cod477          lda ram110                   ; d3cf: a5 bb
                and #%00011111               ; d3d1: 29 1f
                sec                          ; d3d3: 38
                sbc #$19                     ; d3d4: e9 19
                bmi cod473                   ; d3d6: 30 d7
                pha                          ; d3d8: 48
                jsr sub283                   ; d3d9: 20 73 d3
                pla                          ; d3dc: 68
                jmp sub284                   ; d3dd: 4c a4 d3
sub285          ldy arr82                    ; d3e0: a4 c3
                lda dat88,y                  ; d3e2: b9 29 c5
                sta arr1                     ; d3e5: 85 00
                lda dat89,y                  ; d3e7: b9 65 c5
                sta arr2                     ; d3ea: 85 01
                ldy arr83                    ; d3ec: a4 c5
                lda (arr1),y                 ; d3ee: b1 00
                rts                          ; d3f0: 60
cod478          lda ram107                   ; d3f1: a5 b7
                bne sub286                   ; d3f3: d0 09
                lda ram26                    ; d3f5: a5 2a
                bne cod476                   ; d3f7: d0 d5
                inc ram107                   ; d3f9: e6 b7
                jmp sub294                   ; d3fb: 4c 35 d6
sub286          ldx ram107                   ; d3fe: a6 b7
                dex                          ; d400: ca
                lda dat84,x                  ; d401: bd bc c4
                sta ram109                   ; d404: 85 ba
                lda dat83,x                  ; d406: bd b1 c4
                sta arr78                    ; d409: 85 b9
                cpx #$0b                     ; d40b: e0 0b
                beq +                        ; d40d: f0 12
                lda #0                       ; d40f: a9 00
                sta ram164                   ; d411: 8d 00 03
                lda #$20                     ; d414: a9 20
                jsr sub309                   ; d416: 20 d9 d7
                lda #$54                     ; d419: a9 54
                sta arr133                   ; d41b: 8d 03 03
                inc ram107                   ; d41e: e6 b7
                rts                          ; d420: 60
+               jsr sub287                   ; d421: 20 2b d4
                lda #$30                     ; d424: a9 30
                ldy #$0d                     ; d426: a0 0d
                jmp sub308                   ; d428: 4c d3 d7
sub287          lda #1                       ; d42b: a9 01
                sta arr84                    ; d42d: 85 c6
                lda #$e7                     ; d42f: a9 e7
                sta ram110                   ; d431: 85 bb
                lda #$20                     ; d433: a9 20
                sta arr79                    ; d435: 85 bc
                lda #0                       ; d437: a9 00
                sta arr83                    ; d439: 85 c5
                sta ram107                   ; d43b: 85 b7
                lda #$f8                     ; d43d: a9 f8
                sta ram161                   ; d43f: 8d c0 02
                rts                          ; d442: 60
sub288          lda ram25                    ; d443: a5 29
                beq +                        ; d445: f0 02
                pla                          ; d447: 68
                pla                          ; d448: 68
+               rts                          ; d449: 60
                lda arr56                    ; d44a: a5 73
                beq cod479                   ; d44c: f0 0e
                lda #3                       ; d44e: a9 03
                sta ram116                   ; d450: 85 c7
                lda ram57                    ; d452: a5 6b
                bne +                        ; d454: d0 04
                ldy #4                       ; d456: a0 04
                sty ram143                   ; d458: 84 fe
+               sta ram117                   ; d45a: 85 c8
cod479          ldx #$0a                     ; d45c: a2 0a
                ldy ram116                   ; d45e: a4 c7
                jsr sub289                   ; d460: 20 7d d4
                ldy ram116                   ; d463: a4 c7
                jsr sub290                   ; d465: 20 8f d4
                jsr $eefb                    ; d468: 20 fb ee
                dec ram116                   ; d46b: c6 c7
                bpl cod480                   ; d46d: 10 0d
                jsr sub266                   ; d46f: 20 13 cf
                lda ram117                   ; d472: a5 c8
                cmp #2                       ; d474: c9 02
                bne cod480                   ; d476: d0 04
                lda #4                       ; d478: a9 04
                sta ram117                   ; d47a: 85 c8
cod480          rts                          ; d47c: 60
sub289          lda $ca64,y                  ; d47d: b9 64 ca
                pha                          ; d480: 48
                jsr sub297                   ; d481: 20 44 d6
                pla                          ; d484: 68
                sta arr1                     ; d485: 85 00
                lda #0                       ; d487: a9 00
                sta ram164                   ; d489: 8d 00 03
                jmp sub395                   ; d48c: 4c 65 ed
sub290          ldx ram117                   ; d48f: a6 c8
                lda $ca50,x                  ; d491: bd 50 ca
                sta arr2                     ; d494: 85 01
                lda dat91,x                  ; d496: bd 54 ca
                sta arr3                     ; d499: 85 02
                lda (arr2),y                 ; d49b: b1 01
                tax                          ; d49d: aa
                lda dat94,x                  ; d49e: bd 8d ca
                sta arr2                     ; d4a1: 85 01
                lda dat95,x                  ; d4a3: bd a2 ca
                sta arr3                     ; d4a6: 85 02
                ldy #0                       ; d4a8: a0 00
-               lda (arr2),y                 ; d4aa: b1 01
                cmp #$0d                     ; d4ac: c9 0d
                beq cod480                   ; d4ae: f0 cc
                sta arr134,y                 ; d4b0: 99 04 03
                sta arr176,y                 ; d4b3: 99 3d 06
                iny                          ; d4b6: c8
                jmp -                        ; d4b7: 4c aa d4
sub291          lda arr23                    ; d4ba: a5 37
                cmp #$c1                     ; d4bc: c9 c1
                bcc cod481                   ; d4be: 90 54
                cmp #$c5                     ; d4c0: c9 c5
                bcs cod481                   ; d4c2: b0 50
                pha                          ; d4c4: 48
                ldy #4                       ; d4c5: a0 04
                ldx #$0b                     ; d4c7: a2 0b
                jsr sub289                   ; d4c9: 20 7d d4
                pla                          ; d4cc: 68
                and #%00001111               ; d4cd: 29 0f
                tay                          ; d4cf: a8
dat115          dey                          ; d4d0: 88
                jsr sub290                   ; d4d1: 20 8f d4
                cpy #0                       ; d4d4: c0 00
                beq +                        ; d4d6: f0 34
                sty arr9                     ; d4d8: 84 0f
                jsr $eefb                    ; d4da: 20 fb ee
                ldx #$20                     ; d4dd: a2 20
-               lda #$20                     ; d4df: a9 20
                sta arr133,x                 ; d4e1: 9d 03 03
                dex                          ; d4e4: ca
                cpx arr9                     ; d4e5: e4 0f
                bne -                        ; d4e7: d0 f6
-               lda arr134,x                 ; d4e9: bd 04 03
                sta arr176,x                 ; d4ec: 9d 3d 06
                jsr sub412                   ; d4ef: 20 10 f2
                jsr sub406                   ; d4f2: 20 15 f1
                dex                          ; d4f5: ca
                bpl -                        ; d4f6: 10 f1
                lda #$15                     ; d4f8: a9 15
                sta ram164                   ; d4fa: 8d 00 03
                lda #$12                     ; d4fd: a9 12
                sta arr133                   ; d4ff: 8d 03 03
                lda #0                       ; d502: a9 00
                sta ram166                   ; d504: 8d 16 03
                lda #$40                     ; d507: a9 40
                sta ram143                   ; d509: 85 fe
                rts                          ; d50b: 60
+               lda #0                       ; d50c: a9 00
                sta ram164                   ; d50e: 8d 00 03
                sta arr131                   ; d511: 8d 01 03
cod481          rts                          ; d514: 60
                lda #3                       ; d515: a9 03
                sta ram33                    ; d517: 85 36
                jsr sub401                   ; d519: 20 0d ef
                jsr sub303                   ; d51c: 20 09 d7
                lda ram57                    ; d51f: a5 6b
                cmp #3                       ; d521: c9 03
                beq cod482                   ; d523: f0 0a
                lda arr56                    ; d525: a5 73
                beq +                        ; d527: f0 03
                jsr sub292                   ; d529: 20 35 d5
+               jmp cod484                   ; d52c: 4c 73 d5
cod482          jsr sub292                   ; d52f: 20 35 d5
                sta arr47                    ; d532: 85 60
                rts                          ; d534: 60
sub292          jsr sub299                   ; d535: 20 7c d6
                lda #1                       ; d538: a9 01
                sta ram106                   ; d53a: 85 b6
                lda #0                       ; d53c: a9 00
                sta ram107                   ; d53e: 85 b7
                sta ram114                   ; d540: 85 c2
                rts                          ; d542: 60
cod483          lda ram107                   ; d543: a5 b7
                bne +                        ; d545: d0 06
                lda #$c6                     ; d547: a9 c6
                sta arr40                    ; d549: 85 51
                sta ram107                   ; d54b: 85 b7
+               cmp #$da                     ; d54d: c9 da
                beq +                        ; d54f: f0 19
                ldy #$20                     ; d551: a0 20
-               jsr sub398                   ; d553: 20 e8 ed
                lda arr41                    ; d556: a5 52
                and #%00000011               ; d558: 29 03
                tax                          ; d55a: aa
                lda dat87,x                  ; d55b: bd 25 c5
                sta arr140,y                 ; d55e: 99 50 03
                dey                          ; d561: 88
                bne -                        ; d562: d0 ef
                jsr sub304                   ; d564: 20 6d d7
                jmp cod493                   ; d567: 4c 1c d6
+               lda #0                       ; d56a: a9 00
                sta ram107                   ; d56c: 85 b7
                sta arr18                    ; d56e: 85 2c
                inc ram106                   ; d570: e6 b6
                rts                          ; d572: 60
cod484          ldx ram106                   ; d573: a6 b6
                dex                          ; d575: ca
                dex                          ; d576: ca
                dex                          ; d577: ca
                beq cod490                   ; d578: f0 5e
                bmi cod490                   ; d57a: 30 5c
                dex                          ; d57c: ca
                beq cod483                   ; d57d: f0 c4
                dex                          ; d57f: ca
                beq +                        ; d580: f0 07
                dex                          ; d582: ca
                beq cod485                   ; d583: f0 0c
                dex                          ; d585: ca
                beq cod486                   ; d586: f0 28
                rts                          ; d588: 60
+               ldx #4                       ; d589: a2 04
                jsr sub296                   ; d58b: 20 3e d6
                inc ram106                   ; d58e: e6 b6
                rts                          ; d590: 60
cod485          lda arr23                    ; d591: a5 37
                beq +                        ; d593: f0 0b
                inc ram106                   ; d595: e6 b6
                lda #4                       ; d597: a9 04
                sta ram143                   ; d599: 85 fe
                lda #0                       ; d59b: a9 00
                sta arr104                   ; d59d: 85 fc
                rts                          ; d59f: 60
+               lda arr42                    ; d5a0: a5 53
                and #%00000111               ; d5a2: 29 07
                tax                          ; d5a4: aa
                lda dat86,x                  ; d5a5: bd 1d c5
                sta ram107                   ; d5a8: 85 b7
                jsr sub293                   ; d5aa: 20 b9 d5
                jmp cod483                   ; d5ad: 4c 43 d5
cod486          jsr sub294                   ; d5b0: 20 35 d6
                jsr sub266                   ; d5b3: 20 13 cf
                sta ram107                   ; d5b6: 85 b7
                rts                          ; d5b8: 60
sub293          ldx #0                       ; d5b9: a2 00
                lda arr18                    ; d5bb: a5 2c
                bne +                        ; d5bd: d0 05
                dec arr18                    ; d5bf: c6 2c
                jmp cod487                   ; d5c1: 4c d1 d5
+               cmp #$c8                     ; d5c4: c9 c8
                beq cod488                   ; d5c6: f0 0a
                cmp #$d0                     ; d5c8: c9 d0
                beq cod487                   ; d5ca: f0 05
                cmp #$f0                     ; d5cc: c9 f0
                bne cod489                   ; d5ce: d0 07
                inx                          ; d5d0: e8
cod487          inx                          ; d5d1: e8
cod488          lda $c4ae,x                  ; d5d2: bd ae c4
                sta arr104                   ; d5d5: 85 fc
cod489          rts                          ; d5d7: 60
cod490          inx                          ; d5d8: e8
                beq +                        ; d5d9: f0 10
                inx                          ; d5db: e8
                beq cod492                   ; d5dc: f0 1b
                lda #$21                     ; d5de: a9 21
                ldy #7                       ; d5e0: a0 07
                jsr sub308                   ; d5e2: 20 d3 d7
                jsr sub295                   ; d5e5: 20 3c d6
                inc ram106                   ; d5e8: e6 b6
                rts                          ; d5ea: 60
+               ldx #$0c                     ; d5eb: a2 0c
                ldy ram116                   ; d5ed: a4 c7
                jsr sub289                   ; d5ef: 20 7d d4
                dec ram116                   ; d5f2: c6 c7
                bpl cod491                   ; d5f4: 10 02
                inc ram106                   ; d5f6: e6 b6
cod491          rts                          ; d5f8: 60
cod492          lda ram107                   ; d5f9: a5 b7
                bne +                        ; d5fb: d0 04
                lda #9                       ; d5fd: a9 09
                sta ram107                   ; d5ff: 85 b7
+               lda #0                       ; d601: a9 00
                sta ram72                    ; d603: 85 86
                sta arr84                    ; d605: 85 c6
                jsr sub286                   ; d607: 20 fe d3
                lda #$ff                     ; d60a: a9 ff
                sta arr134                   ; d60c: 8d 04 03
                lda arr84                    ; d60f: a5 c6
                beq cod491                   ; d611: f0 e5
                inc ram106                   ; d613: e6 b6
                lda #3                       ; d615: a9 03
                sta ram116                   ; d617: 85 c7
                jmp sub287                   ; d619: 4c 2b d4
cod493          lda #$84                     ; d61c: a9 84
                sta arr140                   ; d61e: 8d 50 03
                ldx #8                       ; d621: a2 08
                jsr sub297                   ; d623: 20 44 d6
                lda ram107                   ; d626: a5 b7
                sta arr1                     ; d628: 85 00
                jsr sub395                   ; d62a: 20 65 ed
                lda ram107                   ; d62d: a5 b7
                clc                          ; d62f: 18
                adc #4                       ; d630: 69 04
                sta ram107                   ; d632: 85 b7
                rts                          ; d634: 60
sub294          lda #$0f                     ; d635: a9 0f
                ldy #7                       ; d637: a0 07
                jsr sub308                   ; d639: 20 d3 d7
sub295          ldx #5                       ; d63c: a2 05
sub296          jsr sub297                   ; d63e: 20 44 d6
                jmp sub395                   ; d641: 4c 65 ed
sub297          lda $c4c7,x                  ; d644: bd c7 c4
                sta arr4                     ; d647: 85 05
                lda dat85,x                  ; d649: bd d4 c4
                sta arr5                     ; d64c: 85 06
                ldy #4                       ; d64e: a0 04
-               lda (arr4),y                 ; d650: b1 05
                sta arr1,y                   ; d652: 99 00 00
                dey                          ; d655: 88
                bpl -                        ; d656: 10 f8
cod494          rts                          ; d658: 60
sub298          lda ram20                    ; d659: a5 22
                bne cod494                   ; d65b: d0 fb
                lda ram35                    ; d65d: a5 3b
                and #%00000111               ; d65f: 29 07
                cmp #1                       ; d661: c9 01
                bne cod494                   ; d663: d0 f3
                inc ram108                   ; d665: e6 b8
                lda ram108                   ; d667: a5 b8
                and #%00000111               ; d669: 29 07
                sta ram108                   ; d66b: 85 b8
                tax                          ; d66d: aa
                bne +                        ; d66e: d0 04
                lda #$30                     ; d670: a9 30
                sta ram20                    ; d672: 85 22
+               lda dat82,x                  ; d674: bd a6 c4
                ldy #3                       ; d677: a0 03
                jmp sub308                   ; d679: 4c d3 d7
sub299          jsr sub300                   ; d67c: 20 8b d6
                ldx #$6f                     ; d67f: a2 6f
-               jsr sub302                   ; d681: 20 b1 d6
                sta arr112,x                 ; d684: 9d 40 02
                dex                          ; d687: ca
                bpl -                        ; d688: 10 f7
                rts                          ; d68a: 60
sub300          ldx #$2f                     ; d68b: a2 2f
-               lda #0                       ; d68d: a9 00
                sta arr107,x                 ; d68f: 9d 00 02
                dex                          ; d692: ca
                bpl -                        ; d693: 10 f8
                ldx #6                       ; d695: a2 06
                jsr sub297                   ; d697: 20 44 d6
                jsr sub391                   ; d69a: 20 be ec
sub301          ldx #7                       ; d69d: a2 07
                jsr sub297                   ; d69f: 20 44 d6
                jsr sub391                   ; d6a2: 20 be ec
                ldx #$0f                     ; d6a5: a2 0f
-               lda dat78,x                  ; d6a7: bd 78 c4
                sta arr111,x                 ; d6aa: 9d 30 02
                dex                          ; d6ad: ca
                bpl -                        ; d6ae: 10 f7
                rts                          ; d6b0: 60
sub302          ldy #0                       ; d6b1: a0 00
                txa                          ; d6b3: 8a
                cmp #$20                     ; d6b4: c9 20
                bcc +                        ; d6b6: 90 17
                and #%00000011               ; d6b8: 29 03
                beq cod495                   ; d6ba: f0 30
                cmp #1                       ; d6bc: c9 01
                beq cod497                   ; d6be: f0 39
                cmp #3                       ; d6c0: c9 03
                bne cod502                   ; d6c2: d0 3d
                cpx #$50                     ; d6c4: e0 50
                bcc cod502                   ; d6c6: 90 39
                cpx #$60                     ; d6c8: e0 60
                bcc cod498                   ; d6ca: 90 2e
                jmp cod496                   ; d6cc: 4c f8 d6
+               and #%00000011               ; d6cf: 29 03
                beq +                        ; d6d1: f0 11
                cmp #1                       ; d6d3: c9 01
                beq cod500                   ; d6d5: f0 28
                cmp #2                       ; d6d7: c9 02
                beq cod501                   ; d6d9: f0 25
                txa                          ; d6db: 8a
                and #%00001111               ; d6dc: 29 0f
                lsr a                        ; d6de: 4a
                lsr a                        ; d6df: 4a
                tay                          ; d6e0: a8
                jmp cod499                   ; d6e1: 4c fe d6
+               txa                          ; d6e4: 8a
                and #%11110000               ; d6e5: 29 f0
                beq cod504                   ; d6e7: f0 1a
                jmp cod503                   ; d6e9: 4c 02 d7
cod495          txa                          ; d6ec: 8a
                cmp #$50                     ; d6ed: c9 50
                bcs cod502                   ; d6ef: b0 10
                and #%00001000               ; d6f1: 29 08
                bne cod506                   ; d6f3: d0 10
                jmp cod505                   ; d6f5: 4c 04 d7
cod496          iny                          ; d6f8: c8
cod497          iny                          ; d6f9: c8
cod498          iny                          ; d6fa: c8
                iny                          ; d6fb: c8
                iny                          ; d6fc: c8
                iny                          ; d6fd: c8
cod499          iny                          ; d6fe: c8
cod500          iny                          ; d6ff: c8
cod501          iny                          ; d700: c8
cod502          iny                          ; d701: c8
cod503          iny                          ; d702: c8
cod504          iny                          ; d703: c8
cod505          iny                          ; d704: c8
cod506          lda $c488,y                  ; d705: b9 88 c4
                rts                          ; d708: 60
sub303          jsr sub305                   ; d709: 20 7b d7
                jsr sub304                   ; d70c: 20 6d d7
                jsr sub298                   ; d70f: 20 59 d6
                lda ram35                    ; d712: a5 3b
                and #%00000011               ; d714: 29 03
                cmp #1                       ; d716: c9 01
                bne cod507                   ; d718: d0 52
                ldx #4                       ; d71a: a2 04
-               lda arr40,x                  ; d71c: b5 51
                sta arr140,x                 ; d71e: 9d 50 03
                dex                          ; d721: ca
                bne -                        ; d722: d0 f8
                lda #$14                     ; d724: a9 14
                sta arr140                   ; d726: 8d 50 03
                ldx #9                       ; d729: a2 09
                jsr sub296                   ; d72b: 20 3e d6
                lda arr77                    ; d72e: a5 b0
                and ram101                   ; d730: 25 b1
                and ram102                   ; d732: 25 b2
                and ram103                   ; d734: 25 b3
                beq +                        ; d736: f0 07
                ldy #$0b                     ; d738: a0 0b
                lda arr40                    ; d73a: a5 51
                jsr sub308                   ; d73c: 20 d3 d7
+               ldx #3                       ; d73f: a2 03
-               lda arr17,x                  ; d741: b5 25
                bne +                        ; d743: d0 18
                lda arr40,x                  ; d745: b5 51
                and #%00110111               ; d747: 29 37
                sta arr17,x                  ; d749: 95 25
                lda arr77,x                  ; d74b: b5 b0
                eor #%00000001               ; d74d: 49 01
                sta arr77,x                  ; d74f: 95 b0
                lda arr77,x                  ; d751: b5 b0
                ora #%11110000               ; d753: 09 f0
                sta arr1                     ; d755: 85 00
                lda $c49e,x                  ; d757: bd 9e c4
                jsr sub307                   ; d75a: 20 92 d7
+               lda arr77,x                  ; d75d: b5 b0
                beq +                        ; d75f: f0 08
                stx arr1                     ; d761: 86 00
                lda dat80,x                  ; d763: bd 9a c4
                jsr sub307                   ; d766: 20 92 d7
+               dex                          ; d769: ca
                bpl -                        ; d76a: 10 d5
cod507          rts                          ; d76c: 60
sub304          lda ram164                   ; d76d: ad 00 03
                beq cod508                   ; d770: f0 02
                pla                          ; d772: 68
                pla                          ; d773: 68
cod508          rts                          ; d774: 60
cod509          tay                          ; d775: a8
                lda #$f0                     ; d776: a9 f0
                jmp cod510                   ; d778: 4c 8a d7
sub305          lda #$10                     ; d77b: a9 10
                ldy ram21                    ; d77d: a4 24
                beq cod509                   ; d77f: f0 f4
sub306          tay                          ; d781: a8
                lda ram35                    ; d782: a5 3b
                and #%00000010               ; d784: 29 02
                beq cod508                   ; d786: f0 ec
                lda #4                       ; d788: a9 04
cod510          sta arr1                     ; d78a: 85 00
                ldx #0                       ; d78c: a2 00
                tya                          ; d78e: 98
                clc                          ; d78f: 18
                adc #$42                     ; d790: 69 42
sub307          ldy dat81,x                  ; d792: bc a2 c4
                sta ram1                     ; d795: 85 03
                lda #2                       ; d797: a9 02
                sta ram2                     ; d799: 85 04
                txa                          ; d79b: 8a
                pha                          ; d79c: 48
                ldx #0                       ; d79d: a2 00
cod511          sty arr5                     ; d79f: 84 06
                lda arr1                     ; d7a1: a5 00
                bmi +                        ; d7a3: 30 15
                cmp #4                       ; d7a5: c9 04
                beq cod512                   ; d7a7: f0 17
                lda arr40,x                  ; d7a9: b5 51
                and #%00011000               ; d7ab: 29 18
                stx arr9                     ; d7ad: 86 0f
                ldx arr1                     ; d7af: a6 00
                clc                          ; d7b1: 18
                adc dat79,x                  ; d7b2: 7d 96 c4
                ldx arr9                     ; d7b5: a6 0f
                jmp cod514                   ; d7b7: 4c c5 d7
+               ldy #2                       ; d7ba: a0 02
                and #%00001111               ; d7bc: 29 0f
                beq cod513                   ; d7be: f0 02
cod512          ldy arr40,x                  ; d7c0: b4 51
cod513          tya                          ; d7c2: 98
                and #%00000011               ; d7c3: 29 03
cod514          ldy arr5                     ; d7c5: a4 06
                sta (ram1),y                 ; d7c7: 91 03
                inx                          ; d7c9: e8
                dey                          ; d7ca: 88
                dey                          ; d7cb: 88
                dey                          ; d7cc: 88
                dey                          ; d7cd: 88
                bpl cod511                   ; d7ce: 10 cf
                pla                          ; d7d0: 68
                tax                          ; d7d1: aa
                rts                          ; d7d2: 60
sub308          sty ram109                   ; d7d3: 84 ba
                ldy #$3f                     ; d7d5: a0 3f
                sty arr78                    ; d7d7: 84 b9
sub309          sta ram177                   ; d7d9: 8d 91 03
                lda #$11                     ; d7dc: a9 11
                sta ram176                   ; d7de: 8d 90 03
                lda ram109                   ; d7e1: a5 ba
                sta arr1                     ; d7e3: 85 00
                lda arr78                    ; d7e5: a5 b9
                sta arr2                     ; d7e7: 85 01
                lda #$90                     ; d7e9: a9 90
                sta arr3                     ; d7eb: 85 02
                lda #3                       ; d7ed: a9 03
                sta ram1                     ; d7ef: 85 03
                jmp sub395                   ; d7f1: 4c 65 ed

                hex 3f                       ; d7f4

                brk                          ; d7f5: 00
                jsr misc46                   ; d7f6: 20 0f 30
                brk                          ; d7f9: 00

                hex 0f 0f                    ; d7fa

                bmi +                        ; d7fc: 30 00

+               hex 0f 0f                    ; d7fe

                bmi +                        ; d800: 30 00

+               hex 0f 0f                    ; d802

                bmi $d815                    ; d804: 30 0f

                hex 0f 0f                    ; d806

                bmi cod515                   ; d808: 30 27

                hex 0f 0f                    ; d80a

                bmi +                        ; d80c: 30 02

                hex 0f 0f                    ; d80e

+               bmi $d828                    ; d810: 30 16

-               hex 0f 0f                    ; d812

                bmi cod516                   ; d814: 30 2a

                hex 0f 23                    ; d816

                cmp (arr33,x)                ; d818: c1 46
                tax                          ; d81a: aa

                hex 23                       ; d81b

                cmp #6                       ; d81c: c9 06
                cpy #$f0                     ; d81e: c0 f0
                beq -                        ; d820: f0 f0
                beq $d854                    ; d822: f0 30

                hex 23                       ; d824

                cmp (arr5),y                 ; d825: d1 06
                cpy sub467                   ; d827: cc ff ff

                hex ff ff 33 23              ; d82a

                cmp arr199,y                 ; d82e: d9 06 0c

cod515          hex 0f 0f 0f 0f 03 23        ; d831

                sbc (arr5,x)                 ; d837: e1 06

                hex 44                       ; d839

                eor arr44,x                  ; d83a: 55 55
                eor arr44,x                  ; d83c: 55 55
                ora (arr16),y                ; d83e: 11 23
cod516          sbc #6                       ; d840: e9 06

                hex 44                       ; d842

                eor arr44,x                  ; d843: 55 55
                eor arr44,x                  ; d845: 55 55
                ora (arr16),y                ; d847: 11 23
                beq cod517                   ; d849: f0 50
                tax                          ; d84b: aa

                hex 23                       ; d84c

                sbc (arr33),y                ; d84d: f1 46
                eor arr14,x                  ; d84f: 55 20
                brk                          ; d851: 00
                dec misc17,x                 ; d852: de fe 20
                ora (arr97,x)                ; d855: 01 de
                asl arr14,x                  ; d857: 16 20
                asl arr130,x                 ; d859: 1e de 02
                jsr $de1f                    ; d85c: 20 1f de
                inc $bf20,x                  ; d85f: fe 20 bf
                dex                          ; d862: ca
                asl misc66,x                 ; d863: 1e 22 3f
                cmp ram19                    ; d866: c5 1e
                jsr sub320                   ; d868: 20 02 de

                hex 02                       ; d86b

                jsr sub321                   ; d86c: 20 1d de
                asl arr14,x                  ; d86f: 16 20

                hex 07 52                    ; d871

                inc misc31,x                 ; d873: fe 20 27

                hex 52                       ; d876

                inc misc102,x                ; d877: fe 20 47

                hex 52                       ; d87a

                inc arr173,x                 ; d87b: fe 20 06

sub310          hex c3                       ; d87e

sub311          asl arr14,x                  ; d87f: 16 20
                ora arr129,y                 ; d881: 19 c3 02
                jsr misc85                   ; d884: 20 27 44

                hex 1c                       ; d887

                jsr misc86                   ; d888: 20 2e 44

                hex 1c                       ; d88b

                jsr misc87                   ; d88c: 20 35 44

                hex 1c                       ; d88f

                jsr misc88                   ; d890: 20 47 44

                hex 1c                       ; d893

                jsr misc90                   ; d894: 20 4e 44

                hex 1c                       ; d897

                jsr misc92                   ; d898: 20 55 44

cod517          hex 1c                       ; d89b

                jsr sub258                   ; d89c: 20 a1 ca
                ora (arr14,x)                ; d89f: 01 20
                ldx #$ca                     ; d8a1: a2 ca
                brk                          ; d8a3: 00
                jsr sub259                   ; d8a4: 20 bd ca
                ora (arr14,x)                ; d8a7: 01 20
                ldx_absy arr85               ; d8a9: be ca 00
                and (ram129,x)               ; d8ac: 21 e1

                hex 02                       ; d8ae

                ora misc18,x                 ; d8af: 1d 1f 21
                sbc arr212,x                 ; d8b2: fd 02 1d

                hex 1f                       ; d8b5

                jsr $88c3                    ; d8b6: 20 c3 88

                hex 03 04                    ; d8b9

                ora arr14                    ; d8bb: 05 20
                jsr ram180                   ; d8bd: 20 03 04
                ora arr14                    ; d8c0: 05 20
                cpx arr2                     ; d8c2: e4 01
                asl arr15                    ; d8c4: 06 21
                sty arr2                     ; d8c6: 84 01
                asl arr14                    ; d8c8: 06 20
                sta arr64                    ; d8ca: 85 8c
                ora #%00001010               ; d8cc: 09 0a

                hex 07                       ; d8ce

                php                          ; d8cf: 08

                hex 07 07 07 07              ; d8d0

                php                          ; d8d4: 08

                hex 07 0b 0c                 ; d8d5

                jsr misc151                  ; d8d8: 20 86 54
                ora dat21                    ; d8db: 0d 20 a6

                hex 54                       ; d8de

                asl $c621                    ; d8df: 0e 21 c6

                hex 54 0f                    ; d8e2

                and (ram130,x)               ; d8e4: 21 e6

                hex 54                       ; d8e6

                bpl +                        ; d8e7: 10 20
                txs                          ; d8e9: 9a
                sty ram235                   ; d8ea: 8c 11 12

                hex 13 14 13 13 13 13 14 13  ; d8ed

                ora arr12,x                  ; d8f5: 15 18
                jsr ram148                   ; d8f7: 20 fb 01

                hex 17                       ; d8fa

                and (ram86,x)                ; d8fb: 21 9b
                ora (ram13,x)                ; d8fd: 01 17
                jsr $88dc                    ; d8ff: 20 dc 88
                ora arr209,y                 ; d902: 19 1a 1b
                jsr ram242                   ; d905: 20 20 19

                hex 1a                       ; d908
+               hex 1b 22                    ; d909

                and (arr83,x)                ; d90b: 21 c5
                ora (ram20,x)                ; d90d: 01 22

                hex 22                       ; d90f

                cmp arr1                     ; d910: c5 00

                hex 22                       ; d912

                and arr106,x                 ; d913: 3d c5 01

                hex 22                       ; d916

                rol_absx arr83               ; d917: 3e c5 00

                hex 22                       ; d91a

                cmp (arr3,x)                 ; d91b: c1 02
                ora misc22,x                 ; d91d: 1d 1f 22
                cmp arr212,x                 ; d920: dd 02 1d

                hex 1f 22 43 83 03 04        ; d923

                ora ram20                    ; d929: 05 22

                hex 64                       ; d92b

                ora (arr5,x)                 ; d92c: 01 06

                hex 22                       ; d92e

                ora ram73                    ; d92f: 05 87
                ora #%00001010               ; d931: 09 0a

                hex 07                       ; d933

                php                          ; d934: 08

                hex 07 0b 0c 22 5c 83        ; d935

                ora arr209,y                 ; d93b: 19 1a 1b

                hex 22 7b                    ; d93e

                ora (ram13,x)                ; d940: 01 17

                hex 22 1a 87                 ; d942

                ora (ram10),y                ; d945: 11 12

                hex 13 14 13                 ; d947

                ora arr12,x                  ; d94a: 15 18

                hex 22                       ; d94c

                asl arr43                    ; d94d: 06 54
                ora misc30                   ; d94f: 0d 22 26

                hex 54                       ; d952

                asl $a622                    ; d953: 0e 22 a6

                hex 54 0f 22                 ; d956

                dec arr43                    ; d959: c6 54
                bpl $d980                    ; d95b: 10 23

                hex 02                       ; d95d

                cmp ram17                    ; d95e: c5 1c

                hex 23                       ; d960

                ora arr211,x                 ; d961: 1d c5 1c

                hex 23                       ; d964

                bit arr46                    ; d965: 24 58
                ldy misc189,x                ; d967: bc 23 64
                cli                          ; d96a: 58
                lda misc26,x                 ; d96b: bd 23 23

                hex 83                       ; d96e

                lda dat44,y                  ; d96f: b9 ba bb

                hex 23                       ; d972

                and #%10000011               ; d973: 29 83
                lda dat44,y                  ; d975: b9 ba bb

                hex 23 2f 83                 ; d978

                lda dat44,y                  ; d97b: b9 ba bb

                hex 23                       ; d97e

                bmi $d904                    ; d97f: 30 83
                lda dat44,y                  ; d981: b9 ba bb

                hex 23                       ; d984

                rol arr63,x                  ; d985: 36 83
                lda dat44,y                  ; d987: b9 ba bb

                hex 23 3c 83                 ; d98a

                lda dat44,y                  ; d98d: b9 ba bb

                hex 23                       ; d990

                ora ram69                    ; d991: 05 82
                ldx misc27,y                 ; d993: be bf 23

                hex 0b 82                    ; d996

                ldx misc27,y                 ; d998: be bf 23

                hex 12 82                    ; d99b

                ldx misc27,y                 ; d99d: be bf 23
                clc                          ; d9a0: 18

                hex 82                       ; d9a1

                ldx_absy arr81               ; d9a2: be bf 00

                hex 3f                       ; d9a5

                brk                          ; d9a6: 00
                php                          ; d9a7: 08

                hex 0f                       ; d9a8

                bmi cod518                   ; d9a9: 30 2c

                hex 02 0f                    ; d9ab

                bmi $d9e5                    ; d9ad: 30 36
                rol arr14                    ; d9af: 26 20
                tay                          ; d9b1: a8
                bpl cod519                   ; d9b2: 10 43
                eor (arr36,x)                ; d9b4: 41 4c

                hex 43                       ; d9b6

                eor arr36,x                  ; d9b7: 55 4c
                eor (arr43,x)                ; d9b9: 41 54

                hex 4f 52                    ; d9bb

                jsr misc124                  ; d9bd: 20 42 4f
                eor (arr41,x)                ; d9c0: 41 52

                hex 44 23 04                 ; d9c2

                asl arr33,x                  ; d9c5: 16 46
                and (arr25),y                ; d9c7: 31 3a

                hex 2b                       ; d9c9

dat116          jsr misc98                   ; d9ca: 20 20 46

                hex 32 3a                    ; d9cd

                and misc3                    ; d9cf: 2d 20 20
                lsr ram31                    ; d9d2: 46 33

                hex 3a                       ; d9d4

                lda arr14,x                  ; d9d5: b5 20
cod518          jsr misc53                   ; d9d7: 20 46 34

                hex 3a                       ; d9da

                ldx arr16,y                  ; d9db: b6 23
                bit arr11                    ; d9dd: 24 16
                lsr ram32                    ; d9df: 46 35

                hex 3a                       ; d9e1

                plp                          ; d9e2: 28
                jsr misc98                   ; d9e3: 20 20 46
                rol arr25,x                  ; d9e6: 36 3a
                and #%00100000               ; d9e8: 29 20
                jsr misc55                   ; d9ea: 20 46 37

                hex 3a                       ; d9ed

                rol misc3                    ; d9ee: 2e 20 20
                lsr arr24                    ; d9f1: 46 38

                hex 3a                       ; d9f3

                and $d123,x                  ; d9f4: 3d 23 d1
cod519          lsr_absx arr44               ; d9f7: 5e 55 00

                hex 3f                       ; d9fa

                brk                          ; d9fb: 00
                php                          ; d9fc: 08

                hex 0f                       ; d9fd

                bmi $da27                    ; d9fe: 30 27

                hex 07 0f                    ; da00

                bmi +                        ; da02: 30 36
                ora arr28,x                  ; da04: 15 3f
                clc                          ; da06: 18

                hex 04 0f                    ; da07

                rol arr11,x                  ; da09: 36 16

                hex 02                       ; da0b

                jsr ram230                   ; da0c: 20 a9 0e
                eor misc142                  ; da0f: 4d 45 53

                hex 53                       ; da12

                eor (ram39,x)                ; da13: 41 47
                eor arr14                    ; da15: 45 20
                jsr misc124                  ; da17: 20 42 4f
                eor (arr41,x)                ; da1a: 41 52

                hex 44 23                    ; da1c

                cmp (ram49),y                ; da1e: d1 5e
                eor arr1,x                   ; da20: 55 00
                and (ram2,x)                 ; da22: 21 04
                cli                          ; da24: 58
                clv                          ; da25: b8
                and (ram70,x)                ; da26: 21 84
                cli                          ; da28: 58
                clv                          ; da29: b8

                hex 22 04                    ; da2a

                cli                          ; da2c: 58
                clv                          ; da2d: b8

                hex 22                       ; da2e

                sty arr46                    ; da2f: 84 58
                clv                          ; da31: b8
                and (arr31,x)                ; da32: 21 44
                cli                          ; da34: 58
                clv                          ; da35: b8
                and (ram115,x)               ; da36: 21 c4
                cli                          ; da38: 58
                clv                          ; da39: b8

+               hex 22 44                    ; da3a

                cli                          ; da3c: 58
                clv                          ; da3d: b8

                hex 22                       ; da3e

                cpy arr46                    ; da3f: c4 58
                clv                          ; da41: b8

                hex 3f                       ; da42

                php                          ; da43: 08
                bpl +                        ; da44: 10 0f
                bmi $da7e                    ; da46: 30 36

                hex 07 0f                    ; da48

                bmi $da78                    ; da4a: 30 2c

                hex 02 0f                    ; da4c

                rol arr20                    ; da4e: 26 30
                ora arr9,x                   ; da50: 15 0f
                and #%00110000               ; da52: 29 30

                hex 1a                       ; da54
+               hex 23                       ; da55

                cmp #$46                     ; da56: c9 46
                eor arr16,x                  ; da58: 55 23

                hex d7 42                    ; da5a

                brk                          ; da5c: 00

                hex 23 df 42                 ; da5d

                brk                          ; da60: 00

                hex 23 e7 42                 ; da61

                brk                          ; da64: 00

                hex 23                       ; da65

                sbc (arr32),y                ; da66: f1 45
                ora arr16                    ; da68: 05 23
                inc arr2,x                   ; da6a: f6 01
-               ora ram243                   ; da6c: 0d 23 1a

                hex 02                       ; da6f

                sbc misc28,y                 ; da70: f9 fb 23

                hex 3a 02 fa fc              ; da73

                jsr misc133                  ; da77: 20 88 50
                sbc $c820                    ; da7a: ed 20 c8
                bvc -                        ; da7d: 50 ed
                jsr $8387                    ; da7f: 20 87 83

                hex ef                       ; da82

                inc misc16                   ; da83: ee f1 20
                tya                          ; da86: 98

                hex 83                       ; da87

                beq $da78                    ; da88: f0 ee

                hex f2                       ; da8a

                jsr misc159                  ; da8b: 20 63 5a
                inc arr16,x                  ; da8e: f6 23

                hex 43 5a                    ; da90

                inc arr14,x                  ; da92: f6 20

                hex 82                       ; da94

                dec arr101,x                 ; da95: d6 f4
                jsr sub301                   ; da97: 20 9d d6

                hex f4                       ; da9a

                jsr ram145                   ; da9b: 20 62 01

                hex f3                       ; da9e

                jsr ram146                   ; da9f: 20 7d 01

                hex f7 23 42                 ; daa2

                ora (arr102,x)               ; daa5: 01 f5

                hex 23                       ; daa7

                eor $f801,x                  ; daa8: 5d 01 f8
                jsr misc286                  ; daab: 20 00 7f

                hex ff                       ; daae

                jsr misc172                  ; daaf: 20 3f 61

                hex ff 23                    ; dab2

                rts                          ; dab4: 60

                hex 7f ff 23 9f              ; dab5

                adc (arr105,x)               ; dab9: 61 ff
                jsr $d860                    ; dabb: 20 60 d8

dat117          hex ff                       ; dabe

                jsr $d861                    ; dabf: 20 61 d8

                hex ff                       ; dac2

                jsr sub310                   ; dac3: 20 7e d8

                hex ff                       ; dac6

                jsr sub311                   ; dac7: 20 7f d8

                hex ff                       ; daca

                brk                          ; dacb: 00

                hex 3f                       ; dacc

                brk                          ; dacd: 00
                php                          ; dace: 08

                hex 0f                       ; dacf

                bmi cod520                   ; dad0: 30 15
                ora arr9                     ; dad2: 05 0f
                bmi cod521                   ; dad4: 30 2c
                ora (arr14),y                ; dad6: 11 20
                tax                          ; dad8: aa

                hex 0c                       ; dad9

dat118          eor misc145                  ; dada: 4d 55 53
                eor #%01000011               ; dadd: 49 43
                jsr misc80                   ; dadf: 20 20 42

                hex 4f                       ; dae2

                eor (arr41,x)                ; dae3: 41 52

                hex 44 22                    ; dae5

cod520          inx                          ; dae7: e8
                ora arr33                    ; dae8: 05 46
                eor (arr42,x)                ; daea: 41 53

                hex 54 3c 22                 ; daec

                sbc misc37                   ; daef: ed 46 2d

                hex 22 f3                    ; daf2

                ora arr27                    ; daf4: 05 3e

                hex 53                       ; daf6

                jmp misc154                  ; daf7: 4c 4f 57

                hex 23 04                    ; dafa

                ora arr33,x                  ; dafc: 15 46
                and (arr19),y                ; dafe: 31 2d
                lsr arr23                    ; db00: 46 37

cod521          hex 3a                       ; db02

                lda ram75                    ; db03: a5 89

                hex 7f b7                    ; db05

                ror misc216                  ; db07: 6e 86 6b
                jsr misc57                   ; db0a: 20 46 38

                hex 3a 63                    ; db0d

                sty misc181                  ; db0f: 8c 6e 62

                hex 23                       ; db12

                and ram12                    ; db13: 25 15
                plp                          ; db15: 28

                hex 23                       ; db16

                and #%00100000               ; db17: 29 20

                hex 3a 43 44                 ; db19

                eor arr33                    ; db1c: 45 46

                hex 47                       ; db1e

                eor (arr29,x)                ; db1f: 41 42
                jsr misc29                   ; db21: 20 20 24

                hex 3a 67 87                 ; db24

                adc ram52                    ; db27: 65 63

                hex 6b 23                    ; db29

                cmp (ram49),y                ; db2b: d1 5e
                sta arr1,y                   ; db2d: 99 00 00

                hex 04                       ; db30

                php                          ; db31: 08

                hex 04                       ; db32

                rti                          ; db33: 40

                hex 44                       ; db34

                rti                          ; db35: 40

                hex 44                       ; db36

                cli                          ; db37: 58

                hex 5c                       ; db38

                cli                          ; db39: 58

                hex 5c                       ; db3a

                rts                          ; db3b: 60

                hex 64                       ; db3c

                rts                          ; db3d: 60

                hex 64 1c                    ; db3e

                jsr ram244                   ; db40: 20 24 1c
                clv                          ; db43: b8
                ldy dat47,x                  ; db44: bc b8 bc
                cpy #$c4                     ; db47: c0 c4
                cpy #$c4                     ; db49: c0 c4
                iny                          ; db4b: c8
                cpy dat99                    ; db4c: cc c8 cc

dat119          hex 2f 33 37 3b 3f 43 47 4b  ; db4f
dat120          hex db db db db db db db db  ; db57
                hex 14 0f                    ; db5f

                rol arr11,x                  ; db61: 36 16

                hex 02 14 0f                 ; db63

                bmi $db7d                    ; db66: 30 15

                hex 12 14 0f                 ; db68

                bmi +                        ; db6b: 30 12
                asl arr10,x                  ; db6d: 16 14

                hex 0f                       ; db6f

                bmi $db98                    ; db70: 30 26

                hex 12 14 0f                 ; db72

                and arr17,x                  ; db75: 35 25

                hex 17 14 0f                 ; db77

                bmi cod522                   ; db7a: 30 26
                ora arr204,y                 ; db7c: 19 14 0f
+               bmi +                        ; db7f: 30 02
                asl arr10,x                  ; db81: 16 14

+               hex 0f                       ; db83

                bmi cod523                   ; db84: 30 26

                hex 12                       ; db86
dat121          hex 5f 64                    ; db87

                adc #$6e                     ; db89: 69 6e

                hex 73                       ; db8b

                sei                          ; db8c: 78
                adc $db82,x                  ; db8d: 7d 82 db

                hex db db db db db db db     ; db90

                lda arr61                    ; db97: a5 79
                bne cod525                   ; db99: d0 26
                jsr sub313                   ; db9b: 20 e2 db
                lda ram65                    ; db9e: a5 7d
                bne cod524                   ; dba0: d0 19
cod522          lda arr23                    ; dba2: a5 37
                cmp #$0b                     ; dba4: c9 0b
                beq cod526                   ; dba6: f0 1c
                cmp #$0c                     ; dba8: c9 0c
                beq cod528                   ; dbaa: f0 1d
cod523          cmp #$1b                     ; dbac: c9 1b
                bne +                        ; dbae: d0 06
                jsr sub312                   ; dbb0: 20 cd db
                jmp cod531                   ; dbb3: 4c 9b dc
+               ldx #1                       ; dbb6: a2 01
                jmp sub402                   ; dbb8: 4c 2c ef
cod524          jsr sub277                   ; dbbb: 20 97 d1
                jmp sub434                   ; dbbe: 4c 0f f5
cod525          jmp sub280                   ; dbc1: 4c 27 d2
cod526          lda #$ff                     ; dbc4: a9 ff
cod527          sta ram65                    ; dbc6: 85 7d
                rts                          ; dbc8: 60
cod528          lda #1                       ; dbc9: a9 01
                bne cod527                   ; dbcb: d0 f9
sub312          ldx #0                       ; dbcd: a2 00
-               lda arr176,x                 ; dbcf: bd 3d 06
                sta misc258,x                ; dbd2: 9d 00 74
                inx                          ; dbd5: e8
                bne -                        ; dbd6: d0 f7
-               lda arr195,x                 ; dbd8: bd 3d 07
                sta misc262,x                ; dbdb: 9d 00 75
                inx                          ; dbde: e8
                bne -                        ; dbdf: d0 f7
                rts                          ; dbe1: 60
sub313          lda ram34                    ; dbe2: a5 39
                beq +                        ; dbe4: f0 02
                inc ram106                   ; dbe6: e6 b6
+               lda ram24                    ; dbe8: a5 28
                beq cod529                   ; dbea: f0 1a
                lda ram104                   ; dbec: a5 b4
                bne +                        ; dbee: d0 0d
                lda #8                       ; dbf0: a9 08
                sta ram104                   ; dbf2: 85 b4
                lda ram102                   ; dbf4: a5 b2
                clc                          ; dbf6: 18
                adc #1                       ; dbf7: 69 01
                and #%00000011               ; dbf9: 29 03
                sta ram102                   ; dbfb: 85 b2
+               dec ram104                   ; dbfd: c6 b4
                lda ram104                   ; dbff: a5 b4
                and #%00000011               ; dc01: 29 03
                beq cod530                   ; dc03: f0 0c
                rts                          ; dc05: 60
cod529          lda ram106                   ; dc06: a5 b6
                beq +                        ; dc08: f0 06
                lda #$10                     ; dc0a: a9 10
                sta ram24                    ; dc0c: 85 28
                dec ram106                   ; dc0e: c6 b6
+               rts                          ; dc10: 60
cod530          lda ram103                   ; dc11: a5 b3
                sec                          ; dc13: 38
                sbc #1                       ; dc14: e9 01
                sta ram103                   ; dc16: 85 b3
                lda ram103                   ; dc18: a5 b3
                bne +                        ; dc1a: d0 0d
                lda ram105                   ; dc1c: a5 b5
                clc                          ; dc1e: 18
                adc #1                       ; dc1f: 69 01
                and #%00000111               ; dc21: 29 07
                sta ram105                   ; dc23: 85 b5
                tay                          ; dc25: a8
                jsr sub314                   ; dc26: 20 4e dc
+               lda ram103                   ; dc29: a5 b3
                sta arr1                     ; dc2b: 85 00
                lda #$bf                     ; dc2d: a9 bf
                sta arr2                     ; dc2f: 85 01
                ldy ram105                   ; dc31: a4 b5
                lda dat119,y                 ; dc33: b9 4f db
                sta ram1                     ; dc36: 85 03
                lda dat120,y                 ; dc38: b9 57 db
                sta ram2                     ; dc3b: 85 04
                ldy ram102                   ; dc3d: a4 b2
                lda (ram1),y                 ; dc3f: b1 03
                sta arr3                     ; dc41: 85 02
                lda #$22                     ; dc43: a9 22
                sta ram1                     ; dc45: 85 03
                lda #0                       ; dc47: a9 00
                sta ram2                     ; dc49: 85 04
                jmp sub391                   ; dc4b: 4c be ec
sub314          lda #$18                     ; dc4e: a9 18
                sta arr1                     ; dc50: 85 00
                lda #$3f                     ; dc52: a9 3f
                sta arr2                     ; dc54: 85 01
                lda dat121,y                 ; dc56: b9 87 db
                sta arr3                     ; dc59: 85 02
                lda $db8f,y                  ; dc5b: b9 8f db
                sta ram1                     ; dc5e: 85 03
                jmp sub395                   ; dc60: 4c 65 ed
                ldy ram54                    ; dc63: a4 66
                ror $8c6d,x                  ; dc65: 7e 6d 8c
                ora misc39                   ; dc68: 0d 64 2d
                ldx arr19                    ; dc6b: a6 2d

                hex 7b                       ; dc6d

                txa                          ; dc6e: 8a
                and misc186                  ; dc6f: 2d 0d 63

dat122          hex dc 63 dc                 ; dc72

                adc #$dc                     ; dc75: 69 dc
dat123          lda arr61                    ; dc77: a5 79
                bne cod537                   ; dc79: d0 71
                lda ram65                    ; dc7b: a5 7d
                bne cod535                   ; dc7d: d0 62
                lda ram124                   ; dc7f: a5 d8
                bne cod534                   ; dc81: d0 44
                lda ram38                    ; dc83: a5 41
                bne cod533                   ; dc85: d0 3f
                lda arr23                    ; dc87: a5 37
                cmp #$0b                     ; dc89: c9 0b
                beq cod538                   ; dc8b: f0 63
                cmp #$0c                     ; dc8d: c9 0c
                beq cod540                   ; dc8f: f0 64
                cmp #$1b                     ; dc91: c9 1b
                bne cod532                   ; dc93: d0 1b
                jsr sub430                   ; dc95: 20 b1 f4
                jsr sub325                   ; dc98: 20 9a df
cod531          lda #$5a                     ; dc9b: a9 5a
                sta misc239                  ; dc9d: 8d 3a 70
                lda #$cc                     ; dca0: a9 cc
                sta misc240                  ; dca2: 8d 3b 70
                lda #0                       ; dca5: a9 00
                sta arr104                   ; dca7: 85 fc
                lda #1                       ; dca9: a9 01
                sta ram143                   ; dcab: 85 fe
                jmp sub266                   ; dcad: 4c 13 cf
cod532          ldx #0                       ; dcb0: a2 00
                jsr sub402                   ; dcb2: 20 2c ef
                lda arr77                    ; dcb5: a5 b0
                beq +                        ; dcb7: f0 06
                jsr sub323                   ; dcb9: 20 5a de
                sta ram38                    ; dcbc: 85 41
                rts                          ; dcbe: 60
+               lda arr25                    ; dcbf: a5 3a
                beq cod533                   ; dcc1: f0 03
                jsr sub429                   ; dcc3: 20 73 f4
cod533          rts                          ; dcc6: 60
cod534          lda ram124                   ; dcc7: a5 d8
                cmp #1                       ; dcc9: c9 01
                bne +                        ; dccb: d0 04
                jsr sub322                   ; dccd: 20 31 de
                rts                          ; dcd0: 60
+               cmp #2                       ; dcd1: c9 02
                bne +                        ; dcd3: d0 04
                jsr sub315                   ; dcd5: 20 f9 dc
                rts                          ; dcd8: 60
+               cmp #3                       ; dcd9: c9 03
                bne cod536                   ; dcdb: d0 07
                jsr sub317                   ; dcdd: 20 75 dd
                rts                          ; dce0: 60
cod535          jsr sub277                   ; dce1: 20 97 d1
cod536          jsr sub434                   ; dce4: 20 0f f5
                lda #0                       ; dce7: a9 00
                sta ram124                   ; dce9: 85 d8
                rts                          ; dceb: 60
cod537          jsr sub280                   ; dcec: 20 27 d2
                rts                          ; dcef: 60
cod538          lda #$ff                     ; dcf0: a9 ff
cod539          sta ram65                    ; dcf2: 85 7d
                rts                          ; dcf4: 60
cod540          lda #1                       ; dcf5: a9 01
                bne cod539                   ; dcf7: d0 f9
sub315          lda arr15                    ; dcf9: a5 21
                beq +                        ; dcfb: f0 01
                rts                          ; dcfd: 60
+               lda #8                       ; dcfe: a9 08
                sta arr15                    ; dd00: 85 21
                ldx arr94                    ; dd02: a6 da
                lda arr142,x                 ; dd04: bd f0 03
                sta arr96                    ; dd07: 85 dd
                sta arr97                    ; dd09: 85 de
                cmp #$0d                     ; dd0b: c9 0d
                bne sub316                   ; dd0d: d0 36
-               lda ram29                    ; dd0f: a5 2f
                cmp #$bf                     ; dd11: c9 bf
                bcs +                        ; dd13: b0 0d
                cmp ram106                   ; dd15: c5 b6
                beq +                        ; dd17: f0 09
                jsr sub412                   ; dd19: 20 10 f2
                jsr sub406                   ; dd1c: 20 15 f1
                jmp -                        ; dd1f: 4c 0f dd
+               lda #$20                     ; dd22: a9 20
                sta arr96                    ; dd24: 85 dd
                ldx ram106                   ; dd26: a6 b6
                lda arr176,x                 ; dd28: bd 3d 06
                cmp #$20                     ; dd2b: c9 20
                bne +                        ; dd2d: d0 04
                lda #0                       ; dd2f: a9 00
                sta ram125                   ; dd31: 85 d9
+               jsr sub316                   ; dd33: 20 45 dd
                lda #3                       ; dd36: a9 03
                sta ram124                   ; dd38: 85 d8
                lda #0                       ; dd3a: a9 00
                sta arr94                    ; dd3c: 85 da
                dec ram125                   ; dd3e: c6 d9
                lda #$40                     ; dd40: a9 40
                sta arr105                   ; dd42: 85 ff
                rts                          ; dd44: 60
sub316          jsr sub422                   ; dd45: 20 f8 f3
                jsr sub412                   ; dd48: 20 10 f2
                jsr sub425                   ; dd4b: 20 17 f4
                jsr sub406                   ; dd4e: 20 15 f1
                lda arr96                    ; dd51: a5 dd
                sta arr134                   ; dd53: 8d 04 03
                lda ram125                   ; dd56: a5 d9
                beq +                        ; dd58: f0 02
                inc ram125                   ; dd5a: e6 d9
+               ldy ram106                   ; dd5c: a4 b6
                lda arr176,y                 ; dd5e: b9 3d 06
                cmp #$20                     ; dd61: c9 20
                bne +                        ; dd63: d0 02
                inc ram125                   ; dd65: e6 d9
+               lda arr96                    ; dd67: a5 dd
                sta arr176,y                 ; dd69: 99 3d 06
                inc ram106                   ; dd6c: e6 b6
                inc arr94                    ; dd6e: e6 da
                lda #8                       ; dd70: a9 08
                sta arr105                   ; dd72: 85 ff
                rts                          ; dd74: 60
sub317          lda ram125                   ; dd75: a5 d9
                beq cod541                   ; dd77: f0 2b
                ldx ram106                   ; dd79: a6 b6
                lda arr176,x                 ; dd7b: bd 3d 06
                cmp #$20                     ; dd7e: c9 20
                beq +                        ; dd80: f0 19
                lda #$20                     ; dd82: a9 20
                sta arr176,x                 ; dd84: 9d 3d 06
                jsr sub422                   ; dd87: 20 f8 f3
                jsr sub425                   ; dd8a: 20 17 f4
                lda #$20                     ; dd8d: a9 20
                sta arr134                   ; dd8f: 8d 04 03
                inc ram106                   ; dd92: e6 b6
                ldx ram106                   ; dd94: a6 b6
                cpx #$d7                     ; dd96: e0 d7
                bcs +                        ; dd98: b0 01
                rts                          ; dd9a: 60
+               lda #$20                     ; dd9b: a9 20
                sta arr176,x                 ; dd9d: 9d 3d 06
                lda #0                       ; dda0: a9 00
                sta ram125                   ; dda2: 85 d9
cod541          lda #4                       ; dda4: a9 04
                sta ram124                   ; dda6: 85 d8
                rts                          ; dda8: 60
sub318          ldx #0                       ; dda9: a2 00
-               lda #$20                     ; ddab: a9 20
                sta arr142,x                 ; ddad: 9d f0 03
                inx                          ; ddb0: e8
                cpx #$10                     ; ddb1: e0 10
                bcc -                        ; ddb3: 90 f6
                ldx #0                       ; ddb5: a2 00
                ldy #0                       ; ddb7: a0 00
                lda ram193                   ; ddb9: ad 3a 04
                cmp #$20                     ; ddbc: c9 20
                beq cod542                   ; ddbe: f0 06
                lda #$2d                     ; ddc0: a9 2d
                sta arr142,y                 ; ddc2: 99 f0 03
                iny                          ; ddc5: c8
cod542          lda arr155,x                 ; ddc6: bd 30 04
                cmp #$30                     ; ddc9: c9 30
                bne +                        ; ddcb: d0 12
                inx                          ; ddcd: e8
                cpx #9                       ; ddce: e0 09
                bcc cod542                   ; ddd0: 90 f4
                lda #$30                     ; ddd2: a9 30
                sta arr142                   ; ddd4: 8d f0 03
                lda #$0d                     ; ddd7: a9 0d
                sta ram179                   ; ddd9: 8d f1 03
                jmp cod544                   ; dddc: 4c fc dd
+               cmp #$2e                     ; dddf: c9 2e
                bne cod543                   ; dde1: d0 08
                lda arr154,x                 ; dde3: bd 2f 04
dat124          cmp #$30                     ; dde6: c9 30
                bne cod543                   ; dde8: d0 01
                dex                          ; ddea: ca
cod543          lda arr155,x                 ; ddeb: bd 30 04
                sta arr142,y                 ; ddee: 99 f0 03
                inx                          ; ddf1: e8
                iny                          ; ddf2: c8
                cpx #9                       ; ddf3: e0 09
                bcc cod543                   ; ddf5: 90 f4
                lda #$0d                     ; ddf7: a9 0d
                sta arr142,y                 ; ddf9: 99 f0 03
cod544          lda #1                       ; ddfc: a9 01
                sta ram124                   ; ddfe: 85 d8
                rts                          ; de00: 60
sub319          asl a                        ; de01: 0a
sub320          tax                          ; de02: aa
                lda $dc71,x                  ; de03: bd 71 dc
                sta arr1                     ; de06: 85 00
                lda dat122,x                 ; de08: bd 72 dc
                sta arr2                     ; de0b: 85 01
                ldx #0                       ; de0d: a2 00
-               lda #$20                     ; de0f: a9 20
                sta arr142,x                 ; de11: 9d f0 03
                inx                          ; de14: e8
                cpx #$10                     ; de15: e0 10
                bcc -                        ; de17: 90 f6
                ldy #0                       ; de19: a0 00
cod545          lda (arr1),y                 ; de1b: b1 00
sub321          sta arr142,y                 ; de1d: 99 f0 03
                cmp #$0d                     ; de20: c9 0d
                beq +                        ; de22: f0 04
                iny                          ; de24: c8
                jmp cod545                   ; de25: 4c 1b de
+               lda #1                       ; de28: a9 01
                sta ram124                   ; de2a: 85 d8
                lda #0                       ; de2c: a9 00
                sta arr78                    ; de2e: 85 b9
                rts                          ; de30: 60
sub322          lda #$e4                     ; de31: a9 e4
                sta ram32                    ; de33: 85 35
                lda #$20                     ; de35: a9 20
                sta ram31                    ; de37: 85 33
                ldx #$ff                     ; de39: a2 ff
-               jsr sub425                   ; de3b: 20 17 f4
                inx                          ; de3e: e8
                cpx ram29                    ; de3f: e4 2f
                bne -                        ; de41: d0 f8
-               lda arr176,x                 ; de43: bd 3d 06
                cmp #$3d                     ; de46: c9 3d
                beq +                        ; de48: f0 08
                jsr sub425                   ; de4a: 20 17 f4
                inx                          ; de4d: e8
                cpx #$e0                     ; de4e: e0 e0
                bcc -                        ; de50: 90 f1
+               inx                          ; de52: e8
                stx ram106                   ; de53: 86 b6
                lda #2                       ; de55: a9 02
                sta ram124                   ; de57: 85 d8
                rts                          ; de59: 60
sub323          jsr sub324                   ; de5a: 20 8f df
                jsr sub343                   ; de5d: 20 d2 e3
                ldy #0                       ; de60: a0 00
                ldx ram29                    ; de62: a6 2f
                beq cod548                   ; de64: f0 46
-               dex                          ; de66: ca
                lda arr176,x                 ; de67: bd 3d 06
                cmp #$20                     ; de6a: c9 20
                beq +                        ; de6c: f0 0b
                cmp #$3d                     ; de6e: c9 3d
                beq cod548                   ; de70: f0 3a
                cpx #0                       ; de72: e0 00
                beq cod546                   ; de74: f0 04
                jmp -                        ; de76: 4c 66 de
+               inx                          ; de79: e8
cod546          stx ram112                   ; de7a: 86 c0
-               lda arr176,x                 ; de7c: bd 3d 06
                sta misc268,y                ; de7f: 99 00 76
                cmp #$3d                     ; de82: c9 3d
                beq +                        ; de84: f0 09
                iny                          ; de86: c8
                inx                          ; de87: e8
                cpx #$e0                     ; de88: e0 e0
                bne -                        ; de8a: d0 f0
                lda #0                       ; de8c: a9 00
                rts                          ; de8e: 60
+               ldx ram112                   ; de8f: a6 c0
                lda #0                       ; de91: a9 00
                sta arr79                    ; de93: 85 bc
                sta ram109                   ; de95: 85 ba
                sta arr80                    ; de97: 85 bd
                sta ram104                   ; de99: 85 b4
                sta ram111                   ; de9b: 85 be
                sta ram105                   ; de9d: 85 b5
                sta ram103                   ; de9f: 85 b3
                sta ram102                   ; dea1: 85 b2
cod547          lda arr176,x                 ; dea3: bd 3d 06
                sta arr9                     ; dea6: 85 0f
                cmp #$20                     ; dea8: c9 20
                bne cod549                   ; deaa: d0 03
cod548          jmp cod557                   ; deac: 4c 89 df
cod549          cmp #$2e                     ; deaf: c9 2e
                bne cod550                   ; deb1: d0 14
                lda ram105                   ; deb3: a5 b5
                beq +                        ; deb5: f0 03
                jmp cod557                   ; deb7: 4c 89 df
+               lda ram111                   ; deba: a5 be
                beq cod548                   ; debc: f0 ee
                lda #1                       ; debe: a9 01
                sta ram105                   ; dec0: 85 b5
                sta ram103                   ; dec2: 85 b3
                jmp cod556                   ; dec4: 4c 7e df
cod550          cmp #$30                     ; dec7: c9 30
                bcc cod551                   ; dec9: 90 22
                cmp #$3a                     ; decb: c9 3a
                bcs cod551                   ; decd: b0 1e
                lda ram109                   ; decf: a5 ba
                bne cod548                   ; ded1: d0 d9
                lda #0                       ; ded3: a9 00
                sta ram103                   ; ded5: 85 b3
                lda ram111                   ; ded7: a5 be
                bne +                        ; ded9: d0 07
                sta arr80                    ; dedb: 85 bd
                inc ram111                   ; dedd: e6 be
                jmp cod556                   ; dedf: 4c 7e df
+               inc ram111                   ; dee2: e6 be
                lda ram111                   ; dee4: a5 be
                cmp #9                       ; dee6: c9 09
                bpl cod552                   ; dee8: 10 1a
                jmp cod556                   ; deea: 4c 7e df
cod551          cmp #$2b                     ; deed: c9 2b
                beq +                        ; deef: f0 0f
                cmp #$2d                     ; def1: c9 2d
                beq +                        ; def3: f0 0b
                cmp #$b5                     ; def5: c9 b5
                beq +                        ; def7: f0 07
                cmp #$b6                     ; def9: c9 b6
                beq +                        ; defb: f0 03
                jmp cod555                   ; defd: 4c 2a df
+               lda arr80                    ; df00: a5 bd
                beq cod553                   ; df02: f0 03
cod552          jmp cod557                   ; df04: 4c 89 df
cod553          lda ram103                   ; df07: a5 b3
                bne cod548                   ; df09: d0 a1
                lda arr9                     ; df0b: a5 0f
                cmp #$b5                     ; df0d: c9 b5
                beq +                        ; df0f: f0 04
                cmp #$b6                     ; df11: c9 b6
                bne cod554                   ; df13: d0 04
+               lda ram111                   ; df15: a5 be
                beq cod557                   ; df17: f0 70
cod554          lda #1                       ; df19: a9 01
                sta arr80                    ; df1b: 85 bd
                sta ram104                   ; df1d: 85 b4
                lda #0                       ; df1f: a9 00
                sta ram111                   ; df21: 85 be
                sta ram105                   ; df23: 85 b5
                sta ram109                   ; df25: 85 ba
                jmp cod556                   ; df27: 4c 7e df
cod555          cmp #$28                     ; df2a: c9 28
                bne +                        ; df2c: d0 17
                lda ram109                   ; df2e: a5 ba
                bne cod557                   ; df30: d0 57
                lda ram111                   ; df32: a5 be
                bne cod557                   ; df34: d0 53
                lda arr79                    ; df36: a5 bc
                bne cod557                   ; df38: d0 4f
                sta arr80                    ; df3a: 85 bd
                sta ram111                   ; df3c: 85 be
                lda #1                       ; df3e: a9 01
                sta arr79                    ; df40: 85 bc
                jmp cod556                   ; df42: 4c 7e df
+               cmp #$29                     ; df45: c9 29
                bne +                        ; df47: d0 21
                lda arr79                    ; df49: a5 bc
                beq cod557                   ; df4b: f0 3c
                lda arr80                    ; df4d: a5 bd
                bne cod557                   ; df4f: d0 38
                lda ram111                   ; df51: a5 be
                beq cod557                   ; df53: f0 34
                inc ram102                   ; df55: e6 b2
                lda ram102                   ; df57: a5 b2
                cmp #$0b                     ; df59: c9 0b
                bpl cod557                   ; df5b: 10 2c
                lda #0                       ; df5d: a9 00
                sta arr79                    ; df5f: 85 bc
                sta arr80                    ; df61: 85 bd
                lda #1                       ; df63: a9 01
                sta ram109                   ; df65: 85 ba
                jmp cod556                   ; df67: 4c 7e df
+               cmp #$3d                     ; df6a: c9 3d
                bne cod557                   ; df6c: d0 1b
                lda ram104                   ; df6e: a5 b4
                beq cod557                   ; df70: f0 17
                lda arr79                    ; df72: a5 bc
                ora arr80                    ; df74: 05 bd
                beq +                        ; df76: f0 03
                jmp cod557                   ; df78: 4c 89 df
+               lda #1                       ; df7b: a9 01
                rts                          ; df7d: 60
cod556          inx                          ; df7e: e8
                cpx #$d7                     ; df7f: e0 d7
                bcc +                        ; df81: 90 03
                jmp cod557                   ; df83: 4c 89 df
+               jmp cod547                   ; df86: 4c a3 de
cod557          lda #1                       ; df89: a9 01
                jsr sub319                   ; df8b: 20 01 de
                rts                          ; df8e: 60
sub324          lda #0                       ; df8f: a9 00
                ldy #0                       ; df91: a0 00
-               sta misc268,y                ; df93: 99 00 76
                dey                          ; df96: 88
                bne -                        ; df97: d0 fa
                rts                          ; df99: 60
sub325          ldx #$d8                     ; df9a: a2 d8
-               lda arr175,x                 ; df9c: bd 3c 06
                sta misc247,x                ; df9f: 9d ff 70
                dex                          ; dfa2: ca
                bne -                        ; dfa3: d0 f7
                rts                          ; dfa5: 60
sub326          lda #0                       ; dfa6: a9 00
                sta arr82                    ; dfa8: 85 c3
                sta ram126                   ; dfaa: 85 db
                sta arr95                    ; dfac: 85 dc
                sta ram101                   ; dfae: 85 b1
-               lda #1                       ; dfb0: a9 01
                sta ram112                   ; dfb2: 85 c0
                lda #$ff                     ; dfb4: a9 ff
                sta ram113                   ; dfb6: 85 c1
                lda #$28                     ; dfb8: a9 28
                sta arr1                     ; dfba: 85 00
                lda #$ff                     ; dfbc: a9 ff
                sta arr2                     ; dfbe: 85 01
                jsr sub333                   ; dfc0: 20 f8 e1
                bne +                        ; dfc3: d0 07
                jsr sub327                   ; dfc5: 20 d3 df
                jsr sub327                   ; dfc8: 20 d3 df
                rts                          ; dfcb: 60
+               jsr sub328                   ; dfcc: 20 ec df
                jmp -                        ; dfcf: 4c b0 df
                rts                          ; dfd2: 60
sub327          lda #$b5                     ; dfd3: a9 b5
                sta arr1                     ; dfd5: 85 00
                lda #$b6                     ; dfd7: a9 b6
                sta arr2                     ; dfd9: 85 01
                jsr sub333                   ; dfdb: 20 f8 e1
                beq +                        ; dfde: f0 08
                jsr sub330                   ; dfe0: 20 be e0
                lda ram101                   ; dfe3: a5 b1
                bne sub327                   ; dfe5: d0 ec
                rts                          ; dfe7: 60
+               jsr sub329                   ; dfe8: 20 66 e0
                rts                          ; dfeb: 60
sub328          lda #$80                     ; dfec: a9 80
                sta arr83                    ; dfee: 85 c5
cod558          lda arr81                    ; dff0: a5 bf
                clc                          ; dff2: 18
                adc #1                       ; dff3: 69 01
                sta ram112                   ; dff5: 85 c0
                lda #$29                     ; dff7: a9 29
                sta arr1                     ; dff9: 85 00
                lda #$ff                     ; dffb: a9 ff
                sta arr2                     ; dffd: 85 01
                jsr sub334                   ; dfff: 20 fc e1
                lda arr81                    ; e002: a5 bf
                sta ram113                   ; e004: 85 c1
                lda ram112                   ; e006: a5 c0
                sec                          ; e008: 38
                sbc #1                       ; e009: e9 01
                tax                          ; e00b: aa
                lda #$41                     ; e00c: a9 41
                sta misc267,x                ; e00e: 9d ff 75
                ldx ram113                   ; e011: a6 c1
                lda #$42                     ; e013: a9 42
                sta misc267,x                ; e015: 9d ff 75
                jsr sub327                   ; e018: 20 d3 df
                jsr sub327                   ; e01b: 20 d3 df
                lda arr83                    ; e01e: a5 c5
                and #%01111111               ; e020: 29 7f
                tay                          ; e022: a8
                ldx #0                       ; e023: a2 00
-               lda arr155,x                 ; e025: bd 30 04
                sta arr141,y                 ; e028: 99 8c 03
                inx                          ; e02b: e8
                iny                          ; e02c: c8
                cpx #9                       ; e02d: e0 09
                bne -                        ; e02f: d0 f4
                lda ram193                   ; e031: ad 3a 04
                sta arr141,y                 ; e034: 99 8c 03
                ldx ram112                   ; e037: a6 c0
                lda arr83                    ; e039: a5 c5
                sta misc267,x                ; e03b: 9d ff 75
                lda arr83                    ; e03e: a5 c5
                clc                          ; e040: 18
                adc #$0a                     ; e041: 69 0a
                sta arr83                    ; e043: 85 c5
                lda ram113                   ; e045: a5 c1
                clc                          ; e047: 18
                adc #1                       ; e048: 69 01
                sta arr81                    ; e04a: 85 bf
                jsr sub343                   ; e04c: 20 d2 e3
                lda #$28                     ; e04f: a9 28
                sta arr1                     ; e051: 85 00
                lda #$ff                     ; e053: a9 ff
                sta arr2                     ; e055: 85 01
                jsr sub334                   ; e057: 20 fc e1
                pha                          ; e05a: 48
                lda #0                       ; e05b: a9 00
                sta arr82                    ; e05d: 85 c3
                pla                          ; e05f: 68
                beq +                        ; e060: f0 03
                jmp cod558                   ; e062: 4c f0 df
+               rts                          ; e065: 60
sub329          lda #$2b                     ; e066: a9 2b
                sta arr1                     ; e068: 85 00
                lda #$2d                     ; e06a: a9 2d
                sta arr2                     ; e06c: 85 01
                jsr sub333                   ; e06e: 20 f8 e1
                bne cod559                   ; e071: d0 01
                rts                          ; e073: 60
cod559          ldx arr81                    ; e074: a6 bf
                lda #$20                     ; e076: a9 20
                sta misc267,x                ; e078: 9d ff 75
                lda arr82                    ; e07b: a5 c3
                bne +                        ; e07d: d0 06
                jsr sub339                   ; e07f: 20 8b e3
                jmp cod560                   ; e082: 4c 88 e0
+               jsr sub340                   ; e085: 20 9a e3
cod560          lda ram115                   ; e088: a5 c4
                cmp #$2b                     ; e08a: c9 2b
                bne +                        ; e08c: d0 06
                jsr sub355                   ; e08e: 20 e9 e6
                jmp cod561                   ; e091: 4c 97 e0
+               jsr sub357                   ; e094: 20 4b e7
cod561          ldx #9                       ; e097: a2 09
-               lda arr154,x                 ; e099: bd 2f 04
                sta arr152,x                 ; e09c: 9d 1f 04
                dex                          ; e09f: ca
                bne -                        ; e0a0: d0 f7
                lda ram193                   ; e0a2: ad 3a 04
                sta ram187                   ; e0a5: 8d 2a 04
                lda #1                       ; e0a8: a9 01
                sta arr82                    ; e0aa: 85 c3
                lda ram114                   ; e0ac: a5 c2
                sta arr81                    ; e0ae: 85 bf
                lda #$2b                     ; e0b0: a9 2b
                sta arr1                     ; e0b2: 85 00
                lda #$2d                     ; e0b4: a9 2d
                sta arr2                     ; e0b6: 85 01
                jsr sub334                   ; e0b8: 20 fc e1
                bne cod559                   ; e0bb: d0 b7
                rts                          ; e0bd: 60
sub330          lda #0                       ; e0be: a9 00
                sta ram101                   ; e0c0: 85 b1
                jsr sub339                   ; e0c2: 20 8b e3
cod562          lda ram115                   ; e0c5: a5 c4
                cmp #$b5                     ; e0c7: c9 b5
                bne +                        ; e0c9: d0 06
                jsr sub359                   ; e0cb: 20 a3 e7
                jmp cod563                   ; e0ce: 4c d4 e0
+               jsr sub360                   ; e0d1: 20 86 e8
cod563          lda ram114                   ; e0d4: a5 c2
                sta arr81                    ; e0d6: 85 bf
                ldx arr81                    ; e0d8: a6 bf
                lda #$20                     ; e0da: a9 20
                sta misc267,x                ; e0dc: 9d ff 75
                inc arr81                    ; e0df: e6 bf
                ldx arr81                    ; e0e1: a6 bf
                jsr sub336                   ; e0e3: 20 54 e2
                beq cod564                   ; e0e6: f0 17
                ldy #9                       ; e0e8: a0 09
-               lda arr154,y                 ; e0ea: b9 2f 04
                sta arr143,y                 ; e0ed: 99 ff 03
                dey                          ; e0f0: 88
                bne -                        ; e0f1: d0 f7
                lda ram193                   ; e0f3: ad 3a 04
                sta ram181                   ; e0f6: 8d 0a 04
                jsr sub338                   ; e0f9: 20 f5 e2
                jmp cod562                   ; e0fc: 4c c5 e0
cod564          lda ram114                   ; e0ff: a5 c2
                sta arr81                    ; e101: 85 bf
                dec arr81                    ; e103: c6 bf
                lda #$2b                     ; e105: a9 2b
                sta arr1                     ; e107: 85 00
                lda #$2d                     ; e109: a9 2d
                sta arr2                     ; e10b: 85 01
                jsr sub335                   ; e10d: 20 29 e2
                bne +                        ; e110: d0 18
                ldy #9                       ; e112: a0 09
-               lda arr154,y                 ; e114: b9 2f 04
                sta arr152,y                 ; e117: 99 1f 04
                dey                          ; e11a: 88
                bne -                        ; e11b: d0 f7
                lda ram193                   ; e11d: ad 3a 04
                sta ram187                   ; e120: 8d 2a 04
                lda #1                       ; e123: a9 01
                sta arr82                    ; e125: 85 c3
                sta ram101                   ; e127: 85 b1
                rts                          ; e129: 60
+               lda arr81                    ; e12a: a5 bf
                sta arr95                    ; e12c: 85 dc
                jsr sub331                   ; e12e: 20 84 e1
                lda ram114                   ; e131: a5 c2
                sta arr81                    ; e133: 85 bf
                ldx arr81                    ; e135: a6 bf
                lda #$20                     ; e137: a9 20
                sta misc267,x                ; e139: 9d ff 75
                lda ram126                   ; e13c: a5 db
                cmp arr95                    ; e13e: c5 dc
                bne +                        ; e140: d0 06
                jsr sub341                   ; e142: 20 ad e3
                jmp cod565                   ; e145: 4c 4b e1
+               jsr sub342                   ; e148: 20 bf e3
cod565          ldx arr81                    ; e14b: a6 bf
                lda misc267,x                ; e14d: bd ff 75
                cmp #$2d                     ; e150: c9 2d
                bne cod567                   ; e152: d0 17
                lda ram115                   ; e154: a5 c4
                cmp #$2d                     ; e156: c9 2d
                bne +                        ; e158: d0 05
                lda #$2b                     ; e15a: a9 2b
                jmp cod566                   ; e15c: 4c 69 e1
+               lda #$2b                     ; e15f: a9 2b
                sta misc267,x                ; e161: 9d ff 75
                jsr sub332                   ; e164: 20 cb e1
                lda #$2d                     ; e167: a9 2d
cod566          sta ram115                   ; e169: 85 c4
cod567          lda ram115                   ; e16b: a5 c4
                cmp #$2b                     ; e16d: c9 2b
                bne +                        ; e16f: d0 06
                jsr sub355                   ; e171: 20 e9 e6
                jmp cod564                   ; e174: 4c ff e0
+               cmp #$2d                     ; e177: c9 2d
                bne +                        ; e179: d0 06
                jsr sub357                   ; e17b: 20 4b e7
                jmp cod564                   ; e17e: 4c ff e0
+               lda #0                       ; e181: a9 00
                rts                          ; e183: 60
sub331          lda #0                       ; e184: a9 00
                sta ram127                   ; e186: 85 df
                ldy ram112                   ; e188: a4 c0
                lda ram113                   ; e18a: a5 c1
                cmp #$ff                     ; e18c: c9 ff
                beq +                        ; e18e: f0 07
                cpy #2                       ; e190: c0 02
                beq +                        ; e192: f0 03
                jmp cod568                   ; e194: 4c 99 e1
+               ldy #1                       ; e197: a0 01
cod568          lda misc267,y                ; e199: b9 ff 75
                cmp #$41                     ; e19c: c9 41
                bne +                        ; e19e: d0 07
                lda #1                       ; e1a0: a9 01
                sta ram127                   ; e1a2: 85 df
                jmp cod569                   ; e1a4: 4c c3 e1
+               lda ram127                   ; e1a7: a5 df
                beq +                        ; e1a9: f0 0e
                lda misc267,y                ; e1ab: b9 ff 75
                cmp #$2a                     ; e1ae: c9 2a
                bne +                        ; e1b0: d0 07
                lda #0                       ; e1b2: a9 00
                sta ram127                   ; e1b4: 85 df
                jmp cod569                   ; e1b6: 4c c3 e1
+               lda misc267,y                ; e1b9: b9 ff 75
                cmp #$20                     ; e1bc: c9 20
                beq cod569                   ; e1be: f0 03
                sty ram126                   ; e1c0: 84 db
                rts                          ; e1c2: 60
cod569          iny                          ; e1c3: c8
                cpy ram113                   ; e1c4: c4 c1
                bcc cod568                   ; e1c6: 90 d1
                beq cod568                   ; e1c8: f0 cf
                rts                          ; e1ca: 60
sub332          ldy #9                       ; e1cb: a0 09
-               lda arr143,y                 ; e1cd: b9 ff 03
                sta sub467,y                 ; e1d0: 99 ff ff
                lda arr149,y                 ; e1d3: b9 0f 04
                sta arr143,y                 ; e1d6: 99 ff 03
                dey                          ; e1d9: 88
                bne -                        ; e1da: d0 f1
                lda ram181                   ; e1dc: ad 0a 04
                sta arr9                     ; e1df: 85 0f
                lda ram186                   ; e1e1: ad 1a 04
                sta ram181                   ; e1e4: 8d 0a 04
                ldy #9                       ; e1e7: a0 09
-               lda sub467,y                 ; e1e9: b9 ff ff
                sta arr149,y                 ; e1ec: 99 0f 04
                dey                          ; e1ef: 88
                bne -                        ; e1f0: d0 f7
                lda arr9                     ; e1f2: a5 0f
                sta ram186                   ; e1f4: 8d 1a 04
                rts                          ; e1f7: 60
sub333          ldx ram112                   ; e1f8: a6 c0
                stx arr81                    ; e1fa: 86 bf
sub334          lda #0                       ; e1fc: a9 00
                sta arr9                     ; e1fe: 85 0f
-               cpx ram113                   ; e200: e4 c1
                beq cod570                   ; e202: f0 22
                lda misc267,x                ; e204: bd ff 75
                cmp #$3d                     ; e207: c9 3d
                beq cod570                   ; e209: f0 1b
                lda arr1                     ; e20b: a5 00
                cmp misc267,x                ; e20d: dd ff 75
                beq +                        ; e210: f0 0e
                lda arr2                     ; e212: a5 01
                cmp misc267,x                ; e214: dd ff 75
                beq +                        ; e217: f0 07
                inc arr81                    ; e219: e6 bf
                ldx arr81                    ; e21b: a6 bf
                jmp -                        ; e21d: 4c 00 e2
+               sta ram115                   ; e220: 85 c4
                inc arr9                     ; e222: e6 0f
                stx ram114                   ; e224: 86 c2
cod570          lda arr9                     ; e226: a5 0f
                rts                          ; e228: 60
sub335          lda #0                       ; e229: a9 00
                sta arr9                     ; e22b: 85 0f
-               ldx arr81                    ; e22d: a6 bf
                lda ram112                   ; e22f: a5 c0
                sec                          ; e231: 38
                sbc #1                       ; e232: e9 01
                cmp arr81                    ; e234: c5 bf
                beq cod571                   ; e236: f0 19
                lda arr1                     ; e238: a5 00
                cmp misc267,x                ; e23a: dd ff 75
                beq +                        ; e23d: f0 0c
                lda arr2                     ; e23f: a5 01
                cmp misc267,x                ; e241: dd ff 75
                beq +                        ; e244: f0 05
                dec arr81                    ; e246: c6 bf
                jmp -                        ; e248: 4c 2d e2
+               sta ram115                   ; e24b: 85 c4
                inc arr9                     ; e24d: e6 0f
                stx ram114                   ; e24f: 86 c2
cod571          lda arr9                     ; e251: a5 0f
                rts                          ; e253: 60
sub336          lda #0                       ; e254: a9 00
                sta arr9                     ; e256: 85 0f
-               ldx arr81                    ; e258: a6 bf
                cpx ram113                   ; e25a: e4 c1
                beq cod573                   ; e25c: f0 26
                lda misc267,x                ; e25e: bd ff 75
                cmp #$20                     ; e261: c9 20
                beq +                        ; e263: f0 14
                cmp #$3d                     ; e265: c9 3d
                beq cod573                   ; e267: f0 1b
                cmp #$2b                     ; e269: c9 2b
                beq cod573                   ; e26b: f0 17
                cmp #$2d                     ; e26d: c9 2d
                beq cod573                   ; e26f: f0 13
                cmp #$b5                     ; e271: c9 b5
                beq cod572                   ; e273: f0 09
                cmp #$b6                     ; e275: c9 b6
                beq cod572                   ; e277: f0 05
+               inc arr81                    ; e279: e6 bf
                jmp -                        ; e27b: 4c 58 e2
cod572          sta ram115                   ; e27e: 85 c4
                inc arr9                     ; e280: e6 0f
                stx ram114                   ; e282: 86 c2
cod573          lda arr9                     ; e284: a5 0f
                rts                          ; e286: 60
sub337          ldx #$0b                     ; e287: a2 0b
-               lda #$20                     ; e289: a9 20
                sta arr143,x                 ; e28b: 9d ff 03
                dex                          ; e28e: ca
                bne -                        ; e28f: d0 f8
                ldy #9                       ; e291: a0 09
-               dec arr81                    ; e293: c6 bf
                ldx arr81                    ; e295: a6 bf
                lda ram112                   ; e297: a5 c0
                sec                          ; e299: 38
                sbc #1                       ; e29a: e9 01
                cmp arr81                    ; e29c: c5 bf
                beq cod574                   ; e29e: f0 54
                lda misc267,x                ; e2a0: bd ff 75
                cmp #$20                     ; e2a3: c9 20
                beq -                        ; e2a5: f0 ec
                cmp #$2b                     ; e2a7: c9 2b
                beq cod574                   ; e2a9: f0 49
                cmp #$2d                     ; e2ab: c9 2d
                beq cod574                   ; e2ad: f0 45
                cmp #$42                     ; e2af: c9 42
                beq +                        ; e2b1: f0 0f
                lda misc267,x                ; e2b3: bd ff 75
                sta arr143,y                 ; e2b6: 99 ff 03
                lda #$20                     ; e2b9: a9 20
                sta misc267,x                ; e2bb: 9d ff 75
                dey                          ; e2be: 88
                jmp -                        ; e2bf: 4c 93 e2
+               lda #$20                     ; e2c2: a9 20
                sta misc267,x                ; e2c4: 9d ff 75
-               dec arr81                    ; e2c7: c6 bf
                ldx arr81                    ; e2c9: a6 bf
                lda misc268,x                ; e2cb: bd 00 76
                cmp #$41                     ; e2ce: c9 41
                bne -                        ; e2d0: d0 f5
                lda misc269,x                ; e2d2: bd 01 76
                and #%01111111               ; e2d5: 29 7f
                tay                          ; e2d7: a8
                lda #$20                     ; e2d8: a9 20
                sta misc268,x                ; e2da: 9d 00 76
                sta misc269,x                ; e2dd: 9d 01 76
                ldx #0                       ; e2e0: a2 00
-               lda arr141,y                 ; e2e2: b9 8c 03
                sta arr144,x                 ; e2e5: 9d 00 04
                iny                          ; e2e8: c8
                inx                          ; e2e9: e8
                cpx #9                       ; e2ea: e0 09
                bne -                        ; e2ec: d0 f4
                lda arr141,y                 ; e2ee: b9 8c 03
                sta ram181                   ; e2f1: 8d 0a 04
cod574          rts                          ; e2f4: 60
sub338          ldx #$0b                     ; e2f5: a2 0b
-               lda #$20                     ; e2f7: a9 20
                sta arr149,x                 ; e2f9: 9d 0f 04
                dex                          ; e2fc: ca
                bne -                        ; e2fd: d0 f8
                ldy #1                       ; e2ff: a0 01
-               inc arr81                    ; e301: e6 bf
                ldx arr81                    ; e303: a6 bf
                cpx ram113                   ; e305: e4 c1
                beq cod575                   ; e307: f0 62
                lda misc267,x                ; e309: bd ff 75
                cmp #$20                     ; e30c: c9 20
                beq -                        ; e30e: f0 f1
                cmp #$3d                     ; e310: c9 3d
                beq cod575                   ; e312: f0 57
                cmp #$2b                     ; e314: c9 2b
                beq cod575                   ; e316: f0 53
                cmp #$2d                     ; e318: c9 2d
                beq cod575                   ; e31a: f0 4f
                cmp #$b5                     ; e31c: c9 b5
                beq cod575                   ; e31e: f0 4b
                cmp #$b6                     ; e320: c9 b6
                beq cod575                   ; e322: f0 47
                cmp #$41                     ; e324: c9 41
                beq +                        ; e326: f0 0f
                lda misc267,x                ; e328: bd ff 75
                sta arr149,y                 ; e32b: 99 0f 04
                lda #$20                     ; e32e: a9 20
                sta misc267,x                ; e330: 9d ff 75
                iny                          ; e333: c8
                jmp -                        ; e334: 4c 01 e3
+               lda #$20                     ; e337: a9 20
                sta misc267,x                ; e339: 9d ff 75
                lda misc268,x                ; e33c: bd 00 76
                and #%01111111               ; e33f: 29 7f
                tay                          ; e341: a8
                lda #$20                     ; e342: a9 20
                sta misc268,x                ; e344: 9d 00 76
                ldx #0                       ; e347: a2 00
-               lda arr141,y                 ; e349: b9 8c 03
                sta arr150,x                 ; e34c: 9d 10 04
                iny                          ; e34f: c8
                inx                          ; e350: e8
                cpx #9                       ; e351: e0 09
                bne -                        ; e353: d0 f4
                lda arr141,y                 ; e355: b9 8c 03
                sta ram186                   ; e358: 8d 1a 04
-               inc arr81                    ; e35b: e6 bf
                ldx arr81                    ; e35d: a6 bf
                lda misc267,x                ; e35f: bd ff 75
                cmp #$42                     ; e362: c9 42
                bne -                        ; e364: d0 f5
                lda #$20                     ; e366: a9 20
                sta misc267,x                ; e368: 9d ff 75
cod575          ldx #9                       ; e36b: a2 09
                ldy #9                       ; e36d: a0 09
cod576          lda arr149,y                 ; e36f: b9 0f 04
                cmp #$20                     ; e372: c9 20
                bne cod578                   ; e374: d0 04
cod577          dey                          ; e376: 88
                bne cod576                   ; e377: d0 f6
                rts                          ; e379: 60
cod578          cpy #9                       ; e37a: c0 09
                beq +                        ; e37c: f0 0c
                sta arr149,x                 ; e37e: 9d 0f 04
                lda #$20                     ; e381: a9 20
                sta arr149,y                 ; e383: 99 0f 04
                dex                          ; e386: ca
                jmp cod577                   ; e387: 4c 76 e3
+               rts                          ; e38a: 60
sub339          lda ram114                   ; e38b: a5 c2
                sta arr81                    ; e38d: 85 bf
                jsr sub337                   ; e38f: 20 87 e2
                lda ram114                   ; e392: a5 c2
                sta arr81                    ; e394: 85 bf
                jsr sub338                   ; e396: 20 f5 e2
                rts                          ; e399: 60
sub340          ldx #$0b                     ; e39a: a2 0b
-               lda arr152,x                 ; e39c: bd 1f 04
                sta arr143,x                 ; e39f: 9d ff 03
                dex                          ; e3a2: ca
                bne -                        ; e3a3: d0 f7
                lda ram114                   ; e3a5: a5 c2
                sta arr81                    ; e3a7: 85 bf
                jsr sub338                   ; e3a9: 20 f5 e2
                rts                          ; e3ac: 60
sub341          ldx #$0b                     ; e3ad: a2 0b
-               lda arr152,x                 ; e3af: bd 1f 04
                sta arr143,x                 ; e3b2: 9d ff 03
                lda arr154,x                 ; e3b5: bd 2f 04
                sta arr149,x                 ; e3b8: 9d 0f 04
                dex                          ; e3bb: ca
                bne -                        ; e3bc: d0 f1
                rts                          ; e3be: 60
sub342          ldx #$0b                     ; e3bf: a2 0b
-               lda arr154,x                 ; e3c1: bd 2f 04
                sta arr149,x                 ; e3c4: 9d 0f 04
                dex                          ; e3c7: ca
                bne -                        ; e3c8: d0 f7
                lda ram114                   ; e3ca: a5 c2
                sta arr81                    ; e3cc: 85 bf
                jsr sub337                   ; e3ce: 20 87 e2
                rts                          ; e3d1: 60
sub343          ldx #$0b                     ; e3d2: a2 0b
-               lda #$20                     ; e3d4: a9 20
                sta arr152,x                 ; e3d6: 9d 1f 04
                dex                          ; e3d9: ca
                bne -                        ; e3da: d0 f8
                rts                          ; e3dc: 60
dat125          lda arr30                    ; e3dd: a5 43

                hex 89 44 7f                 ; e3df

                eor ram107                   ; e3e2: 45 b7
                lsr ram60                    ; e3e4: 46 6e

                hex 47                       ; e3e6

                stx ram38                    ; e3e7: 86 41

                hex 6b 42                    ; e3e9

                brk                          ; e3eb: 00
                brk                          ; e3ec: 00
                and (arr47),y                ; e3ed: 31 60

                hex 32                       ; e3ef

                adc (ram31,x)                ; e3f0: 61 33

                hex 62 34 63                 ; e3f2

                and arr49,x                  ; e3f5: 35 64
                rol arr57,x                  ; e3f7: 36 74

                hex 37                       ; e3f9

                adc arr34,x                  ; e3fa: 75 48
                lsr a                        ; e3fc: 4a
                jmp misc132                  ; e3fd: 4c 4e 50

                hex 52 52 54                 ; e400

                lsr arr46,x                  ; e403: 56 58

                hex 5a 5c                    ; e405

                lsr misc47,x                 ; e407: 5e 60 30

                hex 32 34                    ; e40a

                rol arr24,x                  ; e40c: 36 38

                hex 3a 3a 3c                 ; e40e

                rol misc82,x                 ; e411: 3e 40 42

                hex 44                       ; e414

                lsr arr34                    ; e415: 46 48
dat126          pla                          ; e417: 68
                bvs $e492                    ; e418: 70 78

                hex 80                       ; e41a

                dey                          ; e41b: 88
                bcc $e424                    ; e41c: 90 06

                hex 0b                       ; e41e

                bpl $e436                    ; e41f: 10 15

                hex 1a 1f                    ; e421

                lda arr61                    ; e423: a5 79
                bne cod580                   ; e425: d0 2b
                lda ram65                    ; e427: a5 7d
                bne cod579                   ; e429: d0 1e
                lda arr23                    ; e42b: a5 37
                cmp #$0b                     ; e42d: c9 0b
                beq cod581                   ; e42f: f0 24
                cmp #$0c                     ; e431: c9 0c
                beq cod583                   ; e433: f0 34
                cmp #$1b                     ; e435: c9 1b
                bne +                        ; e437: d0 0d
                jsr sub430                   ; e439: 20 b1 f4
                lda #0                       ; e43c: a9 00
                sta ram77                    ; e43e: 85 8b
                jsr sub344                   ; e440: 20 6d e4
                jmp cod531                   ; e443: 4c 9b dc
+               jmp cod584                   ; e446: 4c f6 e4
cod579          jsr sub277                   ; e449: 20 97 d1
                jsr sub344                   ; e44c: 20 6d e4
                jmp sub434                   ; e44f: 4c 0f f5
cod580          jmp sub280                   ; e452: 4c 27 d2
cod581          lda #$ff                     ; e455: a9 ff
cod582          sta ram65                    ; e457: 85 7d
                lda #0                       ; e459: a9 00
                sta ram77                    ; e45b: 85 8b
                sta ram90                    ; e45d: 85 a1
                sta ram92                    ; e45f: 85 a3
                sta arr72                    ; e461: 85 a0
                jsr sub401                   ; e463: 20 0d ef
                jmp sub352                   ; e466: 4c 87 e6
cod583          lda #1                       ; e469: a9 01
                bne cod582                   ; e46b: d0 ea
sub344          ldx #0                       ; e46d: a2 00
                ldy #0                       ; e46f: a0 00
-               lda arr176,y                 ; e471: b9 3d 06
                sta misc251,x                ; e474: 9d 00 72
                lda arr179,y                 ; e477: b9 55 06
                sta misc253,x                ; e47a: 9d 60 72
                lda arr180,y                 ; e47d: b9 6d 06
                sta misc256,x                ; e480: 9d c0 72
                inx                          ; e483: e8
                iny                          ; e484: c8
                cpy #$18                     ; e485: c0 18
                bne +                        ; e487: d0 02
                ldy #$60                     ; e489: a0 60
+               cpx #$30                     ; e48b: e0 30
                bne -                        ; e48d: d0 e2
                ldy #0                       ; e48f: a0 00
-               lda arr190,y                 ; e491: b9 fd 06
                sta misc251,x                ; e494: 9d 00 72
                lda arr192,y                 ; e497: b9 15 07
                sta misc253,x                ; e49a: 9d 60 72
                lda arr193,y                 ; e49d: b9 2d 07
                sta misc256,x                ; e4a0: 9d c0 72
                inx                          ; e4a3: e8
                iny                          ; e4a4: c8
                cpy #$18                     ; e4a5: c0 18
                bne +                        ; e4a7: d0 02
                ldy #$60                     ; e4a9: a0 60
+               cpx #$60                     ; e4ab: e0 60
                bne -                        ; e4ad: d0 e2
                rts                          ; e4af: 60
sub345          jsr sub281                   ; e4b0: 20 60 d2
                ldx #0                       ; e4b3: a2 00
                ldy #0                       ; e4b5: a0 00
-               lda misc251,x                ; e4b7: bd 00 72
                sta arr176,y                 ; e4ba: 99 3d 06
                lda misc253,x                ; e4bd: bd 60 72
                sta arr179,y                 ; e4c0: 99 55 06
                lda misc256,x                ; e4c3: bd c0 72
                sta arr180,y                 ; e4c6: 99 6d 06
                inx                          ; e4c9: e8
                iny                          ; e4ca: c8
                cpy #$18                     ; e4cb: c0 18
                bne +                        ; e4cd: d0 02
                ldy #$60                     ; e4cf: a0 60
+               cpx #$30                     ; e4d1: e0 30
                bne -                        ; e4d3: d0 e2
                ldy #0                       ; e4d5: a0 00
-               lda misc251,x                ; e4d7: bd 00 72
                sta arr190,y                 ; e4da: 99 fd 06
                lda misc253,x                ; e4dd: bd 60 72
                sta arr192,y                 ; e4e0: 99 15 07
                lda misc256,x                ; e4e3: bd c0 72
                sta arr193,y                 ; e4e6: 99 2d 07
                inx                          ; e4e9: e8
                iny                          ; e4ea: c8
                cpy #$18                     ; e4eb: c0 18
                bne +                        ; e4ed: d0 02
                ldy #$60                     ; e4ef: a0 60
+               cpx #$60                     ; e4f1: e0 60
                bne -                        ; e4f3: d0 e2
                rts                          ; e4f5: 60
cod584          ldx #4                       ; e4f6: a2 04
                jsr sub402                   ; e4f8: 20 2c ef
                lda ram77                    ; e4fb: a5 8b
                bne cod587                   ; e4fd: d0 2c
                lda arr24                    ; e4ff: a5 38
                cmp #$c8                     ; e501: c9 c8
                bne cod590                   ; e503: d0 55
                jsr sub344                   ; e505: 20 6d e4
                inc ram77                    ; e508: e6 8b
                jsr sub403                   ; e50a: 20 e8 ef
dat127          lda #0                       ; e50d: a9 00
                sta ram90                    ; e50f: 85 a1
cod585          lda #0                       ; e511: a9 00
                sta arr72                    ; e513: 85 a0
                jsr sub346                   ; e515: 20 96 e5
cod586          lda #0                       ; e518: a9 00
                sta arr72                    ; e51a: 85 a0
                sta ram92                    ; e51c: 85 a3
                sta ram93                    ; e51e: 85 a4
                jsr sub352                   ; e520: 20 87 e6
                ldx arr64                    ; e523: a6 8c
                lda $e41d,x                  ; e525: bd 1d e4
                sta ram21                    ; e528: 85 24
                rts                          ; e52a: 60
cod587          lda ram90                    ; e52b: a5 a1
                bne cod591                   ; e52d: d0 2c
                lda ram37                    ; e52f: a5 40
                cmp #$1c                     ; e531: c9 1c
                bne +                        ; e533: d0 0a
                ldx arr64                    ; e535: a6 8c
                cpx #5                       ; e537: e0 05
                beq cod593                   ; e539: f0 46
                inx                          ; e53b: e8
                jmp cod588                   ; e53c: 4c 48 e5
+               cmp #$1d                     ; e53f: c9 1d
                bne cod589                   ; e541: d0 0d
                ldx arr64                    ; e543: a6 8c
                beq cod593                   ; e545: f0 3a
                dex                          ; e547: ca
cod588          stx arr64                    ; e548: 86 8c
                jsr sub354                   ; e54a: 20 d2 e6
                jmp cod593                   ; e54d: 4c 81 e5
cod589          cmp #$c8                     ; e550: c9 c8
                beq cod585                   ; e552: f0 bd
                cmp #$20                     ; e554: c9 20
                bne cod593                   ; e556: d0 29
                inc ram90                    ; e558: e6 a1
cod590          rts                          ; e55a: 60
cod591          lda ram37                    ; e55b: a5 40
                cmp #$c8                     ; e55d: c9 c8
                bne +                        ; e55f: d0 05
                lda #0                       ; e561: a9 00
                sta ram90                    ; e563: 85 a1
                rts                          ; e565: 60
+               cmp #$1c                     ; e566: c9 1c
                bne +                        ; e568: d0 0c
                lda arr72                    ; e56a: a5 a0
                cmp #$5f                     ; e56c: c9 5f
                bpl cod592                   ; e56e: 10 10
                jsr sub350                   ; e570: 20 41 e6
                jmp sub346                   ; e573: 4c 96 e5
+               cmp #$1d                     ; e576: c9 1d
                bne cod592                   ; e578: d0 06
                jsr sub351                   ; e57a: 20 67 e6
                jmp sub346                   ; e57d: 4c 96 e5
cod592          rts                          ; e580: 60
cod593          lda ram21                    ; e581: a5 24
                bne cod590                   ; e583: d0 d5
                ldx arr64                    ; e585: a6 8c
                lda $e41d,x                  ; e587: bd 1d e4
                sta ram21                    ; e58a: 85 24
                jsr sub350                   ; e58c: 20 41 e6
                lda ram93                    ; e58f: a5 a4
                beq sub346                   ; e591: f0 03
                jmp cod585                   ; e593: 4c 11 e5
sub346          ldy arr72                    ; e596: a4 a0
                cpy #$60                     ; e598: c0 60
                bpl +                        ; e59a: 10 1e
                lda misc251,y                ; e59c: b9 00 72
                cmp #$24                     ; e59f: c9 24
                beq cod594                   ; e5a1: f0 1e
                jsr sub347                   ; e5a3: 20 cf e5
                lda misc253,y                ; e5a6: b9 60 72
                cmp #$24                     ; e5a9: c9 24
                beq cod594                   ; e5ab: f0 14
                jsr sub348                   ; e5ad: 20 f4 e5
                lda misc256,y                ; e5b0: b9 c0 72
                cmp #$24                     ; e5b3: c9 24
                beq cod594                   ; e5b5: f0 0a
                jmp sub349                   ; e5b7: 4c 19 e6
+               lda #0                       ; e5ba: a9 00
                sta ram77                    ; e5bc: 85 8b
                jmp cod586                   ; e5be: 4c 18 e5
cod594          cpy #0                       ; e5c1: c0 00
                beq +                        ; e5c3: f0 05
                lda #1                       ; e5c5: a9 01
                sta ram93                    ; e5c7: 85 a4
                rts                          ; e5c9: 60
+               lda #1                       ; e5ca: a9 01
                sta ram92                    ; e5cc: 85 a3
                rts                          ; e5ce: 60
sub347          ldx #0                       ; e5cf: a2 00
-               cmp dat125,x                 ; e5d1: dd dd e3
                beq +                        ; e5d4: f0 08
                inx                          ; e5d6: e8
                cpx #$1e                     ; e5d7: e0 1e
                bmi -                        ; e5d9: 30 f6
                lda #0                       ; e5db: a9 00
                rts                          ; e5dd: 60
+               cpx #$10                     ; e5de: e0 10
                bpl +                        ; e5e0: 10 07
                lda $e3fb,x                  ; e5e2: bd fb e3
                sta ram169                   ; e5e5: 8d 44 03
                rts                          ; e5e8: 60
+               txa                          ; e5e9: 8a
                and #%00001111               ; e5ea: 29 0f
                tax                          ; e5ec: aa
                lda $e409,x                  ; e5ed: bd 09 e4
                sta ram169                   ; e5f0: 8d 44 03
                rts                          ; e5f3: 60
sub348          ldx #0                       ; e5f4: a2 00
-               cmp dat125,x                 ; e5f6: dd dd e3
                beq +                        ; e5f9: f0 08
                inx                          ; e5fb: e8
                cpx #$1e                     ; e5fc: e0 1e
                bmi -                        ; e5fe: 30 f6
                lda #0                       ; e600: a9 00
                rts                          ; e602: 60
+               cpx #$10                     ; e603: e0 10
                bpl +                        ; e605: 10 07
                lda $e409,x                  ; e607: bd 09 e4
                sta ram170                   ; e60a: 8d 45 03
                rts                          ; e60d: 60
+               txa                          ; e60e: 8a
                and #%00001111               ; e60f: 29 0f
                tax                          ; e611: aa
                lda $e3fb,x                  ; e612: bd fb e3
                sta ram170                   ; e615: 8d 45 03
                rts                          ; e618: 60
sub349          ldx #0                       ; e619: a2 00
-               cmp dat125,x                 ; e61b: dd dd e3
                beq +                        ; e61e: f0 08
                inx                          ; e620: e8
                cpx #$1e                     ; e621: e0 1e
                bmi -                        ; e623: 30 f6
                lda #0                       ; e625: a9 00
                rts                          ; e627: 60
+               cpx #$10                     ; e628: e0 10
                bpl +                        ; e62a: 10 07
                lda $e409,x                  ; e62c: bd 09 e4
                sta arr139                   ; e62f: 8d 46 03
                rts                          ; e632: 60
+               txa                          ; e633: 8a
                and #%00001111               ; e634: 29 0f
                tax                          ; e636: aa
                lda $e409,x                  ; e637: bd 09 e4
                sec                          ; e63a: 38
                sbc #$18                     ; e63b: e9 18
                sta arr139                   ; e63d: 8d 46 03
                rts                          ; e640: 60
sub350          lda ram92                    ; e641: a5 a3
                bne cod595                   ; e643: d0 21
                lda arr72                    ; e645: a5 a0
                cmp #$60                     ; e647: c9 60
                bpl cod595                   ; e649: 10 1b
                inc arr72                    ; e64b: e6 a0
                lda arr27                    ; e64d: a5 3e
                clc                          ; e64f: 18
                adc #8                       ; e650: 69 08
                sta arr27                    ; e652: 85 3e
                cmp #$e0                     ; e654: c9 e0
                bne +                        ; e656: d0 0b
                lda #$20                     ; e658: a9 20
                sta arr27                    ; e65a: 85 3e
                lda arr28                    ; e65c: a5 3f
                clc                          ; e65e: 18
                adc #$20                     ; e65f: 69 20
                sta arr28                    ; e661: 85 3f
+               jsr sub353                   ; e663: 20 8f e6
cod595          rts                          ; e666: 60
sub351          lda arr72                    ; e667: a5 a0
                beq cod596                   ; e669: f0 1b
                dec arr72                    ; e66b: c6 a0
                lda arr27                    ; e66d: a5 3e
                sec                          ; e66f: 38
                sbc #8                       ; e670: e9 08
                sta arr27                    ; e672: 85 3e
                cmp #$18                     ; e674: c9 18
                bne +                        ; e676: d0 0b
                lda #$d8                     ; e678: a9 d8
                sta arr27                    ; e67a: 85 3e
                lda arr28                    ; e67c: a5 3f
                sec                          ; e67e: 38
                sbc #$20                     ; e67f: e9 20
                sta arr28                    ; e681: 85 3f
+               jsr sub353                   ; e683: 20 8f e6
cod596          rts                          ; e686: 60
sub352          lda #$20                     ; e687: a9 20
                sta arr27                    ; e689: 85 3e
                lda #$37                     ; e68b: a9 37
                sta arr28                    ; e68d: 85 3f
sub353          lda arr27                    ; e68f: a5 3e
                sta arr1                     ; e691: 85 00
                dec arr1                     ; e693: c6 00
                lda arr28                    ; e695: a5 3f
                sta arr2                     ; e697: 85 01
                lda #$d9                     ; e699: a9 d9
                sta arr3                     ; e69b: 85 02
                lda #$13                     ; e69d: a9 13
                sta ram1                     ; e69f: 85 03
                lda #0                       ; e6a1: a9 00
                sta ram2                     ; e6a3: 85 04
                jsr sub391                   ; e6a5: 20 be ec
                lda #$d9                     ; e6a8: a9 d9
                sta ram150                   ; e6aa: 8d 05 02
                sta ram151                   ; e6ad: 8d 09 02
                lda arr27                    ; e6b0: a5 3e
                sta arr1                     ; e6b2: 85 00
                lda arr28                    ; e6b4: a5 3f
                sta arr2                     ; e6b6: 85 01
                dec arr2                     ; e6b8: c6 01
                lda #$da                     ; e6ba: a9 da
                sta arr3                     ; e6bc: 85 02
                lda #$13                     ; e6be: a9 13
                sta ram1                     ; e6c0: 85 03
                lda #$0c                     ; e6c2: a9 0c
                sta ram2                     ; e6c4: 85 04
                jsr sub391                   ; e6c6: 20 be ec
                lda #$da                     ; e6c9: a9 da
                sta ram153                   ; e6cb: 8d 11 02
                sta ram156                   ; e6ce: 8d 15 02
                rts                          ; e6d1: 60
sub354          lda dat126,x                 ; e6d2: bd 17 e4
                sta ram160                   ; e6d5: 8d 23 02
                lda #1                       ; e6d8: a9 01
                sta ram159                   ; e6da: 8d 22 02
                lda #$db                     ; e6dd: a9 db
                sta ram158                   ; e6df: 8d 21 02
                lda #$b7                     ; e6e2: a9 b7
                sta ram157                   ; e6e4: 8d 20 02
                rts                          ; e6e7: 60

                hex ff                       ; e6e8

sub355          lda #0                       ; e6e9: a9 00
                sta ram4                     ; e6eb: 85 09
                jsr sub364                   ; e6ed: 20 f1 e9
                jsr sub366                   ; e6f0: 20 52 ea
                jsr sub382                   ; e6f3: 20 fd eb
                cmp #$ff                     ; e6f6: c9 ff
                bne sub356                   ; e6f8: d0 03
                jmp cod597                   ; e6fa: 4c 5f e7
sub356          clc                          ; e6fd: 18
                ldx #8                       ; e6fe: a2 08
-               lda arr144,x                 ; e700: bd 00 04
                ldy ram4                     ; e703: a4 09
                beq +                        ; e705: f0 02
                lda arr70,x                  ; e707: b5 97
+               adc arr150,x                 ; e709: 7d 10 04
                sta arr155,x                 ; e70c: 9d 30 04
                sta arr70,x                  ; e70f: 95 97
                adc #$f6                     ; e711: 69 f6
                bcc +                        ; e713: 90 05
                sta arr155,x                 ; e715: 9d 30 04
                sta arr70,x                  ; e718: 95 97
+               lda arr155,x                 ; e71a: bd 30 04
                ora #%00110000               ; e71d: 09 30
                sta arr155,x                 ; e71f: 9d 30 04
                dex                          ; e722: ca
                bpl -                        ; e723: 10 db
                bcc +                        ; e725: 90 12
                ldx #8                       ; e727: a2 08
-               inc arr66,x                  ; e729: f6 8e
                lda arr66,x                  ; e72b: b5 8e
                cmp #$0a                     ; e72d: c9 0a
                bmi +                        ; e72f: 30 08
                lda #0                       ; e731: a9 00
                sta arr66,x                  ; e733: 95 8e
                dex                          ; e735: ca
                bpl -                        ; e736: 10 f1
                rts                          ; e738: 60
+               lda ram4                     ; e739: a5 09
                beq +                        ; e73b: f0 01
                rts                          ; e73d: 60
+               lda arr148                   ; e73e: ad 09 04
                sta ram192                   ; e741: 8d 39 04
                jsr sub363                   ; e744: 20 d3 e9
                jsr sub367                   ; e747: 20 8b ea
                rts                          ; e74a: 60
sub357          lda #0                       ; e74b: a9 00
                sta ram4                     ; e74d: 85 09
                jsr sub364                   ; e74f: 20 f1 e9
                jsr sub366                   ; e752: 20 52 ea
                jsr sub383                   ; e755: 20 13 ec
                cmp #$ff                     ; e758: c9 ff
                bne cod597                   ; e75a: d0 03
                jmp sub356                   ; e75c: 4c fd e6
cod597          jsr sub381                   ; e75f: 20 e6 eb
                beq +                        ; e762: f0 0c
                jsr sub379                   ; e764: 20 c6 eb
                lda ram186                   ; e767: ad 1a 04
                sta ram193                   ; e76a: 8d 3a 04
                jmp sub358                   ; e76d: 4c 76 e7
+               lda ram181                   ; e770: ad 0a 04
                sta ram193                   ; e773: 8d 3a 04
sub358          ldx #8                       ; e776: a2 08
-               lda arr144,x                 ; e778: bd 00 04
                cmp arr150,x                 ; e77b: dd 10 04
                bpl +                        ; e77e: 10 06
                dec arr143,x                 ; e780: de ff 03
                clc                          ; e783: 18
                adc #$0a                     ; e784: 69 0a
+               sec                          ; e786: 38
                sbc arr150,x                 ; e787: fd 10 04
                sta arr144,x                 ; e78a: 9d 00 04
                ora #%00110000               ; e78d: 09 30
                sta arr155,x                 ; e78f: 9d 30 04
                dex                          ; e792: ca
                bpl -                        ; e793: 10 e3
                lda ram4                     ; e795: a5 09
                bne +                        ; e797: d0 09
                lda arr148                   ; e799: ad 09 04
                sta ram192                   ; e79c: 8d 39 04
                jsr sub367                   ; e79f: 20 8b ea
+               rts                          ; e7a2: 60
sub359          jsr sub364                   ; e7a3: 20 f1 e9
                jsr sub385                   ; e7a6: 20 4c ec
                jsr sub384                   ; e7a9: 20 3c ec
                jsr sub369                   ; e7ac: 20 df ea
                beq +                        ; e7af: f0 05
                jsr sub370                   ; e7b1: 20 ec ea
                bne cod598                   ; e7b4: d0 03
+               jmp cod628                   ; e7b6: 4c 1d eb
cod598          lda #8                       ; e7b9: a9 08
                sta ram4                     ; e7bb: 85 09
                sta ram5                     ; e7bd: 85 0a
-               lda arr145                   ; e7bf: ad 01 04
                beq +                        ; e7c2: f0 08
                jsr sub356                   ; e7c4: 20 fd e6
                dec arr145                   ; e7c7: ce 01 04
                bne -                        ; e7ca: d0 f3
+               dec ram5                     ; e7cc: c6 0a
                beq +                        ; e7ce: f0 09
                jsr sub374                   ; e7d0: 20 3f eb
                jsr sub375                   ; e7d3: 20 4a eb
                jmp -                        ; e7d6: 4c bf e7
+               ldx #0                       ; e7d9: a2 00
-               lda arr66,x                  ; e7db: b5 8e
                bne +                        ; e7dd: d0 14
                inc ram5                     ; e7df: e6 0a
                inx                          ; e7e1: e8
                cpx #$12                     ; e7e2: e0 12
                bne -                        ; e7e4: d0 f5
                lda #0                       ; e7e6: a9 00
                ldx #$0a                     ; e7e8: a2 0a
-               sta arr155,x                 ; e7ea: 9d 30 04
                dex                          ; e7ed: ca
                bpl -                        ; e7ee: 10 fa
                jmp cod605                   ; e7f0: 4c 81 e8
+               lda #0                       ; e7f3: a9 00
                sta ram6                     ; e7f5: 85 0b
cod599          lda ram5                     ; e7f7: a5 0a
                cmp #8                       ; e7f9: c9 08
                bpl cod601                   ; e7fb: 10 10
                jsr sub373                   ; e7fd: 20 34 eb
                inc ram5                     ; e800: e6 0a
cod600          lda ram185                   ; e802: ad 19 04
                beq cod602                   ; e805: f0 1b
                dec ram185                   ; e807: ce 19 04
                jmp cod599                   ; e80a: 4c f7 e7
cod601          lda ram185                   ; e80d: ad 19 04
                cmp #7                       ; e810: c9 07
                beq cod603                   ; e812: f0 28
                lda arr148                   ; e814: ad 09 04
                beq cod603                   ; e817: f0 23
                dec arr148                   ; e819: ce 09 04
                inc ram185                   ; e81c: ee 19 04
                jmp cod601                   ; e81f: 4c 0d e8
cod602          lda ram6                     ; e822: a5 0b
                beq +                        ; e824: f0 03
                jmp cod604                   ; e826: 4c 7d e8
+               lda #1                       ; e829: a9 01
                sta ram6                     ; e82b: 85 0b
                lda arr148                   ; e82d: ad 09 04
                ldy ram185                   ; e830: ac 19 04
                sta ram185                   ; e833: 8d 19 04
                sty arr148                   ; e836: 8c 09 04
                jmp cod600                   ; e839: 4c 02 e8
cod603          lda arr148                   ; e83c: ad 09 04
                beq +                        ; e83f: f0 08
                jsr sub373                   ; e841: 20 34 eb
                dec arr148                   ; e844: ce 09 04
                bne cod603                   ; e847: d0 f3
+               lda ram185                   ; e849: ad 19 04
                beq +                        ; e84c: f0 0e
-               lda ram82                    ; e84e: a5 96
                ora arr70                    ; e850: 05 97
                beq +                        ; e852: f0 08
                jsr sub373                   ; e854: 20 34 eb
                dec ram185                   ; e857: ce 19 04
                bne -                        ; e85a: d0 f2
+               ldx #8                       ; e85c: a2 08
-               lda arr70,x                  ; e85e: b5 97
                ora #%00110000               ; e860: 09 30
                sta arr155,x                 ; e862: 9d 30 04
                dex                          ; e865: ca
                bpl -                        ; e866: 10 f6
                lda ram185                   ; e868: ad 19 04
                sta ram192                   ; e86b: 8d 39 04
                jsr sub367                   ; e86e: 20 8b ea
                lda ram192                   ; e871: ad 39 04
                bne cod605                   ; e874: d0 0b
                lda arr155                   ; e876: ad 30 04
                cmp #$30                     ; e879: c9 30
                beq cod605                   ; e87b: f0 04
cod604          lda #2                       ; e87d: a9 02
                sta arr78                    ; e87f: 85 b9
cod605          lda #0                       ; e881: a9 00
                sta ram4                     ; e883: 85 09
                rts                          ; e885: 60
sub360          jsr sub364                   ; e886: 20 f1 e9
                jsr sub385                   ; e889: 20 4c ec
                jsr sub370                   ; e88c: 20 ec ea
                bne cod607                   ; e88f: d0 07
                lda #1                       ; e891: a9 01
                sta arr78                    ; e893: 85 b9
cod606          jmp cod628                   ; e895: 4c 1d eb
cod607          jsr sub369                   ; e898: 20 df ea
                beq cod606                   ; e89b: f0 f8
                lda #1                       ; e89d: a9 01
                sta ram4                     ; e89f: 85 09
                lda #0                       ; e8a1: a9 00
                sta ram5                     ; e8a3: 85 0a
                sta ram6                     ; e8a5: 85 0b
                sta arr7                     ; e8a7: 85 0c
                jsr sub384                   ; e8a9: 20 3c ec
                lda ram185                   ; e8ac: ad 19 04
                cmp arr148                   ; e8af: cd 09 04
                bpl +                        ; e8b2: 10 07
                jsr sub380                   ; e8b4: 20 d9 eb
                lda #1                       ; e8b7: a9 01
                sta arr7                     ; e8b9: 85 0c
+               lda ram185                   ; e8bb: ad 19 04
                sec                          ; e8be: 38
                sbc arr148                   ; e8bf: ed 09 04
                sta ram185                   ; e8c2: 8d 19 04
                lda #0                       ; e8c5: a9 00
                sta arr148                   ; e8c7: 8d 09 04
                lda arr7                     ; e8ca: a5 0c
                beq cod608                   ; e8cc: f0 07
                jsr sub380                   ; e8ce: 20 d9 eb
                lda #0                       ; e8d1: a9 00
                sta arr7                     ; e8d3: 85 0c
cod608          lda arr150                   ; e8d5: ad 10 04
                bne cod609                   ; e8d8: d0 08
                jsr sub377                   ; e8da: 20 60 eb
                inc ram6                     ; e8dd: e6 0b
                jmp cod608                   ; e8df: 4c d5 e8
cod609          lda arr144                   ; e8e2: ad 00 04
                bne +                        ; e8e5: d0 0b
                jsr sub375                   ; e8e7: 20 4a eb
                inc ram5                     ; e8ea: e6 0a
                lda ram5                     ; e8ec: a5 0a
                cmp #8                       ; e8ee: c9 08
                bne cod609                   ; e8f0: d0 f0
+               lda ram5                     ; e8f2: a5 0a
                cmp ram6                     ; e8f4: c5 0b
                bcs +                        ; e8f6: b0 04
                lda #1                       ; e8f8: a9 01
                sta arr7                     ; e8fa: 85 0c
+               lda ram5                     ; e8fc: a5 0a
                sec                          ; e8fe: 38
                sbc ram6                     ; e8ff: e5 0b
                sta ram5                     ; e901: 85 0a
                lda #0                       ; e903: a9 00
                sta ram6                     ; e905: 85 0b
                jsr sub381                   ; e907: 20 e6 eb
                beq +                        ; e90a: f0 05
                jsr sub376                   ; e90c: 20 55 eb
                inc ram5                     ; e90f: e6 0a
+               lda arr7                     ; e911: a5 0c
                beq cod610                   ; e913: f0 0f
                lda ram5                     ; e915: a5 0a
                eor #%11111111               ; e917: 49 ff
                ldx ram6                     ; e919: a6 0b
                sta ram6                     ; e91b: 85 0b
                inc ram6                     ; e91d: e6 0b
                stx ram5                     ; e91f: 86 0a
                jmp cod611                   ; e921: 4c 35 e9
cod610          lda ram185                   ; e924: ad 19 04
                beq cod611                   ; e927: f0 0c
                lda ram5                     ; e929: a5 0a
                beq cod611                   ; e92b: f0 08
                dec ram5                     ; e92d: c6 0a
                dec ram185                   ; e92f: ce 19 04
                jmp cod610                   ; e932: 4c 24 e9
cod611          jsr sub358                   ; e935: 20 76 e7
                inc arr71                    ; e938: e6 9f
-               jsr sub381                   ; e93a: 20 e6 eb
                beq cod611                   ; e93d: f0 f6
                inc ram5                     ; e93f: e6 0a
                jsr sub369                   ; e941: 20 df ea
                beq cod612                   ; e944: f0 1a
                lda ram5                     ; e946: a5 0a
                cmp #8                       ; e948: c9 08
                beq cod612                   ; e94a: f0 14
                jsr sub374                   ; e94c: 20 3f eb
                lda arr144                   ; e94f: ad 00 04
                beq +                        ; e952: f0 06
                jsr sub376                   ; e954: 20 55 eb
                jmp -                        ; e957: 4c 3a e9
+               jsr sub375                   ; e95a: 20 4a eb
                jmp -                        ; e95d: 4c 3a e9
cod612          lda ram6                     ; e960: a5 0b
                beq cod614                   ; e962: f0 16
                lda ram5                     ; e964: a5 0a
                sec                          ; e966: 38
                sbc ram6                     ; e967: e5 0b
                sta ram5                     ; e969: 85 0a
                beq cod613                   ; e96b: f0 02
                bpl cod614                   ; e96d: 10 0b
cod613          jsr sub374                   ; e96f: 20 3f eb
                inc ram5                     ; e972: e6 0a
                lda ram5                     ; e974: a5 0a
                cmp #1                       ; e976: c9 01
                bne cod613                   ; e978: d0 f5
cod614          jsr sub361                   ; e97a: 20 89 e9
                jsr sub372                   ; e97d: 20 10 eb
                jsr sub362                   ; e980: 20 cc e9
                jsr sub367                   ; e983: 20 8b ea
                sta ram4                     ; e986: 85 09
                rts                          ; e988: 60
sub361          lda arr148                   ; e989: ad 09 04
                beq cod616                   ; e98c: f0 14
                lda ram5                     ; e98e: a5 0a
                cmp #9                       ; e990: c9 09
                bne +                        ; e992: d0 06
                jsr sub373                   ; e994: 20 34 eb
                jmp cod615                   ; e997: 4c 9c e9
+               inc ram5                     ; e99a: e6 0a
cod615          dec arr148                   ; e99c: ce 09 04
                jmp sub361                   ; e99f: 4c 89 e9
cod616          lda ram185                   ; e9a2: ad 19 04
                beq cod619                   ; e9a5: f0 1d
                lda ram5                     ; e9a7: a5 0a
                cmp #1                       ; e9a9: c9 01
                beq cod618                   ; e9ab: f0 08
                dec ram5                     ; e9ad: c6 0a
cod617          dec ram185                   ; e9af: ce 19 04
                jmp cod616                   ; e9b2: 4c a2 e9
cod618          lda ram82                    ; e9b5: a5 96
                beq +                        ; e9b7: f0 05
                lda #2                       ; e9b9: a9 02
                sta arr78                    ; e9bb: 85 b9
                rts                          ; e9bd: 60
+               jsr sub374                   ; e9be: 20 3f eb
                jmp cod617                   ; e9c1: 4c af e9
cod619          dec ram5                     ; e9c4: c6 0a
                lda ram5                     ; e9c6: a5 0a
                sta ram192                   ; e9c8: 8d 39 04
                rts                          ; e9cb: 60
sub362          lda ram192                   ; e9cc: ad 39 04
                cmp #8                       ; e9cf: c9 08
                beq cod620                   ; e9d1: f0 12
sub363          lda arr155                   ; e9d3: ad 30 04
                cmp #$30                     ; e9d6: c9 30
                bne +                        ; e9d8: d0 01
                rts                          ; e9da: 60
+               lda ram192                   ; e9db: ad 39 04
                bne cod620                   ; e9de: d0 05
                lda #2                       ; e9e0: a9 02
                sta arr78                    ; e9e2: 85 b9
                rts                          ; e9e4: 60
cod620          dec ram192                   ; e9e5: ce 39 04
                jsr sub378                   ; e9e8: 20 6b eb
                lda #$30                     ; e9eb: a9 30
                sta arr155                   ; e9ed: 8d 30 04
                rts                          ; e9f0: 60
sub364          lda #0                       ; e9f1: a9 00
                sta arr1                     ; e9f3: 85 00
                lda #4                       ; e9f5: a9 04
                sta arr2                     ; e9f7: 85 01
                ldx #0                       ; e9f9: a2 00
                jsr sub365                   ; e9fb: 20 08 ea
                lda #$10                     ; e9fe: a9 10
                sta arr1                     ; ea00: 85 00
                lda #4                       ; ea02: a9 04
                sta arr2                     ; ea04: 85 01
                ldx #1                       ; ea06: a2 01
sub365          jsr sub385                   ; ea08: 20 4c ec
                lda #0                       ; ea0b: a9 00
                sta arr9                     ; ea0d: 85 0f
                txa                          ; ea0f: 8a
                pha                          ; ea10: 48
                ldy #8                       ; ea11: a0 08
                ldx #8                       ; ea13: a2 08
cod621          lda (arr1),y                 ; ea15: b1 00
                pha                          ; ea17: 48
                cmp #$2e                     ; ea18: c9 2e
                bne +                        ; ea1a: d0 05
                sta ram108                   ; ea1c: 85 b8
                pla                          ; ea1e: 68
                bne cod622                   ; ea1f: d0 0c
+               lda ram108                   ; ea21: a5 b8
                bne +                        ; ea23: d0 02
                inc arr9                     ; ea25: e6 0f
+               pla                          ; ea27: 68
                and #%00001111               ; ea28: 29 0f
                sta arr66,x                  ; ea2a: 95 8e
                dex                          ; ea2c: ca
cod622          dey                          ; ea2d: 88
                bpl cod621                   ; ea2e: 10 e5
                pla                          ; ea30: 68
                asl a                        ; ea31: 0a
                asl a                        ; ea32: 0a
                asl a                        ; ea33: 0a
                asl a                        ; ea34: 0a
                tax                          ; ea35: aa
                lda arr9                     ; ea36: a5 0f
                cmp #9                       ; ea38: c9 09
                bmi +                        ; ea3a: 30 02
                lda #0                       ; ea3c: a9 00
+               sta arr148,x                 ; ea3e: 9d 09 04
                ldy #8                       ; ea41: a0 08
                ldx #8                       ; ea43: a2 08
-               lda arr66,x                  ; ea45: b5 8e
                sta (arr1),y                 ; ea47: 91 00
                dex                          ; ea49: ca
                dey                          ; ea4a: 88
                bpl -                        ; ea4b: 10 f8
                lda #0                       ; ea4d: a9 00
                sta ram108                   ; ea4f: 85 b8
                rts                          ; ea51: 60
sub366          lda #0                       ; ea52: a9 00
                sta ram7                     ; ea54: 85 0e
                lda arr148                   ; ea56: ad 09 04
                cmp ram185                   ; ea59: cd 19 04
                beq cod625                   ; ea5c: f0 2c
                bmi cod623                   ; ea5e: 30 07
                lda #1                       ; ea60: a9 01
                sta ram7                     ; ea62: 85 0e
                jsr sub379                   ; ea64: 20 c6 eb
cod623          lda arr145                   ; ea67: ad 01 04
                beq +                        ; ea6a: f0 09
                jsr sub376                   ; ea6c: 20 55 eb
                dec ram185                   ; ea6f: ce 19 04
                jmp cod624                   ; ea72: 4c 7b ea
+               jsr sub375                   ; ea75: 20 4a eb
                inc arr148                   ; ea78: ee 09 04
cod624          lda arr148                   ; ea7b: ad 09 04
                cmp ram185                   ; ea7e: cd 19 04
                bne cod623                   ; ea81: d0 e4
                lda ram7                     ; ea83: a5 0e
                beq cod625                   ; ea85: f0 03
                jsr sub379                   ; ea87: 20 c6 eb
cod625          rts                          ; ea8a: 60
sub367          jsr sub371                   ; ea8b: 20 f9 ea
                lda ram192                   ; ea8e: ad 39 04
                bne cod626                   ; ea91: d0 01
                rts                          ; ea93: 60
cod626          lda ram191                   ; ea94: ad 38 04
                cmp #$30                     ; ea97: c9 30
                bne +                        ; ea99: d0 06
                jsr sub368                   ; ea9b: 20 d0 ea
                bne cod626                   ; ea9e: d0 f4
                rts                          ; eaa0: 60
+               lda arr155                   ; eaa1: ad 30 04
                cmp #$30                     ; eaa4: c9 30
                beq +                        ; eaa6: f0 06
                jsr sub368                   ; eaa8: 20 d0 ea
                bne +                        ; eaab: d0 01
                rts                          ; eaad: 60
+               ldy #8                       ; eaae: a0 08
cod627          lda #8                       ; eab0: a9 08
                sec                          ; eab2: 38
                sbc ram192                   ; eab3: ed 39 04
                sta ram6                     ; eab6: 85 0b
                tax                          ; eab8: aa
                clc                          ; eab9: 18
-               lda arr155,x                 ; eaba: bd 30 04
                rol a                        ; eabd: 2a
                sta arr155,x                 ; eabe: 9d 30 04
                dex                          ; eac1: ca
                bpl -                        ; eac2: 10 f6
                dey                          ; eac4: 88
                bne cod627                   ; eac5: d0 e9
                lda ram6                     ; eac7: a5 0b
                tax                          ; eac9: aa
                lda #$2e                     ; eaca: a9 2e
                sta arr155,x                 ; eacc: 9d 30 04
                rts                          ; eacf: 60
sub368          jsr sub378                   ; ead0: 20 6b eb
                lda #$30                     ; ead3: a9 30
                sta arr155                   ; ead5: 8d 30 04
                dec ram192                   ; ead8: ce 39 04
                lda ram192                   ; eadb: ad 39 04
                rts                          ; eade: 60
sub369          ldx #8                       ; eadf: a2 08
-               lda arr144,x                 ; eae1: bd 00 04
                bne +                        ; eae4: d0 05
                dex                          ; eae6: ca
                bpl -                        ; eae7: 10 f8
                lda #0                       ; eae9: a9 00
+               rts                          ; eaeb: 60
sub370          ldx #8                       ; eaec: a2 08
-               lda arr150,x                 ; eaee: bd 10 04
                bne +                        ; eaf1: d0 05
                dex                          ; eaf3: ca
                bpl -                        ; eaf4: 10 f8
                lda #0                       ; eaf6: a9 00
+               rts                          ; eaf8: 60
sub371          ldx #8                       ; eaf9: a2 08
-               lda arr155,x                 ; eafb: bd 30 04
                cmp #$30                     ; eafe: c9 30
                bne +                        ; eb00: d0 0d
                dex                          ; eb02: ca
                bpl -                        ; eb03: 10 f6
                lda #$20                     ; eb05: a9 20
                sta ram193                   ; eb07: 8d 3a 04
                lda #0                       ; eb0a: a9 00
                sta ram192                   ; eb0c: 8d 39 04
+               rts                          ; eb0f: 60
sub372          ldx #8                       ; eb10: a2 08
-               lda arr70,x                  ; eb12: b5 97
                ora #%00110000               ; eb14: 09 30
                sta arr155,x                 ; eb16: 9d 30 04
                dex                          ; eb19: ca
                bpl -                        ; eb1a: 10 f6
                rts                          ; eb1c: 60
cod628          ldx #8                       ; eb1d: a2 08
                lda #$30                     ; eb1f: a9 30
-               sta arr155,x                 ; eb21: 9d 30 04
                dex                          ; eb24: ca
                bpl -                        ; eb25: 10 fa
                lda #$20                     ; eb27: a9 20
                sta ram193                   ; eb29: 8d 3a 04
                lda #0                       ; eb2c: a9 00
                sta ram192                   ; eb2e: 8d 39 04
                sta ram4                     ; eb31: 85 09
                rts                          ; eb33: 60
sub373          lda #$8e                     ; eb34: a9 8e
                sta arr1                     ; eb36: 85 00
                lda #0                       ; eb38: a9 00
                sta arr2                     ; eb3a: 85 01
                jmp cod635                   ; eb3c: 4c af eb
sub374          lda #$8e                     ; eb3f: a9 8e
                sta arr1                     ; eb41: 85 00
                lda #0                       ; eb43: a9 00
                sta arr2                     ; eb45: 85 01
                jmp cod631                   ; eb47: 4c 87 eb
sub375          lda #0                       ; eb4a: a9 00
                sta arr1                     ; eb4c: 85 00
                lda #4                       ; eb4e: a9 04
                sta arr2                     ; eb50: 85 01
                jmp cod629                   ; eb52: 4c 76 eb
sub376          lda #$10                     ; eb55: a9 10
                sta arr1                     ; eb57: 85 00
                lda #4                       ; eb59: a9 04
                sta arr2                     ; eb5b: 85 01
                jmp cod633                   ; eb5d: 4c 98 eb
sub377          lda #$10                     ; eb60: a9 10
                sta arr1                     ; eb62: 85 00
                lda #4                       ; eb64: a9 04
                sta arr2                     ; eb66: 85 01
                jmp cod629                   ; eb68: 4c 76 eb
sub378          lda #$30                     ; eb6b: a9 30
                sta arr1                     ; eb6d: 85 00
                lda #4                       ; eb6f: a9 04
                sta arr2                     ; eb71: 85 01
                jmp cod633                   ; eb73: 4c 98 eb
cod629          ldx #8                       ; eb76: a2 08
cod630          clc                          ; eb78: 18
                ldy #8                       ; eb79: a0 08
-               lda (arr1),y                 ; eb7b: b1 00
                rol a                        ; eb7d: 2a
                sta (arr1),y                 ; eb7e: 91 00
                dey                          ; eb80: 88
                bpl -                        ; eb81: 10 f8
                dex                          ; eb83: ca
                bne cod630                   ; eb84: d0 f2
                rts                          ; eb86: 60
cod631          ldx #8                       ; eb87: a2 08
cod632          clc                          ; eb89: 18
                ldy #$11                     ; eb8a: a0 11
-               lda (arr1),y                 ; eb8c: b1 00
                rol a                        ; eb8e: 2a
                sta (arr1),y                 ; eb8f: 91 00
                dey                          ; eb91: 88
                bpl -                        ; eb92: 10 f8
                dex                          ; eb94: ca
                bne cod632                   ; eb95: d0 f2
                rts                          ; eb97: 60
cod633          ldx #8                       ; eb98: a2 08
cod634          lda #8                       ; eb9a: a9 08
                sta arr6                     ; eb9c: 85 08
                clc                          ; eb9e: 18
                ldy #0                       ; eb9f: a0 00
-               lda (arr1),y                 ; eba1: b1 00
                ror a                        ; eba3: 6a
                sta (arr1),y                 ; eba4: 91 00
                iny                          ; eba6: c8
                dec arr6                     ; eba7: c6 08
                bpl -                        ; eba9: 10 f6
                dex                          ; ebab: ca
                bne cod634                   ; ebac: d0 ec
                rts                          ; ebae: 60
cod635          ldx #8                       ; ebaf: a2 08
cod636          lda #$11                     ; ebb1: a9 11
                sta arr6                     ; ebb3: 85 08
                clc                          ; ebb5: 18
                ldy #0                       ; ebb6: a0 00
-               lda (arr1),y                 ; ebb8: b1 00
                ror a                        ; ebba: 6a
                sta (arr1),y                 ; ebbb: 91 00
                iny                          ; ebbd: c8
                dec arr6                     ; ebbe: c6 08
                bpl -                        ; ebc0: 10 f6
                dex                          ; ebc2: ca
                bne cod636                   ; ebc3: d0 ec
                rts                          ; ebc5: 60
sub379          ldx #8                       ; ebc6: a2 08
-               lda arr144,x                 ; ebc8: bd 00 04
                tay                          ; ebcb: a8
                lda arr150,x                 ; ebcc: bd 10 04
                sta arr144,x                 ; ebcf: 9d 00 04
                tya                          ; ebd2: 98
                sta arr150,x                 ; ebd3: 9d 10 04
                dex                          ; ebd6: ca
                bpl -                        ; ebd7: 10 ef
sub380          lda arr148                   ; ebd9: ad 09 04
                ldx ram185                   ; ebdc: ae 19 04
                stx arr148                   ; ebdf: 8e 09 04
                sta ram185                   ; ebe2: 8d 19 04
                rts                          ; ebe5: 60
sub381          ldx #0                       ; ebe6: a2 00
-               lda arr144,x                 ; ebe8: bd 00 04
                cmp arr150,x                 ; ebeb: dd 10 04
                beq +                        ; ebee: f0 05
                bpl cod637                   ; ebf0: 10 08
                lda #1                       ; ebf2: a9 01
                rts                          ; ebf4: 60
+               inx                          ; ebf5: e8
                cpx #9                       ; ebf6: e0 09
                bmi -                        ; ebf8: 30 ee
cod637          lda #0                       ; ebfa: a9 00
                rts                          ; ebfc: 60
sub382          lda ram181                   ; ebfd: ad 0a 04
                cmp ram186                   ; ec00: cd 1a 04
                bne cod638                   ; ec03: d0 0b
                lda ram181                   ; ec05: ad 0a 04
                bne +                        ; ec08: d0 02
                lda #$20                     ; ec0a: a9 20
+               sta ram193                   ; ec0c: 8d 3a 04
                rts                          ; ec0f: 60
cod638          lda #$ff                     ; ec10: a9 ff
                rts                          ; ec12: 60
sub383          lda ram181                   ; ec13: ad 0a 04
                cmp ram186                   ; ec16: cd 1a 04
                bne cod639                   ; ec19: d0 18
                cmp #$2d                     ; ec1b: c9 2d
                bne +                        ; ec1d: d0 09
                sta ram181                   ; ec1f: 8d 0a 04
                lda #$20                     ; ec22: a9 20
                sta ram186                   ; ec24: 8d 1a 04
                rts                          ; ec27: 60
+               lda #$20                     ; ec28: a9 20
                sta ram181                   ; ec2a: 8d 0a 04
                lda #$2d                     ; ec2d: a9 2d
                sta ram186                   ; ec2f: 8d 1a 04
                rts                          ; ec32: 60
cod639          lda ram181                   ; ec33: ad 0a 04
                sta ram193                   ; ec36: 8d 3a 04
                lda #$ff                     ; ec39: a9 ff
                rts                          ; ec3b: 60
sub384          ldx #$20                     ; ec3c: a2 20
                lda ram181                   ; ec3e: ad 0a 04
                cmp ram186                   ; ec41: cd 1a 04
                beq +                        ; ec44: f0 02
                ldx #$2d                     ; ec46: a2 2d
+               stx ram193                   ; ec48: 8e 3a 04
                rts                          ; ec4b: 60
sub385          txa                          ; ec4c: 8a
                pha                          ; ec4d: 48
                ldx #$11                     ; ec4e: a2 11
                lda #0                       ; ec50: a9 00
-               sta arr66,x                  ; ec52: 95 8e
                dex                          ; ec54: ca
                bpl -                        ; ec55: 10 fb
                pla                          ; ec57: 68
                tax                          ; ec58: aa
                rts                          ; ec59: 60
sub386          ldy #0                       ; ec5a: a0 00
                sty ram28                    ; ec5c: 84 2e
                sty ram29                    ; ec5e: 84 2f
                lda #$f8                     ; ec60: a9 f8
-               sta arr107,y                 ; ec62: 99 00 02
                dey                          ; ec65: 88
                bne -                        ; ec66: d0 fa
                rts                          ; ec68: 60
cod640          jsr sub389                   ; ec69: 20 80 ec
                jmp sub394                   ; ec6c: 4c 2d ed
sub387          lda #0                       ; ec6f: a9 00
                sta ram10                    ; ec71: 85 12
                sta ram11                    ; ec73: 85 13
                jsr sub400                   ; ec75: 20 4c ee
                lda #$10                     ; ec78: a9 10
sub388          sta ppu_ctrl                 ; ec7a: 8d 00 20
                sta ram8                     ; ec7d: 85 10
                rts                          ; ec7f: 60
sub389          lda #0                       ; ec80: a9 00
                sta ppu_mask                 ; ec82: 8d 01 20
                rts                          ; ec85: 60
cod641          ldy #0                       ; ec86: a0 00
-               lda (arr1),y                 ; ec88: b1 00
                cmp #$ff                     ; ec8a: c9 ff
                beq +                        ; ec8c: f0 13
                sta arr3                     ; ec8e: 85 02
                iny                          ; ec90: c8
                lda (arr1),y                 ; ec91: b1 00
                sta ram1                     ; ec93: 85 03
                iny                          ; ec95: c8
                lda (arr1),y                 ; ec96: b1 00
                sta ram2                     ; ec98: 85 04
                jsr sub390                   ; ec9a: 20 a2 ec
                iny                          ; ec9d: c8
                jmp -                        ; ec9e: 4c 88 ec
+               rts                          ; eca1: 60
sub390          tya                          ; eca2: 98
                pha                          ; eca3: 48
                lda #2                       ; eca4: a9 02
                sta arr4                     ; eca6: 85 05
                ldx ram1                     ; eca8: a6 03
                ldy #0                       ; ecaa: a0 00
-               lda #0                       ; ecac: a9 00
                sta (ram2),y                 ; ecae: 91 04
                iny                          ; ecb0: c8
                iny                          ; ecb1: c8
                lda arr3                     ; ecb2: a5 02
                sta (ram2),y                 ; ecb4: 91 04
                iny                          ; ecb6: c8
                iny                          ; ecb7: c8
                dex                          ; ecb8: ca
                bne -                        ; ecb9: d0 f1
                pla                          ; ecbb: 68
                tay                          ; ecbc: a8
                rts                          ; ecbd: 60
sub391          txa                          ; ecbe: 8a
                pha                          ; ecbf: 48
                tya                          ; ecc0: 98
                pha                          ; ecc1: 48
                lda #2                       ; ecc2: a9 02
                sta arr4                     ; ecc4: 85 05
                lda #$0f                     ; ecc6: a9 0f
                and ram1                     ; ecc8: 25 03
                sta ram3                     ; ecca: 85 07
                lda ram1                     ; eccc: a5 03
                lsr a                        ; ecce: 4a
                lsr a                        ; eccf: 4a
                lsr a                        ; ecd0: 4a
                lsr a                        ; ecd1: 4a
                sta arr5                     ; ecd2: 85 06
                tax                          ; ecd4: aa
                lda #0                       ; ecd5: a9 00
                clc                          ; ecd7: 18
-               adc ram3                     ; ecd8: 65 07
                dex                          ; ecda: ca
                bne -                        ; ecdb: d0 fb
                sta arr6                     ; ecdd: 85 08
                jsr sub392                   ; ecdf: 20 ea ec
                jsr sub393                   ; ece2: 20 05 ed
                pla                          ; ece5: 68
                tay                          ; ece6: a8
                pla                          ; ece7: 68
                tax                          ; ece8: aa
                rts                          ; ece9: 60
sub392          lda arr3                     ; ecea: a5 02
                ldx arr6                     ; ecec: a6 08
                ldy #1                       ; ecee: a0 01
-               sta (ram2),y                 ; ecf0: 91 04
                clc                          ; ecf2: 18
                adc #1                       ; ecf3: 69 01
                iny                          ; ecf5: c8
                pha                          ; ecf6: 48
                lda (ram2),y                 ; ecf7: b1 04
                and #%00111111               ; ecf9: 29 3f
                sta (ram2),y                 ; ecfb: 91 04
                pla                          ; ecfd: 68
                iny                          ; ecfe: c8
                iny                          ; ecff: c8
                iny                          ; ed00: c8
                dex                          ; ed01: ca
                bne -                        ; ed02: d0 ec
                rts                          ; ed04: 60
sub393          ldy #0                       ; ed05: a0 00
cod642          ldx arr5                     ; ed07: a6 06
                lda arr1                     ; ed09: a5 00
                sta ram4                     ; ed0b: 85 09
-               lda arr2                     ; ed0d: a5 01
                sta (ram2),y                 ; ed0f: 91 04
                iny                          ; ed11: c8
                iny                          ; ed12: c8
                iny                          ; ed13: c8
                lda ram4                     ; ed14: a5 09
                sta (ram2),y                 ; ed16: 91 04
                clc                          ; ed18: 18
                adc #8                       ; ed19: 69 08
                sta ram4                     ; ed1b: 85 09
                iny                          ; ed1d: c8
                dex                          ; ed1e: ca
                bne -                        ; ed1f: d0 ec
                lda arr2                     ; ed21: a5 01
                clc                          ; ed23: 18
                adc #8                       ; ed24: 69 08
                sta arr2                     ; ed26: 85 01
                dec ram3                     ; ed28: c6 07
                bne cod642                   ; ed2a: d0 db
                rts                          ; ed2c: 60
sub394          lda ppu_status               ; ed2d: ad 02 20
                lda ram8                     ; ed30: a5 10
                and #%11111011               ; ed32: 29 fb
                sta ppu_ctrl                 ; ed34: 8d 00 20
                lda #$20                     ; ed37: a9 20
                sta ppu_addr                 ; ed39: 8d 06 20
                lda #0                       ; ed3c: a9 00
                sta ppu_addr                 ; ed3e: 8d 06 20
                ldx #4                       ; ed41: a2 04
                ldy #0                       ; ed43: a0 00
                lda #$20                     ; ed45: a9 20
-               sta ppu_data                 ; ed47: 8d 07 20
                dey                          ; ed4a: 88
                bne -                        ; ed4b: d0 fa
                dex                          ; ed4d: ca
                bne -                        ; ed4e: d0 f7
                lda #$23                     ; ed50: a9 23
                sta ppu_addr                 ; ed52: 8d 06 20
                lda #$c0                     ; ed55: a9 c0
                sta ppu_addr                 ; ed57: 8d 06 20
                ldy #$40                     ; ed5a: a0 40
                lda #0                       ; ed5c: a9 00
-               sta ppu_data                 ; ed5e: 8d 07 20
                dey                          ; ed61: 88
                bne -                        ; ed62: d0 fa
                rts                          ; ed64: 60
sub395          txa                          ; ed65: 8a
                pha                          ; ed66: 48
                tya                          ; ed67: 98
                pha                          ; ed68: 48
                ldy #0                       ; ed69: a0 00
                lda (arr3),y                 ; ed6b: b1 02
                and #%00001111               ; ed6d: 29 0f
                sta arr4                     ; ed6f: 85 05
                lda (arr3),y                 ; ed71: b1 02
                lsr a                        ; ed73: 4a
                lsr a                        ; ed74: 4a
                lsr a                        ; ed75: 4a
                lsr a                        ; ed76: 4a
                sta ram2                     ; ed77: 85 04
                ldx ram164                   ; ed79: ae 00 03
cod643          lda arr2                     ; ed7c: a5 01
                sta arr131,x                 ; ed7e: 9d 01 03
                jsr sub396                   ; ed81: 20 c1 ed
                lda arr1                     ; ed84: a5 00
                sta arr131,x                 ; ed86: 9d 01 03
                jsr sub396                   ; ed89: 20 c1 ed
                lda arr4                     ; ed8c: a5 05
                sta arr5                     ; ed8e: 85 06
                sta arr131,x                 ; ed90: 9d 01 03
-               jsr sub396                   ; ed93: 20 c1 ed
                iny                          ; ed96: c8
                lda (arr3),y                 ; ed97: b1 02
                sta arr131,x                 ; ed99: 9d 01 03
                dec arr5                     ; ed9c: c6 06
                bne -                        ; ed9e: d0 f3
                jsr sub396                   ; eda0: 20 c1 ed
                stx ram164                   ; eda3: 8e 00 03
                clc                          ; eda6: 18
                lda #$20                     ; eda7: a9 20
                adc arr1                     ; eda9: 65 00
                sta arr1                     ; edab: 85 00
                lda #0                       ; edad: a9 00
                adc arr2                     ; edaf: 65 01
                sta arr2                     ; edb1: 85 01
                dec ram2                     ; edb3: c6 04
                bne cod643                   ; edb5: d0 c5
                lda #0                       ; edb7: a9 00
                sta arr131,x                 ; edb9: 9d 01 03
                pla                          ; edbc: 68
                tay                          ; edbd: a8
                pla                          ; edbe: 68
                tax                          ; edbf: aa
                rts                          ; edc0: 60
sub396          inx                          ; edc1: e8
                txa                          ; edc2: 8a
                cmp #$3f                     ; edc3: c9 3f
                bcc +                        ; edc5: 90 0a
                ldx ram164                   ; edc7: ae 00 03
                lda #0                       ; edca: a9 00
                sta arr131,x                 ; edcc: 9d 01 03
                pla                          ; edcf: 68
                pla                          ; edd0: 68
+               rts                          ; edd1: 60
sub397          ldx #9                       ; edd2: a2 09
                dec arr14                    ; edd4: c6 20
                bpl cod644                   ; edd6: 10 06
                lda #$14                     ; edd8: a9 14
                sta arr14                    ; edda: 85 20
                ldx #$0c                     ; eddc: a2 0c
cod644          lda arr15,x                  ; edde: b5 21
                beq +                        ; ede0: f0 02
                dec arr15,x                  ; ede2: d6 21
+               dex                          ; ede4: ca
                bpl cod644                   ; ede5: 10 f7
                rts                          ; ede7: 60
sub398          lda arr40                    ; ede8: a5 51
                and #%00000010               ; edea: 29 02
                sta arr1                     ; edec: 85 00
                lda arr41                    ; edee: a5 52
                and #%00000010               ; edf0: 29 02
                eor arr1                     ; edf2: 45 00
                clc                          ; edf4: 18
                beq +                        ; edf5: f0 01
                sec                          ; edf7: 38
+               ror arr40                    ; edf8: 66 51
                ror arr41                    ; edfa: 66 52
                ror arr42                    ; edfc: 66 53
                ror arr43                    ; edfe: 66 54
                ror arr44                    ; ee00: 66 55
                ror arr45                    ; ee02: 66 56
                ror ram43                    ; ee04: 66 57
                ror arr46                    ; ee06: 66 58
                rts                          ; ee08: 60
cod645          sta ppu_addr                 ; ee09: 8d 06 20
                iny                          ; ee0c: c8
                lda (arr1),y                 ; ee0d: b1 00
                sta ppu_addr                 ; ee0f: 8d 06 20
                iny                          ; ee12: c8
                lda (arr1),y                 ; ee13: b1 00
                asl a                        ; ee15: 0a
                pha                          ; ee16: 48
                lda ram8                     ; ee17: a5 10
                ora #%00000100               ; ee19: 09 04
                bcs +                        ; ee1b: b0 02
                and #%11111011               ; ee1d: 29 fb
+               jsr sub388                   ; ee1f: 20 7a ec
                pla                          ; ee22: 68
                asl a                        ; ee23: 0a
                bcc +                        ; ee24: 90 03
                ora #%00000010               ; ee26: 09 02
                iny                          ; ee28: c8
+               lsr a                        ; ee29: 4a
                lsr a                        ; ee2a: 4a
                tax                          ; ee2b: aa
-               bcs +                        ; ee2c: b0 01
                iny                          ; ee2e: c8
+               lda (arr1),y                 ; ee2f: b1 00
                sta ppu_data                 ; ee31: 8d 07 20
                dex                          ; ee34: ca
                bne -                        ; ee35: d0 f5
                sec                          ; ee37: 38
                tya                          ; ee38: 98
                adc arr1                     ; ee39: 65 00
                sta arr1                     ; ee3b: 85 00
                lda #0                       ; ee3d: a9 00
                adc arr2                     ; ee3f: 65 01
                sta arr2                     ; ee41: 85 01
sub399          ldx ppu_status               ; ee43: ae 02 20
                ldy #0                       ; ee46: a0 00
                lda (arr1),y                 ; ee48: b1 00
                bne cod645                   ; ee4a: d0 bd
sub400          lda ram10                    ; ee4c: a5 12
                sta ppu_scroll               ; ee4e: 8d 05 20
                lda ram11                    ; ee51: a5 13
                sta ppu_scroll               ; ee53: 8d 05 20
                rts                          ; ee56: 60
                ora (arr14),y                ; ee57: 11 20
dat128          brk                          ; ee59: 00
                ora (arr1,x)                 ; ee5a: 01 00
                brk                          ; ee5c: 00
                ora (arr81,x)                ; ee5d: 01 bf

                hex 97 d7                    ; ee5f

                ora (arr50),y                ; ee61: 11 67
dat129          clc                          ; ee63: 18
                clc                          ; ee64: 18
                clc                          ; ee65: 18
                brk                          ; ee66: 00
                clc                          ; ee67: 18
dat130          and_absx arr1                ; ee68: 3d 00 00
                brk                          ; ee6b: 00
                brk                          ; ee6c: 00

dat131          hex 3c 3c 3c 97 3c           ; ee6d

dat132          ldy $bcbc                    ; ee72: ac bc bc

                hex 97                       ; ee75

                ldy dat118                   ; ee76: ac da da

                hex da                       ; ee79

                iny                          ; ee7a: c8

                hex da                       ; ee7b
dat133          hex 22 22 22                 ; ee7c

                sec                          ; ee7f: 38

                hex 22                       ; ee80

dat134          bpl $ee8b                    ; ee81: 10 08
                bpl +                        ; ee83: 10 00
+               php                          ; ee85: 08
dat135          jsr misc3                    ; ee86: 20 20 20

                hex 22                       ; ee89

                jsr $e4e4                    ; ee8a: 20 e4 e4
                cpx arr50                    ; ee8d: e4 67
                cpx arr7                     ; ee8f: e4 0c

                hex 0c 0c                    ; ee91

                ora #%00001100               ; ee93: 09 0c

dat136          hex 03 03 03 04 03           ; ee95
dat137          hex 34 14 34                 ; ee9a

                brk                          ; ee9d: 00

                hex 14                       ; ee9e

dat138          plp                          ; ee9f: 28
                php                          ; eea0: 08
                plp                          ; eea1: 28
                brk                          ; eea2: 00
                php                          ; eea3: 08
dat139          rti                          ; eea4: 40
                jsr ram37                    ; eea5: 20 40 00
                jsr sub467                   ; eea8: 20 ff ff

                hex ff ff                    ; eeab

                ora (arr2,x)                 ; eead: 01 01
                ora (arr2,x)                 ; eeaf: 01 01
                ora (arr2,x)                 ; eeb1: 01 01
                ora (arr2,x)                 ; eeb3: 01 01

                hex ff ff ff ff              ; eeb5
dat140          hex ff ff                    ; eeb9

                ora (arr2,x)                 ; eebb: 01 01
                ora (arr2,x)                 ; eebd: 01 01
                ora (arr2,x)                 ; eebf: 01 01

                hex ff ff ff ff ff ff        ; eec1

                ora (arr2,x)                 ; eec7: 01 01
dat141          brk                          ; eec9: 00
                brk                          ; eeca: 00
                ora (arr105,x)               ; eecb: 01 ff
dat142          pha                          ; eecd: 48
                tay                          ; eece: a8
                php                          ; eecf: 08
dat143          rts                          ; eed0: 60
                cpy #$20                     ; eed1: c0 20
dat144          cmp (ram114,x)               ; eed3: c1 c2

                hex c3                       ; eed5

                cpy arr83                    ; eed6: c4 c5
                dec ram116                   ; eed8: c6 c7
                iny                          ; eeda: c8

                hex 2b                       ; eedb

                and sub235                   ; eedc: 2d b5 b6
                plp                          ; eedf: 28
                and #%00101110               ; eee0: 29 2e
                and $89a5,x                  ; eee2: 3d a5 89

                hex 7f b7                    ; eee5

                ror misc216                  ; eee7: 6e 86 6b
                iny                          ; eeea: c8

dat145          hex 02                       ; eeeb

                asl ram7                     ; eeec: 06 0e

                hex 0f                       ; eeee

                bpl cod647                   ; eeef: 10 11

                hex 17                       ; eef1

                clc                          ; eef2: 18

dat146          hex 43 44                    ; eef3

                eor arr33                    ; eef5: 45 46

                hex 47                       ; eef7

                eor (arr29,x)                ; eef8: 41 42
                bit ram97                    ; eefa: 24 a9
                jsr arr72                    ; eefc: 20 a0 00
cod646          sta arr176,y                 ; eeff: 99 3d 06
cod647          dey                          ; ef02: 88
                bne cod646                   ; ef03: d0 fa
                ldy #$97                     ; ef05: a0 97
-               sta arr194,y                 ; ef07: 99 3c 07
                dey                          ; ef0a: 88
                bne -                        ; ef0b: d0 fa
sub401          ldx ram33                    ; ef0d: a6 36
                lda dat133,x                 ; ef0f: bd 7c ee
                sta arr20                    ; ef12: 85 30
                lda dat131,x                 ; ef14: bd 6d ee
                sta ram30                    ; ef17: 85 31
                lda dat135,x                 ; ef19: bd 86 ee
                sta arr21                    ; ef1c: 85 32
                lda $ee8b,x                  ; ef1e: bd 8b ee
                sta arr22                    ; ef21: 85 34
                lda #0                       ; ef23: a9 00
                sta ram28                    ; ef25: 85 2e
                sta ram29                    ; ef27: 85 2f
                sta arr29                    ; ef29: 85 42
                rts                          ; ef2b: 60
sub402          stx ram33                    ; ef2c: 86 36
                cpx #3                       ; ef2e: e0 03
                beq cod650                   ; ef30: f0 29
                lda arr16                    ; ef32: a5 23
                beq cod650                   ; ef34: f0 25
                cmp #1                       ; ef36: c9 01
                beq cod649                   ; ef38: f0 1a
                lda arr23                    ; ef3a: a5 37
                cmp ram34                    ; ef3c: c5 39
                beq cod648                   ; ef3e: f0 10
                lda ram34                    ; ef40: a5 39
                beq +                        ; ef42: f0 07
                lda arr23                    ; ef44: a5 37
                sta ram34                    ; ef46: 85 39
                jmp cod648                   ; ef48: 4c 50 ef
+               lda #2                       ; ef4b: a9 02
                sta arr16                    ; ef4d: 85 23
                rts                          ; ef4f: 60
cod648          jsr sub433                   ; ef50: 20 e1 f4
                rts                          ; ef53: 60
cod649          lda #0                       ; ef54: a9 00
                sta ram36                    ; ef56: 85 3c
                jmp cod662                   ; ef58: 4c 76 f0
cod650          lda #0                       ; ef5b: a9 00
                sta arr25                    ; ef5d: 85 3a
                sta arr77                    ; ef5f: 85 b0
                sta ram37                    ; ef61: 85 40
                lda arr23                    ; ef63: a5 37
                sta arr24                    ; ef65: 85 38
                cmp ram34                    ; ef67: c5 39
                bne cod653                   ; ef69: d0 1a
                lda arr24                    ; ef6b: a5 38
                beq cod652                   ; ef6d: f0 0b
                lda arr15                    ; ef6f: a5 21
                bne cod651                   ; ef71: d0 06
                sta ram34                    ; ef73: 85 39
                lda #8                       ; ef75: a9 08
                sta arr15                    ; ef77: 85 21
cod651          rts                          ; ef79: 60
cod652          lda #$20                     ; ef7a: a9 20
                sta arr15                    ; ef7c: 85 21
                lda ram77                    ; ef7e: a5 8b
                bne cod651                   ; ef80: d0 f7
                jmp cod664                   ; ef82: 4c 90 f0
cod653          lda arr24                    ; ef85: a5 38
                sta ram34                    ; ef87: 85 39
                beq cod652                   ; ef89: f0 ef
                sta ram37                    ; ef8b: 85 40
                lda ram77                    ; ef8d: a5 8b
                bne cod651                   ; ef8f: d0 e8
                lda arr24                    ; ef91: a5 38
                cmp #$1c                     ; ef93: c9 1c
                bne +                        ; ef95: d0 09
                jsr sub412                   ; ef97: 20 10 f2
                jsr sub406                   ; ef9a: 20 15 f1
                jmp cod664                   ; ef9d: 4c 90 f0
+               cmp #$1d                     ; efa0: c9 1d
                bne +                        ; efa2: d0 09
                jsr sub413                   ; efa4: 20 3f f2
                jsr sub407                   ; efa7: 20 84 f1
                jmp cod664                   ; efaa: 4c 90 f0
+               cmp #$1e                     ; efad: c9 1e
                bne cod654                   ; efaf: d0 12
                lda ram30                    ; efb1: a5 31
                cmp dat131,x                 ; efb3: dd 6d ee
                beq +                        ; efb6: f0 08
                jsr sub415                   ; efb8: 20 66 f2
                jsr sub410                   ; efbb: 20 f7 f1
                dec arr29                    ; efbe: c6 42
+               jmp cod664                   ; efc0: 4c 90 f0
cod654          cmp #$1f                     ; efc3: c9 1f
                bne cod655                   ; efc5: d0 12
                lda ram30                    ; efc7: a5 31
                cmp dat132,x                 ; efc9: dd 72 ee
                beq +                        ; efcc: f0 08
                jsr sub414                   ; efce: 20 59 f2
                jsr sub408                   ; efd1: 20 de f1
                inc arr29                    ; efd4: e6 42
+               jmp cod664                   ; efd6: 4c 90 f0
cod655          cmp #$0d                     ; efd9: c9 0d
                bne cod656                   ; efdb: d0 1b
                jsr sub419                   ; efdd: 20 91 f2
                lda #$20                     ; efe0: a9 20
                sta arr16                    ; efe2: 85 23
                lda #4                       ; efe4: a9 04
                sta ram143                   ; efe6: 85 fe
sub403          lda #$d6                     ; efe8: a9 d6
                sta arr129                   ; efea: 8d c3 02
                lda #$a4                     ; efed: a9 a4
                sta ram161                   ; efef: 8d c0 02
                sta ram36                    ; eff2: 85 3c
                jsr sub433                   ; eff4: 20 e1 f4
                rts                          ; eff7: 60
cod656          cmp #$c1                     ; eff8: c9 c1
                bcc cod658                   ; effa: 90 05
                cmp #$c9                     ; effc: c9 c9
                bcs cod658                   ; effe: b0 01
cod657          rts                          ; f000: 60
cod658          lda arr24                    ; f001: a5 38
                cmp #8                       ; f003: c9 08
                bne +                        ; f005: d0 13
                lda ram164                   ; f007: ad 00 03
                bne cod657                   ; f00a: d0 f4
                jsr sub405                   ; f00c: 20 d4 f0
                bne cod657                   ; f00f: d0 ef
                jsr sub429                   ; f011: 20 73 f4
                jsr sub420                   ; f014: 20 a9 f2
                jmp cod664                   ; f017: 4c 90 f0
+               cmp #$12                     ; f01a: c9 12
                bne +                        ; f01c: d0 13
                lda ram164                   ; f01e: ad 00 03
                bne cod657                   ; f021: d0 dd
                jsr sub405                   ; f023: 20 d4 f0
                bne cod657                   ; f026: d0 d8
                jsr sub429                   ; f028: 20 73 f4
                jsr sub421                   ; f02b: 20 4b f3
                jmp cod664                   ; f02e: 4c 90 f0
+               cmp #$20                     ; f031: c9 20
                bcs +                        ; f033: b0 09
                cpx #4                       ; f035: e0 04
                bne cod665                   ; f037: d0 60
                jsr sub432                   ; f039: 20 c8 f4
                beq cod665                   ; f03c: f0 5b
+               tay                          ; f03e: a8
                jsr sub405                   ; f03f: 20 d4 f0
                bne cod663                   ; f042: d0 46
                ldx ram29                    ; f044: a6 2f
                lda ram28                    ; f046: a5 2e
                beq +                        ; f048: f0 07
                tya                          ; f04a: 98
                sta arr195,x                 ; f04b: 9d 3d 07
                jmp cod659                   ; f04e: 4c 55 f0
+               tya                          ; f051: 98
                sta arr176,x                 ; f052: 9d 3d 06
cod659          cmp #$20                     ; f055: c9 20
                beq cod662                   ; f057: f0 1d
                lda ram33                    ; f059: a5 36
                cmp #3                       ; f05b: c9 03
                beq cod661                   ; f05d: f0 13
                cmp #4                       ; f05f: c9 04
                bne +                        ; f061: d0 06
                jsr sub404                   ; f063: 20 b5 f0
                jmp cod660                   ; f066: 4c 6d f0
+               lda #$40                     ; f069: a9 40
                sta ram143                   ; f06b: 85 fe
cod660          lda #$10                     ; f06d: a9 10
                sta arr16                    ; f06f: 85 23
                rts                          ; f071: 60
cod661          lda #4                       ; f072: a9 04
                sta arr105                   ; f074: 85 ff
cod662          lda arr24                    ; f076: a5 38
                cmp #$0d                     ; f078: c9 0d
                beq cod665                   ; f07a: f0 1d
                jsr sub418                   ; f07c: 20 88 f2
                lda arr24                    ; f07f: a5 38
                ldx ram33                    ; f081: a6 36
                cmp dat130,x                 ; f083: dd 68 ee
                beq cod666                   ; f086: f0 12
                inc arr25                    ; f088: e6 3a
cod663          jsr sub412                   ; f08a: 20 10 f2
                jsr sub406                   ; f08d: 20 15 f1
cod664          lda ram33                    ; f090: a5 36
                cmp #3                       ; f092: c9 03
                beq cod665                   ; f094: f0 03
                jsr sub434                   ; f096: 20 0f f5
cod665          rts                          ; f099: 60
cod666          inc arr77                    ; f09a: e6 b0
                ldx ram29                    ; f09c: a6 2f
-               lda arr176,x                 ; f09e: bd 3d 06
                cmp #$0d                     ; f0a1: c9 0d
                beq +                        ; f0a3: f0 0a
                cmp #$20                     ; f0a5: c9 20
                beq +                        ; f0a7: f0 06
                inx                          ; f0a9: e8
                cpx #$d9                     ; f0aa: e0 d9
                bcc -                        ; f0ac: 90 f0
                rts                          ; f0ae: 60
+               lda #$20                     ; f0af: a9 20
                sta arr176,x                 ; f0b1: 9d 3d 06
                rts                          ; f0b4: 60
sub404          lda arr29                    ; f0b5: a5 42
                and #%00000011               ; f0b7: 29 03
                tay                          ; f0b9: a8
                lda arr24                    ; f0ba: a5 38
                cpy #0                       ; f0bc: c0 00
                bne +                        ; f0be: d0 04
                jsr sub347                   ; f0c0: 20 cf e5
                rts                          ; f0c3: 60
+               cpy #1                       ; f0c4: c0 01
                bne +                        ; f0c6: d0 04
                jsr sub348                   ; f0c8: 20 f4 e5
                rts                          ; f0cb: 60
+               cpy #2                       ; f0cc: c0 02
                bne +                        ; f0ce: d0 03
                jsr sub349                   ; f0d0: 20 19 e6
+               rts                          ; f0d3: 60
sub405          lda ram33                    ; f0d4: a5 36
                cmp #4                       ; f0d6: c9 04
                bne cod667                   ; f0d8: d0 1d
                ldx #0                       ; f0da: a2 00
-               lda dat141,x                 ; f0dc: bd c9 ee
                cmp #$ff                     ; f0df: c9 ff
                beq cod667                   ; f0e1: f0 14
                cmp ram28                    ; f0e3: c5 2e
                bne +                        ; f0e5: d0 0c
                lda ram29                    ; f0e7: a5 2f
                cmp dat142,x                 ; f0e9: dd cd ee
                bcc +                        ; f0ec: 90 05
                cmp dat143,x                 ; f0ee: dd d0 ee
                bcc cod668                   ; f0f1: 90 07
+               inx                          ; f0f3: e8
                jmp -                        ; f0f4: 4c dc f0
cod667          lda #0                       ; f0f7: a9 00
                rts                          ; f0f9: 60
cod668          lda #1                       ; f0fa: a9 01
                rts                          ; f0fc: 60
                ldx ram29                    ; f0fd: a6 2f
-               cpx #0                       ; f0ff: e0 00
                beq +                        ; f101: f0 0c
                dex                          ; f103: ca
                lda arr176,x                 ; f104: bd 3d 06
                cmp #$3d                     ; f107: c9 3d
                beq cod669                   ; f109: f0 07
                cmp #$0d                     ; f10b: c9 0d
                bne -                        ; f10d: d0 f0
+               lda #0                       ; f10f: a9 00
                rts                          ; f111: 60
cod669          lda #1                       ; f112: a9 01
                rts                          ; f114: 60
sub406          txa                          ; f115: 8a
                pha                          ; f116: 48
                ldx ram33                    ; f117: a6 36
                lda dat128,x                 ; f119: bd 59 ee
                cmp ram28                    ; f11c: c5 2e
                bne +                        ; f11e: d0 1d
                lda ram29                    ; f120: a5 2f
                cmp $ee5e,x                  ; f122: dd 5e ee
                bcs cod672                   ; f125: b0 54
                cpx #4                       ; f127: e0 04
                bne +                        ; f129: d0 12
                lda ram28                    ; f12b: a5 2e
                beq +                        ; f12d: f0 0e
                lda ram29                    ; f12f: a5 2f
                cmp #$1f                     ; f131: c9 1f
                beq cod672                   ; f133: f0 46
                cmp #$37                     ; f135: c9 37
                beq cod672                   ; f137: f0 42
                cmp #$4f                     ; f139: c9 4f
                beq cod672                   ; f13b: f0 3e
+               jsr sub416                   ; f13d: 20 73 f2
                lda arr20                    ; f140: a5 30
                cmp $ee77,x                  ; f142: dd 77 ee
                bne cod670                   ; f145: d0 21
                lda dat133,x                 ; f147: bd 7c ee
                sta arr20                    ; f14a: 85 30
                cpx #4                       ; f14c: e0 04
                bne +                        ; f14e: d0 12
                jsr sub408                   ; f150: 20 de f1
                jsr sub408                   ; f153: 20 de f1
                jsr sub408                   ; f156: 20 de f1
                jsr sub414                   ; f159: 20 59 f2
                jsr sub414                   ; f15c: 20 59 f2
                jsr sub414                   ; f15f: 20 59 f2
+               jsr sub409                   ; f162: 20 ee f1
                jmp cod671                   ; f165: 4c 6f f1
cod670          lda arr20                    ; f168: a5 30
                clc                          ; f16a: 18
                adc #8                       ; f16b: 69 08
                sta arr20                    ; f16d: 85 30
cod671          cpx #4                       ; f16f: e0 04
                bne cod673                   ; f171: d0 0a
                inc arr22                    ; f173: e6 34
                jsr sub426                   ; f175: 20 27 f4
                jmp cod673                   ; f178: 4c 7d f1
cod672          lda #2                       ; f17b: a9 02
cod673          sta arr1                     ; f17d: 85 00
                pla                          ; f17f: 68
                tax                          ; f180: aa
                lda arr1                     ; f181: a5 00
                rts                          ; f183: 60
sub407          ldx ram33                    ; f184: a6 36
                lda ram28                    ; f186: a5 2e
                ora ram29                    ; f188: 05 2f
                beq cod677                   ; f18a: f0 51
                cpx #4                       ; f18c: e0 04
                bne cod674                   ; f18e: d0 12
                lda ram28                    ; f190: a5 2e
                bne cod674                   ; f192: d0 0e
                lda ram29                    ; f194: a5 2f
                cmp #$18                     ; f196: c9 18
dat147          beq cod677                   ; f198: f0 43
                cmp #$30                     ; f19a: c9 30
                beq cod677                   ; f19c: f0 3f
                cmp #$48                     ; f19e: c9 48
                beq cod677                   ; f1a0: f0 3b
cod674          jsr sub417                   ; f1a2: 20 7a f2
                lda arr20                    ; f1a5: a5 30
                cmp dat133,x                 ; f1a7: dd 7c ee
                bne cod675                   ; f1aa: d0 21
                lda $ee77,x                  ; f1ac: bd 77 ee
                sta arr20                    ; f1af: 85 30
                cpx #4                       ; f1b1: e0 04
                bne +                        ; f1b3: d0 12
                jsr sub410                   ; f1b5: 20 f7 f1
                jsr sub410                   ; f1b8: 20 f7 f1
                jsr sub410                   ; f1bb: 20 f7 f1
                jsr sub415                   ; f1be: 20 66 f2
                jsr sub415                   ; f1c1: 20 66 f2
                jsr sub415                   ; f1c4: 20 66 f2
+               jsr sub411                   ; f1c7: 20 07 f2
                jmp cod676                   ; f1ca: 4c d4 f1
cod675          lda arr20                    ; f1cd: a5 30
                sec                          ; f1cf: 38
                sbc #8                       ; f1d0: e9 08
                sta arr20                    ; f1d2: 85 30
cod676          cpx #4                       ; f1d4: e0 04
                bne cod677                   ; f1d6: d0 05
                dec arr22                    ; f1d8: c6 34
                jsr sub428                   ; f1da: 20 53 f4
cod677          rts                          ; f1dd: 60
sub408          ldx ram33                    ; f1de: a6 36
                lda ram29                    ; f1e0: a5 2f
                clc                          ; f1e2: 18
                adc dat129,x                 ; f1e3: 7d 63 ee
                sta ram29                    ; f1e6: 85 2f
                lda ram28                    ; f1e8: a5 2e
                adc #0                       ; f1ea: 69 00
                sta ram28                    ; f1ec: 85 2e
sub409          lda ram30                    ; f1ee: a5 31
                clc                          ; f1f0: 18
                adc dat134,x                 ; f1f1: 7d 81 ee
                sta ram30                    ; f1f4: 85 31
                rts                          ; f1f6: 60
sub410          ldx ram33                    ; f1f7: a6 36
                lda ram29                    ; f1f9: a5 2f
                sec                          ; f1fb: 38
                sbc dat129,x                 ; f1fc: fd 63 ee
                sta ram29                    ; f1ff: 85 2f
                lda ram28                    ; f201: a5 2e
                sbc #0                       ; f203: e9 00
                sta ram28                    ; f205: 85 2e
sub411          lda ram30                    ; f207: a5 31
                sec                          ; f209: 38
                sbc dat134,x                 ; f20a: fd 81 ee
                sta ram30                    ; f20d: 85 31
                rts                          ; f20f: 60
sub412          txa                          ; f210: 8a
                pha                          ; f211: 48
                tya                          ; f212: 98
                pha                          ; f213: 48
                ldx ram33                    ; f214: a6 36
                lda dat128,x                 ; f216: bd 59 ee
                ldy arr61                    ; f219: a4 79
                bne +                        ; f21b: d0 04
                cpx #4                       ; f21d: e0 04
                beq cod679                   ; f21f: f0 15
+               cmp ram28                    ; f221: c5 2e
                bne +                        ; f223: d0 07
                lda ram29                    ; f225: a5 2f
                cmp $ee5e,x                  ; f227: dd 5e ee
                bcs cod678                   ; f22a: b0 08
+               inc arr22                    ; f22c: e6 34
                jsr sub426                   ; f22e: 20 27 f4
                jmp cod679                   ; f231: 4c 36 f2
cod678          lda #2                       ; f234: a9 02
cod679          sta arr1                     ; f236: 85 00
                pla                          ; f238: 68
                tay                          ; f239: a8
                pla                          ; f23a: 68
                tax                          ; f23b: aa
                lda arr1                     ; f23c: a5 00
                rts                          ; f23e: 60
sub413          txa                          ; f23f: 8a
                pha                          ; f240: 48
                tya                          ; f241: 98
                pha                          ; f242: 48
                ldx ram33                    ; f243: a6 36
                lda ram28                    ; f245: a5 2e
                ora ram29                    ; f247: 05 2f
                beq +                        ; f249: f0 09
                cpx #4                       ; f24b: e0 04
                beq cod678                   ; f24d: f0 e5
                dec arr22                    ; f24f: c6 34
                jsr sub428                   ; f251: 20 53 f4
+               pla                          ; f254: 68
                tay                          ; f255: a8
                pla                          ; f256: 68
                tax                          ; f257: aa
                rts                          ; f258: 60
sub414          lda arr22                    ; f259: a5 34
                clc                          ; f25b: 18
                adc dat139,x                 ; f25c: 7d a4 ee
                sta arr22                    ; f25f: 85 34
                bcc +                        ; f261: 90 02
                inc arr21                    ; f263: e6 32
+               rts                          ; f265: 60
sub415          lda arr22                    ; f266: a5 34
                sec                          ; f268: 38
                sbc dat139,x                 ; f269: fd a4 ee
                sta arr22                    ; f26c: 85 34
                bcs +                        ; f26e: b0 02
                dec arr21                    ; f270: c6 32
+               rts                          ; f272: 60
sub416          inc ram29                    ; f273: e6 2f
                bne +                        ; f275: d0 02
                inc ram28                    ; f277: e6 2e
+               rts                          ; f279: 60
sub417          lda ram29                    ; f27a: a5 2f
                sec                          ; f27c: 38
                sbc #1                       ; f27d: e9 01
                sta ram29                    ; f27f: 85 2f
                lda ram28                    ; f281: a5 2e
                sbc #0                       ; f283: e9 00
                sta ram28                    ; f285: 85 2e
                rts                          ; f287: 60
sub418          jsr sub423                   ; f288: 20 02 f4
                lda arr24                    ; f28b: a5 38
                sta arr134                   ; f28d: 8d 04 03
                rts                          ; f290: 60
sub419          ldx ram33                    ; f291: a6 36
-               jsr sub406                   ; f293: 20 15 f1
                cpx #4                       ; f296: e0 04
                beq +                        ; f298: f0 03
                jsr sub412                   ; f29a: 20 10 f2
+               cmp #0                       ; f29d: c9 00
                beq -                        ; f29f: f0 f2
                cmp #2                       ; f2a1: c9 02
                bne +                        ; f2a3: d0 03
                jsr sub401                   ; f2a5: 20 0d ef
+               rts                          ; f2a8: 60
sub420          ldx ram33                    ; f2a9: a6 36
                lda arr20                    ; f2ab: a5 30
                cmp dat133,x                 ; f2ad: dd 7c ee
                beq +                        ; f2b0: f0 06
                jsr sub413                   ; f2b2: 20 3f f2
                jsr sub407                   ; f2b5: 20 84 f1
+               lda ram29                    ; f2b8: a5 2f
                sta ram4                     ; f2ba: 85 09
                lda ram28                    ; f2bc: a5 2e
                sta ram5                     ; f2be: 85 0a
                jsr sub418                   ; f2c0: 20 88 f2
                lda arr21                    ; f2c3: a5 32
                sta ram3                     ; f2c5: 85 07
                lda arr22                    ; f2c7: a5 34
                sta arr6                     ; f2c9: 85 08
                ldx #1                       ; f2cb: a2 01
                ldy ram29                    ; f2cd: a4 2f
cod680          lda ram28                    ; f2cf: a5 2e
                bne cod681                   ; f2d1: d0 0d
                lda arr177,y                 ; f2d3: b9 3e 06
                cpy #$ff                     ; f2d6: c0 ff
                bne +                        ; f2d8: d0 03
                lda arr195                   ; f2da: ad 3d 07
+               jmp cod682                   ; f2dd: 4c e3 f2
cod681          lda arr196,y                 ; f2e0: b9 3e 07
cod682          sta arr133,x                 ; f2e3: 9d 03 03
                sta ram6                     ; f2e6: 85 0b
                inx                          ; f2e8: e8
                inc arr22                    ; f2e9: e6 34
                txa                          ; f2eb: 8a
                pha                          ; f2ec: 48
                tya                          ; f2ed: 98
                pha                          ; f2ee: 48
                jsr sub426                   ; f2ef: 20 27 f4
                pla                          ; f2f2: 68
                tay                          ; f2f3: a8
                pla                          ; f2f4: 68
                tax                          ; f2f5: aa
                lda ram110                   ; f2f6: a5 bb
                bne cod684                   ; f2f8: d0 19
                lda ram28                    ; f2fa: a5 2e
                bne +                        ; f2fc: d0 08
                lda ram6                     ; f2fe: a5 0b
                sta arr176,y                 ; f300: 99 3d 06
                jmp cod683                   ; f303: 4c 0b f3
+               lda ram6                     ; f306: a5 0b
                sta arr195,y                 ; f308: 99 3d 07
cod683          jsr sub416                   ; f30b: 20 73 f2
                ldy ram29                    ; f30e: a4 2f
                jmp cod680                   ; f310: 4c cf f2
cod684          lda #$20                     ; f313: a9 20
                sta arr132,x                 ; f315: 9d 02 03
                lda ram28                    ; f318: a5 2e
                bne +                        ; f31a: d0 08
                lda #$20                     ; f31c: a9 20
                sta arr176,y                 ; f31e: 99 3d 06
                jmp cod685                   ; f321: 4c 29 f3
+               lda #$20                     ; f324: a9 20
                sta arr195,y                 ; f326: 99 3d 07
cod685          sta arr133,x                 ; f329: 9d 03 03
                stx arr133                   ; f32c: 8e 03 03
                inx                          ; f32f: e8
                lda #0                       ; f330: a9 00
                sta arr133,x                 ; f332: 9d 03 03
                inx                          ; f335: e8
                inx                          ; f336: e8
                stx ram164                   ; f337: 8e 00 03
                lda ram3                     ; f33a: a5 07
                sta arr21                    ; f33c: 85 32
                lda arr6                     ; f33e: a5 08
                sta arr22                    ; f340: 85 34
                lda ram4                     ; f342: a5 09
                sta ram29                    ; f344: 85 2f
                lda ram5                     ; f346: a5 0a
                sta ram28                    ; f348: 85 2e
                rts                          ; f34a: 60
sub421          lda arr21                    ; f34b: a5 32
                sta ram3                     ; f34d: 85 07
                lda arr22                    ; f34f: a5 34
                sta arr6                     ; f351: 85 08
                ldy ram29                    ; f353: a4 2f
                sty ram4                     ; f355: 84 09
                jsr sub418                   ; f357: 20 88 f2
                ldx #1                       ; f35a: a2 01
                lda ram28                    ; f35c: a5 2e
                sta ram6                     ; f35e: 85 0b
                bne +                        ; f360: d0 0c
                lda arr176,y                 ; f362: b9 3d 06
                pha                          ; f365: 48
                lda #$20                     ; f366: a9 20
                sta arr176,y                 ; f368: 99 3d 06
                jmp cod686                   ; f36b: 4c 77 f3
+               lda arr195,y                 ; f36e: b9 3d 07
                pha                          ; f371: 48
                lda #$20                     ; f372: a9 20
                sta arr195,y                 ; f374: 99 3d 07
cod686          sta arr133,x                 ; f377: 9d 03 03
                pla                          ; f37a: 68
                sta ram5                     ; f37b: 85 0a
                inc arr22                    ; f37d: e6 34
                txa                          ; f37f: 8a
                pha                          ; f380: 48
                tya                          ; f381: 98
                pha                          ; f382: 48
                jsr sub426                   ; f383: 20 27 f4
                pla                          ; f386: 68
                tay                          ; f387: a8
                pla                          ; f388: 68
                tax                          ; f389: aa
                lda ram110                   ; f38a: a5 bb
                bne cod691                   ; f38c: d0 46
                lda arr6                     ; f38e: a5 08
                sta arr22                    ; f390: 85 34
cod687          lda ram28                    ; f392: a5 2e
                bne +                        ; f394: d0 06
                lda arr177,y                 ; f396: b9 3e 06
                jmp cod688                   ; f399: 4c 9f f3
+               lda arr196,y                 ; f39c: b9 3e 07
cod688          pha                          ; f39f: 48
                inx                          ; f3a0: e8
                lda ram5                     ; f3a1: a5 0a
                sta arr133,x                 ; f3a3: 9d 03 03
                inc arr22                    ; f3a6: e6 34
                txa                          ; f3a8: 8a
                pha                          ; f3a9: 48
                tya                          ; f3aa: 98
                pha                          ; f3ab: 48
                jsr sub426                   ; f3ac: 20 27 f4
                pla                          ; f3af: 68
                tay                          ; f3b0: a8
                pla                          ; f3b1: 68
                tax                          ; f3b2: aa
                lda ram110                   ; f3b3: a5 bb
                bne cod690                   ; f3b5: d0 1c
                lda ram28                    ; f3b7: a5 2e
                bne +                        ; f3b9: d0 08
                lda ram5                     ; f3bb: a5 0a
                sta arr177,y                 ; f3bd: 99 3e 06
                jmp cod689                   ; f3c0: 4c c8 f3
+               lda ram5                     ; f3c3: a5 0a
                sta arr196,y                 ; f3c5: 99 3e 07
cod689          pla                          ; f3c8: 68
                sta ram5                     ; f3c9: 85 0a
                jsr sub416                   ; f3cb: 20 73 f2
                ldy ram29                    ; f3ce: a4 2f
                jmp cod687                   ; f3d0: 4c 92 f3
cod690          pla                          ; f3d3: 68
cod691          lda #$20                     ; f3d4: a9 20
                sta arr133,x                 ; f3d6: 9d 03 03
                stx arr133                   ; f3d9: 8e 03 03
                inx                          ; f3dc: e8
                lda #0                       ; f3dd: a9 00
                sta arr133,x                 ; f3df: 9d 03 03
                inx                          ; f3e2: e8
                inx                          ; f3e3: e8
                stx ram164                   ; f3e4: 8e 00 03
                lda ram3                     ; f3e7: a5 07
                sta arr21                    ; f3e9: 85 32
                lda arr6                     ; f3eb: a5 08
                sta arr22                    ; f3ed: 85 34
                lda ram4                     ; f3ef: a5 09
                sta ram29                    ; f3f1: 85 2f
                lda ram6                     ; f3f3: a5 0b
                sta ram28                    ; f3f5: 85 2e
                rts                          ; f3f7: 60
sub422          txa                          ; f3f8: 8a
                pha                          ; f3f9: 48
                ldx #1                       ; f3fa: a2 01
                jsr sub424                   ; f3fc: 20 04 f4
                pla                          ; f3ff: 68
                tax                          ; f400: aa
                rts                          ; f401: 60
sub423          ldx #0                       ; f402: a2 00
sub424          lda arr22,x                  ; f404: b5 34
                sta arr1                     ; f406: 85 00
                lda arr21,x                  ; f408: b5 32
                sta arr2                     ; f40a: 85 01
                lda #$57                     ; f40c: a9 57
                sta arr3                     ; f40e: 85 02
                lda #$ee                     ; f410: a9 ee
                sta ram1                     ; f412: 85 03
                jmp sub395                   ; f414: 4c 65 ed
sub425          txa                          ; f417: 8a
                pha                          ; f418: 48
                tya                          ; f419: 98
                pha                          ; f41a: 48
                ldx #1                       ; f41b: a2 01
                inc ram32                    ; f41d: e6 35
                jsr sub427                   ; f41f: 20 29 f4
                pla                          ; f422: 68
                tay                          ; f423: a8
                pla                          ; f424: 68
                tax                          ; f425: aa
                rts                          ; f426: 60
sub426          ldx #0                       ; f427: a2 00
sub427          lda #0                       ; f429: a9 00
                sta ram110                   ; f42b: 85 bb
                ldy ram33                    ; f42d: a4 36
                lda arr22,x                  ; f42f: b5 34
                and #%00010000               ; f431: 29 10
                beq +                        ; f433: f0 1b
                lda arr22,x                  ; f435: b5 34
                and #%00001111               ; f437: 29 0f
                cmp $ee90,y                  ; f439: d9 90 ee
                bne +                        ; f43c: d0 12
                inc ram110                   ; f43e: e6 bb
                lda arr22,x                  ; f440: b5 34
                and #%11110000               ; f442: 29 f0
                clc                          ; f444: 18
                adc dat137,y                 ; f445: 79 9a ee
                sta arr22,x                  ; f448: 95 34
                lda arr21,x                  ; f44a: b5 32
                adc #0                       ; f44c: 69 00
                sta arr21,x                  ; f44e: 95 32
+               lda ram110                   ; f450: a5 bb
                rts                          ; f452: 60
sub428          ldy ram33                    ; f453: a4 36
                lda arr22                    ; f455: a5 34
                and #%00010000               ; f457: 29 10
                bne +                        ; f459: d0 17
                lda arr22                    ; f45b: a5 34
                and #%00001111               ; f45d: 29 0f
                cmp dat136,y                 ; f45f: d9 95 ee
                bne +                        ; f462: d0 0e
                lda arr22                    ; f464: a5 34
                sec                          ; f466: 38
                sbc dat138,y                 ; f467: f9 9f ee
                sta arr22                    ; f46a: 85 34
                lda arr21                    ; f46c: a5 32
                sbc #0                       ; f46e: e9 00
                sta arr21                    ; f470: 85 32
+               rts                          ; f472: 60
sub429          lda arr21                    ; f473: a5 32
                sta ram31                    ; f475: 85 33
                lda arr22                    ; f477: a5 34
                sta ram32                    ; f479: 85 35
                ldx ram29                    ; f47b: a6 2f
-               lda arr176,x                 ; f47d: bd 3d 06
                cmp #$3d                     ; f480: c9 3d
                beq +                        ; f482: f0 11
                cmp #$0d                     ; f484: c9 0d
                beq cod692                   ; f486: f0 23
                cmp #$20                     ; f488: c9 20
                beq cod692                   ; f48a: f0 1f
                jsr sub425                   ; f48c: 20 17 f4
                inx                          ; f48f: e8
                cpx #$d9                     ; f490: e0 d9
                bcc -                        ; f492: 90 e9
                rts                          ; f494: 60
+               lda arr23                    ; f495: a5 37
                cmp #8                       ; f497: c9 08
                beq cod692                   ; f499: f0 10
                cmp #$12                     ; f49b: c9 12
                beq cod692                   ; f49d: f0 0c
                jsr sub422                   ; f49f: 20 f8 f3
                lda #$20                     ; f4a2: a9 20
                sta ram165                   ; f4a4: 8d 08 03
                sta arr176,x                 ; f4a7: 9d 3d 06
                rts                          ; f4aa: 60
cod692          lda #$20                     ; f4ab: a9 20
dat148          sta arr176,x                 ; f4ad: 9d 3d 06
                rts                          ; f4b0: 60
sub430          ldx #0                       ; f4b1: a2 00
sub431          ldy #0                       ; f4b3: a0 00
-               lda dat144,x                 ; f4b5: bd d3 ee
                sta arr159,y                 ; f4b8: 99 80 04
                inx                          ; f4bb: e8
                tya                          ; f4bc: 98
                clc                          ; f4bd: 18
                adc #$10                     ; f4be: 69 10
                tay                          ; f4c0: a8
                cpy #$80                     ; f4c1: c0 80
                bcc -                        ; f4c3: 90 f0
                jmp sub266                   ; f4c5: 4c 13 cf
sub432          ldy arr53                    ; f4c8: a4 70
                beq +                        ; f4ca: f0 0c
                ldy #0                       ; f4cc: a0 00
-               cmp dat145,y                 ; f4ce: d9 eb ee
                beq cod693                   ; f4d1: f0 08
                iny                          ; f4d3: c8
                cpy #8                       ; f4d4: c0 08
                bmi -                        ; f4d6: 30 f6
+               lda #0                       ; f4d8: a9 00
                rts                          ; f4da: 60
cod693          lda dat146,y                 ; f4db: b9 f3 ee
                sta arr24                    ; f4de: 85 38
                rts                          ; f4e0: 60
sub433          lda arr16                    ; f4e1: a5 23
                and #%00001111               ; f4e3: 29 0f
                tax                          ; f4e5: aa
                lda arr129                   ; f4e6: ad c3 02
                clc                          ; f4e9: 18
                adc $eea9,x                  ; f4ea: 7d a9 ee
                sta arr1                     ; f4ed: 85 00
                lda ram161                   ; f4ef: ad c0 02
                clc                          ; f4f2: 18
                adc dat140,x                 ; f4f3: 7d b9 ee
                sta arr2                     ; f4f6: 85 01
                lda ram36                    ; f4f8: a5 3c
                beq +                        ; f4fa: f0 10
                lda #$20                     ; f4fc: a9 20
                sta arr15                    ; f4fe: 85 21
                lda arr129                   ; f500: ad c3 02
                sta arr1                     ; f503: 85 00
                lda #$e8                     ; f505: a9 e8
                sta arr3                     ; f507: 85 02
                jmp cod695                   ; f509: 4c 1f f5
+               jmp cod694                   ; f50c: 4c 17 f5
sub434          lda arr20                    ; f50f: a5 30
                sta arr1                     ; f511: 85 00
                lda ram30                    ; f513: a5 31
                sta arr2                     ; f515: 85 01
cod694          lda #$e0                     ; f517: a9 e0
                sta arr3                     ; f519: 85 02
                lda #0                       ; f51b: a9 00
                sta ram36                    ; f51d: 85 3c
cod695          lda arr1                     ; f51f: a5 00
                pha                          ; f521: 48
                lda arr2                     ; f522: a5 01
                pha                          ; f524: 48
                lda arr3                     ; f525: a5 02
                pha                          ; f527: 48
                jsr sub274                   ; f528: 20 83 d1
                lda arr55                    ; f52b: a5 72
                beq +                        ; f52d: f0 03
                jsr sub275                   ; f52f: 20 8c d1
+               pla                          ; f532: 68
                sta arr3                     ; f533: 85 02
                pla                          ; f535: 68
                sta arr2                     ; f536: 85 01
                pla                          ; f538: 68
                sta arr1                     ; f539: 85 00
                lda #$24                     ; f53b: a9 24
                sta ram1                     ; f53d: 85 03
                lda #$c0                     ; f53f: a9 c0
                sta ram2                     ; f541: 85 04
                jmp sub391                   ; f543: 4c be ec
sub435          lda ram35                    ; f546: a5 3b
                and #%00010000               ; f548: 29 10
                beq +                        ; f54a: f0 05
                lda #$f8                     ; f54c: a9 f8
                jmp cod696                   ; f54e: 4c 53 f5
+               lda ram30                    ; f551: a5 31
cod696          sta ram161                   ; f553: 8d c0 02
                lda arr20                    ; f556: a5 30
                sta arr129                   ; f558: 8d c3 02
                lda #$dd                     ; f55b: a9 dd
                sta ram162                   ; f55d: 8d c1 02
                lda arr55                    ; f560: a5 72
                beq +                        ; f562: f0 05
                lda #$dc                     ; f564: a9 dc
                sta ram162                   ; f566: 8d c1 02
+               lda #0                       ; f569: a9 00
                sta ram163                   ; f56b: 8d c2 02
                rts                          ; f56e: 60

                hex ff                       ; f56f

dat149          ora misc25,x                 ; f570: 1d 20 23
dat150          brk                          ; f573: 00
                brk                          ; f574: 00
                brk                          ; f575: 00

                hex 04 04                    ; f576

                php                          ; f578: 08
                brk                          ; f579: 00
                brk                          ; f57a: 00
                brk                          ; f57b: 00
                brk                          ; f57c: 00
                brk                          ; f57d: 00
dat151          brk                          ; f57e: 00

                hex 04                       ; f57f

                php                          ; f580: 08

                hex 0c                       ; f581

                bpl cod698                   ; f582: 10 14
cod697          clc                          ; f584: 18

                hex 1c                       ; f585

                jsr misc32                   ; f586: 20 24 28
dat152          bmi $f5bb                    ; f589: 30 30
                bmi $f5be                    ; f58b: 30 31
                and (arr24),y                ; f58d: 31 38
                rol arr24,x                  ; f58f: 36 38
                and (ram34),y                ; f591: 31 39
                and (arr21),y                ; f593: 31 32
dat153          bmi $f5c7                    ; f595: 30 30

                hex 34                       ; f597
cod698          hex 34                       ; f598

                bmi +                        ; f599: 30 30
                and (arr22),y                ; f59b: 31 34
                bmi cod699                   ; f59d: 30 39
                and misc49,y                 ; f59f: 39 39 32
                and misc52,y                 ; f5a2: 39 32 34
                and (ram34),y                ; f5a5: 31 39
                and (ram30),y                ; f5a7: 31 31
                and (ram34),y                ; f5a9: 31 39

                hex 32                       ; f5ab

                and arr20,x                  ; f5ac: 35 30
                bmi cod700                   ; f5ae: 30 31

                hex 32                       ; f5b0

                bmi cod701                   ; f5b1: 30 30

                hex 33                       ; f5b3

                and (arr20),y                ; f5b4: 31 30
                bmi $f5eb                    ; f5b6: 30 33
                bmi $f5ea                    ; f5b8: 30 30
                bmi $f5ee                    ; f5ba: 30 32
                sec                          ; f5bc: 38
                bmi cod702                   ; f5bd: 30 30

                hex 32                       ; f5bf

                and arr171,y                 ; f5c0: 39 07 06
                php                          ; f5c3: 08
                ora (arr2,x)                 ; f5c4: 01 01
                ora (ram4,x)                 ; f5c6: 01 09
                ora (arr4,x)                 ; f5c8: 01 05

                hex 02                       ; f5ca

+               ora #%00000001               ; f5cb: 09 01
dat154          eor misc144                  ; f5cd: 4d 54 53

                hex 07                       ; f5d0

                ora #%00000111               ; f5d1: 09 07
                php                          ; f5d3: 08

                hex 07                       ; f5d4

                php                          ; f5d5: 08

                hex 07 07                    ; f5d6

cod699          php                          ; f5d8: 08

                hex 07                       ; f5d9

                php                          ; f5da: 08

                hex 07                       ; f5db
dat155          hex e2                       ; f5dc

dat156          sbc arr99,x                  ; f5dd: f5 ee
                sbc arr104,x                 ; f5df: f5 fc
cod700          sbc arr3,x                   ; f5e1: f5 02
cod701          eor arr50                    ; f5e3: 45 67

                hex 77 64                    ; f5e5

                bmi cod697                   ; f5e7: 30 9b
                dec dat164                   ; f5e9: ce ff fe

                hex dc                       ; f5ec

                ldy #2                       ; f5ed: a0 02

cod702          hex 34                       ; f5ef

                lsr arr59,x                  ; f5f0: 56 77
                ror arr43,x                  ; f5f2: 76 54

                hex 32                       ; f5f4

                asl a                        ; f5f5: 0a
                ldy dat166,x                 ; f5f6: bc de ff
                inc $badc,x                  ; f5f9: fe dc ba
                ora (arr22,x)                ; f5fc: 01 34
                lsr arr50,x                  ; f5fe: 56 67

                hex 77                       ; f600

                ror arr43,x                  ; f601: 76 54

                hex 32                       ; f603

                ora #%10101011               ; f604: 09 ab
                cmp $ffef                    ; f606: cd ef ff
                inc dat98,x                  ; f609: fe ed cb
                bcc cod703                   ; f60c: 90 00
cod703          brk                          ; f60e: 00
dat157          brk                          ; f60f: 00
                brk                          ; f610: 00

                hex 03                       ; f611

                ora (arr1,x)                 ; f612: 01 00
                ora ram4                     ; f614: 05 09
                brk                          ; f616: 00
                ora #%00000000               ; f617: 09 00
                ora (arr3,x)                 ; f619: 01 02
                brk                          ; f61b: 00
                ora (arr4,x)                 ; f61c: 01 05
                ora (arr2,x)                 ; f61e: 01 01
                php                          ; f620: 08
                ora (arr3,x)                 ; f621: 01 02
                ora (arr3,x)                 ; f623: 01 02

                hex 02 04 03 02 07 03 03     ; f625

                brk                          ; f62c: 00

                hex 04 03 03 04              ; f62d
dat158          hex 23                       ; f631

                plp                          ; f632: 28

                hex 33                       ; f633

                ldx #9                       ; f634: a2 09
-               lda arr89,x                  ; f636: b5 d0
                sta arr72,x                  ; f638: 95 a0
                lda arr164,x                 ; f63a: bd 30 05
                sta arr163,x                 ; f63d: 9d 20 05
                dex                          ; f640: ca
                bpl -                        ; f641: 10 f3
                jmp sub266                   ; f643: 4c 13 cf
                lda ram57                    ; f646: a5 6b
                sta ram73                    ; f648: 85 87
                lda arr56                    ; f64a: a5 73
                beq +                        ; f64c: f0 04
                lda #$0d                     ; f64e: a9 0d
                sta ram100                   ; f650: 85 af
+               jsr sub271                   ; f652: 20 5d d0
                beq cod705                   ; f655: f0 04
                jmp cod453                   ; f657: 4c f7 d0
cod704          rts                          ; f65a: 60
cod705          jsr sub269                   ; f65b: 20 c4 cf
                lda arr49                    ; f65e: a5 64
                beq cod704                   ; f660: f0 f8
                lda arr1                     ; f662: a5 00
                cmp #4                       ; f664: c9 04
                beq +                        ; f666: f0 09
                cmp #5                       ; f668: c9 05
                beq cod704                   ; f66a: f0 ee
                lda #$1d                     ; f66c: a9 1d
                jmp sub282                   ; f66e: 4c 9c d2
+               lda ram69                    ; f671: a5 82
                sta ram73                    ; f673: 85 87
                lda #$23                     ; f675: a9 23
                jmp sub282                   ; f677: 4c 9c d2
                lda arr56                    ; f67a: a5 73
                beq +                        ; f67c: f0 04
                lda #$20                     ; f67e: a9 20
                bne cod706                   ; f680: d0 02
+               lda #$10                     ; f682: a9 10
cod706          sta ram143                   ; f684: 85 fe
                jmp cod439                   ; f686: 4c d5 ce
                lda arr56                    ; f689: a5 73
                beq cod707                   ; f68b: f0 35
                ldx #9                       ; f68d: a2 09
-               lda arr89,x                  ; f68f: b5 d0
                and #%00001111               ; f691: 29 0f
                sta arr157,x                 ; f693: 9d 40 04
                dex                          ; f696: ca
                bpl -                        ; f697: 10 f6
                jsr sub443                   ; f699: 20 fb f7
                ldx #3                       ; f69c: a2 03
-               lda arr72,x                  ; f69e: b5 a0
                sta arr151,x                 ; f6a0: 9d 15 04
                dex                          ; f6a3: ca
                bpl -                        ; f6a4: 10 f8
                jsr sub357                   ; f6a6: 20 4b e7
                lda ram193                   ; f6a9: ad 3a 04
                cmp #$2d                     ; f6ac: c9 2d
                beq cod709                   ; f6ae: f0 4d
                lda ram188                   ; f6b0: ad 35 04
                and #%00001111               ; f6b3: 29 0f
                bne +                        ; f6b5: d0 07
                lda ram189                   ; f6b7: ad 36 04
                and #%00001111               ; f6ba: 29 0f
                beq cod708                   ; f6bc: f0 07
+               lda #$ff                     ; f6be: a9 ff
                bne cod710                   ; f6c0: d0 3d
cod707          jmp cod713                   ; f6c2: 4c 6f f7
cod708          jsr sub444                   ; f6c5: 20 0a f8
                ldx #8                       ; f6c8: a2 08
-               lda arr155,x                 ; f6ca: bd 30 04
                sta arr158,x                 ; f6cd: 9d 49 04
                dex                          ; f6d0: ca
                bpl -                        ; f6d1: 10 f7
                ldx #8                       ; f6d3: a2 08
-               lda arr72,x                  ; f6d5: b5 a0
                and #%00001111               ; f6d7: 29 0f
                sta arr157,x                 ; f6d9: 9d 40 04
                dex                          ; f6dc: ca
                bpl -                        ; f6dd: 10 f6
                jsr sub444                   ; f6df: 20 0a f8
                jsr sub438                   ; f6e2: 20 b4 f7
                ldx #8                       ; f6e5: a2 08
-               lda arr158,x                 ; f6e7: bd 49 04
                sta arr144,x                 ; f6ea: 9d 00 04
                dex                          ; f6ed: ca
                bpl -                        ; f6ee: 10 f7
                jsr sub442                   ; f6f0: 20 ef f7
                jsr sub357                   ; f6f3: 20 4b e7
                lda ram193                   ; f6f6: ad 3a 04
                cmp #$2d                     ; f6f9: c9 2d
                bne cod711                   ; f6fb: d0 07
cod709          lda #$fe                     ; f6fd: a9 fe
cod710          sta ram99                    ; f6ff: 85 ae
                jmp cod713                   ; f701: 4c 6f f7
cod711          ldx #4                       ; f704: a2 04
-               lda arr156,x                 ; f706: bd 34 04
                sta arr74,x                  ; f709: 95 aa
                dex                          ; f70b: ca
                bpl -                        ; f70c: 10 f8
                ldx #0                       ; f70e: a2 00
-               lda arr74,x                  ; f710: b5 aa
                cmp #$30                     ; f712: c9 30
                bne +                        ; f714: d0 09
                lda #$20                     ; f716: a9 20
                sta arr74,x                  ; f718: 95 aa
                inx                          ; f71a: e8
                cpx #4                       ; f71b: e0 04
                bne -                        ; f71d: d0 f1
+               jsr sub439                   ; f71f: 20 c9 f7
                ldx #2                       ; f722: a2 02
                stx arr5                     ; f724: 86 06
cod712          jsr sub440                   ; f726: 20 d5 f7
                ldx arr5                     ; f729: a6 06
                lda dat158,x                 ; f72b: bd 31 f6
                jsr sub437                   ; f72e: 20 9f f7
                jsr sub360                   ; f731: 20 86 e8
                jsr sub446                   ; f734: 20 c6 f8
                jsr sub441                   ; f737: 20 e2 f7
                ldx arr5                     ; f73a: a6 06
                lda dat158,x                 ; f73c: bd 31 f6
                jsr sub437                   ; f73f: 20 9f f7
                jsr sub359                   ; f742: 20 a3 e7
                jsr sub440                   ; f745: 20 d5 f7
                jsr sub442                   ; f748: 20 ef f7
                jsr sub357                   ; f74b: 20 4b e7
                lda ram191                   ; f74e: ad 38 04
                and #%00001111               ; f751: 29 0f
                tay                          ; f753: a8
                lda ram190                   ; f754: ad 37 04
                and #%00001111               ; f757: 29 0f
                beq +                        ; f759: f0 09
                tax                          ; f75b: aa
                tya                          ; f75c: 98
-               clc                          ; f75d: 18
                adc #$0a                     ; f75e: 69 0a
                dex                          ; f760: ca
                bne -                        ; f761: d0 fa
                tay                          ; f763: a8
+               tya                          ; f764: 98
                jsr sub436                   ; f765: 20 76 f7
                dec arr5                     ; f768: c6 06
                bpl cod712                   ; f76a: 10 ba
                jsr sub448                   ; f76c: 20 1d f9
cod713          lda #8                       ; f76f: a9 08
                sta arr105                   ; f771: 85 ff
                jmp cod439                   ; f773: 4c d5 ce
sub436          pha                          ; f776: 48
                lsr a                        ; f777: 4a
                tay                          ; f778: a8
                lda arr5                     ; f779: a5 06
                asl a                        ; f77b: 0a
                tax                          ; f77c: aa
                lda dat155,x                 ; f77d: bd dc f5
                sta arr1                     ; f780: 85 00
                lda dat156,x                 ; f782: bd dd f5
                sta arr2                     ; f785: 85 01
                lda (arr1),y                 ; f787: b1 00
                jsr sub437                   ; f789: 20 9f f7
                pla                          ; f78c: 68
                and #%00000001               ; f78d: 29 01
                bne cod715                   ; f78f: d0 08
                lda ram183                   ; f791: ad 17 04
cod714          ldx arr5                     ; f794: a6 06
                sta arr96,x                  ; f796: 95 dd
                rts                          ; f798: 60
cod715          lda ram184                   ; f799: ad 18 04
                jmp cod714                   ; f79c: 4c 94 f7
sub437          sta ram3                     ; f79f: 85 07
                lda ram3                     ; f7a1: a5 07
                and #%00001111               ; f7a3: 29 0f
                sta ram184                   ; f7a5: 8d 18 04
                lda ram3                     ; f7a8: a5 07
                lsr a                        ; f7aa: 4a
                lsr a                        ; f7ab: 4a
                lsr a                        ; f7ac: 4a
                lsr a                        ; f7ad: 4a
                and #%00001111               ; f7ae: 29 0f
                sta ram183                   ; f7b0: 8d 17 04
                rts                          ; f7b3: 60
sub438          ldx #$0a                     ; f7b4: a2 0a
                lda #$20                     ; f7b6: a9 20
-               sta arr150,x                 ; f7b8: 9d 10 04
                dex                          ; f7bb: ca
                bpl -                        ; f7bc: 10 fa
                ldx #$0a                     ; f7be: a2 0a
-               sta arr144,x                 ; f7c0: 9d 00 04
                dex                          ; f7c3: ca
                bpl -                        ; f7c4: 10 fa
                ldx #$0a                     ; f7c6: a2 0a
                rts                          ; f7c8: 60
sub439          ldx #$0a                     ; f7c9: a2 0a
-               lda arr155,x                 ; f7cb: bd 30 04
                sta arr153,x                 ; f7ce: 9d 20 04
                dex                          ; f7d1: ca
                bpl -                        ; f7d2: 10 f7
                rts                          ; f7d4: 60
sub440          jsr sub438                   ; f7d5: 20 b4 f7
-               lda arr153,x                 ; f7d8: bd 20 04
                sta arr144,x                 ; f7db: 9d 00 04
                dex                          ; f7de: ca
                bpl -                        ; f7df: 10 f7
                rts                          ; f7e1: 60
sub441          jsr sub438                   ; f7e2: 20 b4 f7
-               lda arr155,x                 ; f7e5: bd 30 04
                sta arr144,x                 ; f7e8: 9d 00 04
                dex                          ; f7eb: ca
                bpl -                        ; f7ec: 10 f7
                rts                          ; f7ee: 60
sub442          ldx #$0a                     ; f7ef: a2 0a
-               lda arr155,x                 ; f7f1: bd 30 04
                sta arr150,x                 ; f7f4: 9d 10 04
                dex                          ; f7f7: ca
                bpl -                        ; f7f8: 10 f7
                rts                          ; f7fa: 60
sub443          jsr sub438                   ; f7fb: 20 b4 f7
                ldx #3                       ; f7fe: a2 03
-               lda arr157,x                 ; f800: bd 40 04
                sta arr147,x                 ; f803: 9d 05 04
                dex                          ; f806: ca
                bpl -                        ; f807: 10 f7
                rts                          ; f809: 60
sub444          jsr sub443                   ; f80a: 20 fb f7
                lda #$65                     ; f80d: a9 65
                jsr sub437                   ; f80f: 20 9f f7
                lda #3                       ; f812: a9 03
                sta ram182                   ; f814: 8d 16 04
                jsr sub359                   ; f817: 20 a3 e7
                jsr sub439                   ; f81a: 20 c9 f7
                jsr sub443                   ; f81d: 20 fb f7
                lda #4                       ; f820: a9 04
                sta ram184                   ; f822: 8d 18 04
                jsr sub445                   ; f825: 20 b7 f8
                jsr sub439                   ; f828: 20 c9 f7
                jsr sub443                   ; f82b: 20 fb f7
                lda #4                       ; f82e: a9 04
                sta ram182                   ; f830: 8d 16 04
                jsr sub445                   ; f833: 20 b7 f8
                jsr sub441                   ; f836: 20 e2 f7
                ldx #3                       ; f839: a2 03
-               lda arr157,x                 ; f83b: bd 40 04
                sta arr151,x                 ; f83e: 9d 15 04
                dex                          ; f841: ca
                bpl -                        ; f842: 10 f7
                jsr sub376                   ; f844: 20 55 eb
                jsr sub376                   ; f847: 20 55 eb
                jsr sub357                   ; f84a: 20 4b e7
                jsr sub441                   ; f84d: 20 e2 f7
                lda ram194                   ; f850: ad 44 04
                and #%00001111               ; f853: 29 0f
                beq +                        ; f855: f0 02
                lda #$0a                     ; f857: a9 0a
+               clc                          ; f859: 18
                adc ram195                   ; f85a: 6d 45 04
                sta ram3                     ; f85d: 85 07
                dec ram3                     ; f85f: c6 07
                lda ram3                     ; f861: a5 07
                adc ram3                     ; f863: 65 07
                adc ram3                     ; f865: 65 07
                tax                          ; f867: aa
                lda $f60d,x                  ; f868: bd 0d f6
                sta ram182                   ; f86b: 8d 16 04
                lda cod703,x                 ; f86e: bd 0e f6
                sta ram183                   ; f871: 8d 17 04
                lda dat157,x                 ; f874: bd 0f f6
                sta ram184                   ; f877: 8d 18 04
                jsr sub355                   ; f87a: 20 e9 e6
                lda ram194                   ; f87d: ad 44 04
                and #%00001111               ; f880: 29 0f
                bne +                        ; f882: d0 21
                lda ram195                   ; f884: ad 45 04
                and #%00001111               ; f887: 29 0f
                cmp #3                       ; f889: c9 03
                bpl +                        ; f88b: 10 18
                lda #$40                     ; f88d: a9 40
                sta arr1                     ; f88f: 85 00
                lda #4                       ; f891: a9 04
                sta arr2                     ; f893: 85 01
                jsr sub447                   ; f895: 20 df f8
                beq +                        ; f898: f0 0b
                jsr sub441                   ; f89a: 20 e2 f7
                lda #1                       ; f89d: a9 01
                sta ram184                   ; f89f: 8d 18 04
                jsr sub357                   ; f8a2: 20 4b e7
+               jsr sub441                   ; f8a5: 20 e2 f7
                lda ram196                   ; f8a8: ad 47 04
                sta ram183                   ; f8ab: 8d 17 04
                lda ram197                   ; f8ae: ad 48 04
                sta ram184                   ; f8b1: 8d 18 04
                jmp sub355                   ; f8b4: 4c e9 e6
sub445          jsr sub360                   ; f8b7: 20 86 e8
                jsr sub446                   ; f8ba: 20 c6 f8
                jsr sub440                   ; f8bd: 20 d5 f7
                jsr sub442                   ; f8c0: 20 ef f7
                jmp sub355                   ; f8c3: 4c e9 e6
sub446          lda ram192                   ; f8c6: ad 39 04
                bne cod716                   ; f8c9: d0 01
                rts                          ; f8cb: 60
cod716          jsr sub378                   ; f8cc: 20 6b eb
                lda ram191                   ; f8cf: ad 38 04
                cmp #$2e                     ; f8d2: c9 2e
                bne cod716                   ; f8d4: d0 f6
                jsr sub378                   ; f8d6: 20 6b eb
                lda #0                       ; f8d9: a9 00
                sta ram192                   ; f8db: 8d 39 04
                rts                          ; f8de: 60
sub447          ldy #3                       ; f8df: a0 03
                lda (arr1),y                 ; f8e1: b1 00
                and #%00001111               ; f8e3: 29 0f
                bne +                        ; f8e5: d0 0b
                dey                          ; f8e7: 88
                lda (arr1),y                 ; f8e8: b1 00
                and #%00001111               ; f8ea: 29 0f
                bne +                        ; f8ec: d0 04
                ldy #0                       ; f8ee: a0 00
                beq cod717                   ; f8f0: f0 02
+               ldy #2                       ; f8f2: a0 02
cod717          lda (arr1),y                 ; f8f4: b1 00
                asl a                        ; f8f6: 0a
                asl a                        ; f8f7: 0a
                asl a                        ; f8f8: 0a
                asl a                        ; f8f9: 0a
                and #%00010000               ; f8fa: 29 10
                sta ram2                     ; f8fc: 85 04
                iny                          ; f8fe: c8
                lda (arr1),y                 ; f8ff: b1 00
                and #%00001111               ; f901: 29 0f
                ora ram2                     ; f903: 05 04
                beq +                        ; f905: f0 13
                cmp #4                       ; f907: c9 04
                beq +                        ; f909: f0 0f
                cmp #8                       ; f90b: c9 08
                beq +                        ; f90d: f0 0b
                cmp #$12                     ; f90f: c9 12
                beq +                        ; f911: f0 07
                cmp #$16                     ; f913: c9 16
                beq +                        ; f915: f0 03
                lda #0                       ; f917: a9 00
                rts                          ; f919: 60
+               lda #1                       ; f91a: a9 01
                rts                          ; f91c: 60
sub448          ldx #2                       ; f91d: a2 02
                ldy #0                       ; f91f: a0 00
                lda #0                       ; f921: a9 00
                sta arr94                    ; f923: 85 da
                sta ram126                   ; f925: 85 db
                sta arr95                    ; f927: 85 dc
-               lda arr96,x                  ; f929: b5 dd
                bne +                        ; f92b: d0 05
                lda #2                       ; f92d: a9 02
                sta arr94,x                  ; f92f: 95 da
                iny                          ; f931: c8
+               dex                          ; f932: ca
                bpl -                        ; f933: 10 f4
                tya                          ; f935: 98
                bne cod721                   ; f936: d0 2a
                ldx #0                       ; f938: a2 00
                ldy #2                       ; f93a: a0 02
-               lda arr96,x                  ; f93c: b5 dd
                and #%00001111               ; f93e: 29 0f
                sta arr1,x                   ; f940: 95 00
                inx                          ; f942: e8
                dey                          ; f943: 88
                bpl -                        ; f944: 10 f6
                jsr sub449                   ; f946: 20 63 f9
                ldx #2                       ; f949: a2 02
cod718          lda arr94,x                  ; f94b: b5 da
                beq cod720                   ; f94d: f0 10
                lda arr1,x                   ; f94f: b5 00
                beq cod720                   ; f951: f0 0c
                and #%00001000               ; f953: 29 08
                beq +                        ; f955: f0 04
                lda #3                       ; f957: a9 03
                bne cod719                   ; f959: d0 02
+               lda #1                       ; f95b: a9 01
cod719          sta arr94,x                  ; f95d: 95 da
cod720          dex                          ; f95f: ca
                bpl cod718                   ; f960: 10 e9
cod721          rts                          ; f962: 60
sub449          lda #0                       ; f963: a9 00
                sta ram7                     ; f965: 85 0e
                lda #7                       ; f967: a9 07
                sta arr9                     ; f969: 85 0f
cod722          ldx #2                       ; f96b: a2 02
cod723          lda arr9                     ; f96d: a5 0f
                bne cod724                   ; f96f: d0 01
                rts                          ; f971: 60
cod724          lda arr1,x                   ; f972: b5 00
                and #%00000111               ; f974: 29 07
                cmp arr9                     ; f976: c5 0f
                bne +                        ; f978: d0 0a
                lda arr1,x                   ; f97a: b5 00
                sta arr94,x                  ; f97c: 95 da
                sta ram7                     ; f97e: 85 0e
                dex                          ; f980: ca
                bpl cod724                   ; f981: 10 ef
                rts                          ; f983: 60
+               dex                          ; f984: ca
                bpl cod723                   ; f985: 10 e6
                dec arr9                     ; f987: c6 0f
                lda ram7                     ; f989: a5 0e
                beq cod722                   ; f98b: f0 de
                rts                          ; f98d: 60
                lda #0                       ; f98e: a9 00
                sta ram68                    ; f990: 85 81
                sta arr19                    ; f992: 85 2d
                lda #$18                     ; f994: a9 18
                sta ram69                    ; f996: 85 82
                lda ram99                    ; f998: a5 ae
                cmp #$ff                     ; f99a: c9 ff
                beq +                        ; f99c: f0 07
                cmp #$fe                     ; f99e: c9 fe
                beq cod725                   ; f9a0: f0 08
                jmp sub266                   ; f9a2: 4c 13 cf
+               lda #$20                     ; f9a5: a9 20
                jmp sub282                   ; f9a7: 4c 9c d2
cod725          lda #$1f                     ; f9aa: a9 1f
                jmp sub282                   ; f9ac: 4c 9c d2
dat159          lda #0                       ; f9af: a9 00
                sta arr96                    ; f9b1: 85 dd
                lda arr19                    ; f9b3: a5 2d
                bne cod726                   ; f9b5: d0 24
                lda #0                       ; f9b7: a9 00
                sta arr104                   ; f9b9: 85 fc
                ldx ram68                    ; f9bb: a6 81
                inc ram68                    ; f9bd: e6 81
                lda arr94,x                  ; f9bf: b5 da
                beq +                        ; f9c1: f0 13
                adc dat149,x                 ; f9c3: 7d 70 f5
                sta arr82                    ; f9c6: 85 c3
                lda #0                       ; f9c8: a9 00
                sta arr84                    ; f9ca: 85 c6
                lda #$35                     ; f9cc: a9 35
                sta arr19                    ; f9ce: 85 2d
                lda #3                       ; f9d0: a9 03
                sta arr104                   ; f9d2: 85 fc
                lda #6                       ; f9d4: a9 06
+               sta arr47                    ; f9d6: 85 60
                jmp sub303                   ; f9d8: 4c 09 d7
cod726          lda #3                       ; f9db: a9 03
                sta arr104                   ; f9dd: 85 fc
                jmp sub303                   ; f9df: 4c 09 d7
                jsr sub266                   ; f9e2: 20 13 cf
                sta arr1                     ; f9e5: 85 00
                ldy #0                       ; f9e7: a0 00
                ldx #2                       ; f9e9: a2 02
cod727          lda arr94,x                  ; f9eb: b5 da
                beq cod728                   ; f9ed: f0 06
                cmp #1                       ; f9ef: c9 01
                beq cod729                   ; f9f1: f0 11
                inc arr1                     ; f9f3: e6 00
cod728          dex                          ; f9f5: ca
                bpl cod727                   ; f9f6: 10 f3
                lda arr1                     ; f9f8: a5 00
                beq cod730                   ; f9fa: f0 0c
                cpy #0                       ; f9fc: c0 00
                beq +                        ; f9fe: f0 03
                jsr sub265                   ; fa00: 20 c2 ce
+               rts                          ; fa03: 60
cod729          iny                          ; fa04: c8
                jmp cod728                   ; fa05: 4c f5 f9
cod730          lda #$21                     ; fa08: a9 21
                jmp sub282                   ; fa0a: 4c 9c d2
                lda ram57                    ; fa0d: a5 6b
                sta ram73                    ; fa0f: 85 87
                jsr sub271                   ; fa11: 20 5d d0
                beq cod732                   ; fa14: f0 04
                jmp cod453                   ; fa16: 4c f7 d0
cod731          rts                          ; fa19: 60
cod732          jsr sub269                   ; fa1a: 20 c4 cf
                lda arr49                    ; fa1d: a5 64
                beq cod731                   ; fa1f: f0 f8
                jsr sub450                   ; fa21: 20 2e fa
                beq cod733                   ; fa24: f0 05
                lda #$1d                     ; fa26: a9 1d
                jmp sub282                   ; fa28: 4c 9c d2
cod733          jmp sub266                   ; fa2b: 4c 13 cf
sub450          jsr sub451                   ; fa2e: 20 d6 fa
                ldx ram29                    ; fa31: a6 2f
                lda #0                       ; fa33: a9 00
                sta arr1                     ; fa35: 85 00
                sta arr2                     ; fa37: 85 01
cod734          lda arr176,x                 ; fa39: bd 3d 06
                cmp #$30                     ; fa3c: c9 30
                bcc cod737                   ; fa3e: 90 1e
                cmp #$3a                     ; fa40: c9 3a
                bcs cod737                   ; fa42: b0 1a
                lda arr2                     ; fa44: a5 01
                bne +                        ; fa46: d0 08
                txa                          ; fa48: 8a
                ldy arr1                     ; fa49: a4 00
                sta arr3,y                   ; fa4b: 99 02 00
                inc arr1                     ; fa4e: e6 00
+               inc arr2                     ; fa50: e6 01
cod735          dex                          ; fa52: ca
                bpl cod734                   ; fa53: 10 e4
                lda arr1                     ; fa55: a5 00
                cmp #3                       ; fa57: c9 03
                beq cod738                   ; fa59: f0 12
cod736          lda #$ff                     ; fa5b: a9 ff
                rts                          ; fa5d: 60
cod737          lda arr2                     ; fa5e: a5 01
                beq +                        ; fa60: f0 04
                lda ram29                    ; fa62: a5 2f
                sta arr9                     ; fa64: 85 0f
+               lda #0                       ; fa66: a9 00
                sta arr2                     ; fa68: 85 01
                jmp cod735                   ; fa6a: 4c 52 fa
cod738          ldx ram2                     ; fa6d: a6 04
                ldy #4                       ; fa6f: a0 04
-               lda arr176,x                 ; fa71: bd 3d 06
                cmp #$30                     ; fa74: c9 30
                bcc +                        ; fa76: 90 10
                cmp #$3a                     ; fa78: c9 3a
                bcs +                        ; fa7a: b0 0c
                dey                          ; fa7c: 88
                bmi cod736                   ; fa7d: 30 dc
                sta arr89,y                  ; fa7f: 99 d0 00
                sta arr95,y                  ; fa82: 99 dc 00
                dex                          ; fa85: ca
                bpl -                        ; fa86: 10 e9
+               jsr sub455                   ; fa88: 20 3d fb
                bne cod736                   ; fa8b: d0 ce
                jsr sub452                   ; fa8d: 20 e9 fa
                ldx ram1                     ; fa90: a6 03
                ldy #2                       ; fa92: a0 02
-               lda arr176,x                 ; fa94: bd 3d 06
                cmp #$30                     ; fa97: c9 30
                bcc +                        ; fa99: 90 10
                cmp #$3a                     ; fa9b: c9 3a
                bcs +                        ; fa9d: b0 0c
                dey                          ; fa9f: 88
                bmi cod736                   ; faa0: 30 b9
                sta arr91,y                  ; faa2: 99 d4 00
                sta arr97,y                  ; faa5: 99 de 00
                dex                          ; faa8: ca
                bpl -                        ; faa9: 10 e9
+               jsr sub453                   ; faab: 20 f3 fa
                bne cod736                   ; faae: d0 ab
                jsr sub452                   ; fab0: 20 e9 fa
                ldx arr3                     ; fab3: a6 02
                ldy #2                       ; fab5: a0 02
-               lda arr176,x                 ; fab7: bd 3d 06
                cmp #$30                     ; faba: c9 30
                bcc +                        ; fabc: 90 10
                cmp #$3a                     ; fabe: c9 3a
                bcs +                        ; fac0: b0 0c
                dey                          ; fac2: 88
                bmi cod736                   ; fac3: 30 96
                sta arr93,y                  ; fac5: 99 d7 00
                sta arr97,y                  ; fac8: 99 de 00
                dex                          ; facb: ca
                bpl -                        ; facc: 10 e9
+               jsr sub454                   ; face: 20 07 fb
                bne cod736                   ; fad1: d0 88
                lda #0                       ; fad3: a9 00
                rts                          ; fad5: 60
sub451          ldx #$0f                     ; fad6: a2 0f
                lda #$30                     ; fad8: a9 30
-               sta arr89,x                  ; fada: 95 d0
                dex                          ; fadc: ca
                bpl -                        ; fadd: 10 fb
                lda #$0d                     ; fadf: a9 0d
                sta ram123                   ; fae1: 85 d6
                sta ram125                   ; fae3: 85 d9
                sta ram208                   ; fae5: 8d 34 05
                rts                          ; fae8: 60
sub452          ldx #3                       ; fae9: a2 03
                lda #$30                     ; faeb: a9 30
-               sta arr95,x                  ; faed: 95 dc
                dex                          ; faef: ca
                bpl -                        ; faf0: 10 fb
                rts                          ; faf2: 60
sub453          ldy #6                       ; faf3: a0 06
                jsr sub456                   ; faf5: 20 ce fb
                bne cod739                   ; faf8: d0 0c
                lda arr91                    ; fafa: a5 d4
                cmp #$30                     ; fafc: c9 30
                bne +                        ; fafe: d0 04
                lda #$20                     ; fb00: a9 20
                sta arr91                    ; fb02: 85 d4
+               lda #0                       ; fb04: a9 00
cod739          rts                          ; fb06: 60
sub454          lda arr91                    ; fb07: a5 d4
                and #%00001111               ; fb09: 29 0f
                beq +                        ; fb0b: f0 02
                lda #$0a                     ; fb0d: a9 0a
+               clc                          ; fb0f: 18
                adc arr92                    ; fb10: 65 d5
                and #%00001111               ; fb12: 29 0f
                tax                          ; fb14: aa
                lda $f5cf,x                  ; fb15: bd cf f5
                cmp #9                       ; fb18: c9 09
                bne +                        ; fb1a: d0 0e
                lda #$d0                     ; fb1c: a9 d0
                sta arr1                     ; fb1e: 85 00
                lda #0                       ; fb20: a9 00
                sta arr2                     ; fb22: 85 01
                jsr sub447                   ; fb24: 20 df f8
                clc                          ; fb27: 18
                adc #9                       ; fb28: 69 09
+               tay                          ; fb2a: a8
                jsr sub456                   ; fb2b: 20 ce fb
                bne cod740                   ; fb2e: d0 0c
                lda arr93                    ; fb30: a5 d7
                cmp #$30                     ; fb32: c9 30
                bne +                        ; fb34: d0 04
                lda #$20                     ; fb36: a9 20
                sta arr93                    ; fb38: 85 d7
+               lda #0                       ; fb3a: a9 00
cod740          rts                          ; fb3c: 60
sub455          ldy #0                       ; fb3d: a0 00
                cmp #$4d                     ; fb3f: c9 4d
                beq +                        ; fb41: f0 0e
                ldy #1                       ; fb43: a0 01
                cmp #$54                     ; fb45: c9 54
                beq +                        ; fb47: f0 08
                ldy #2                       ; fb49: a0 02
                cmp #$53                     ; fb4b: c9 53
                beq +                        ; fb4d: f0 02
                ldy #3                       ; fb4f: a0 03
+               jsr sub456                   ; fb51: 20 ce fb
                beq +                        ; fb54: f0 01
                rts                          ; fb56: 60
+               ldx ram7                     ; fb57: a6 0e
                cpx #$0c                     ; fb59: e0 0c
                beq cod741                   ; fb5b: f0 1b
                ldy #3                       ; fb5d: a0 03
                clc                          ; fb5f: 18
-               lda arr89,y                  ; fb60: b9 d0 00
                adc $f5c1,x                  ; fb63: 7d c1 f5
                cmp #$3a                     ; fb66: c9 3a
                bcc +                        ; fb68: 90 04
                sec                          ; fb6a: 38
                sbc #$0a                     ; fb6b: e9 0a
                sec                          ; fb6d: 38
+               sta arr89,y                  ; fb6e: 99 d0 00
                sta arr95,y                  ; fb71: 99 dc 00
                inx                          ; fb74: e8
                dey                          ; fb75: 88
                bpl -                        ; fb76: 10 e8
cod741          ldy #4                       ; fb78: a0 04
                jsr sub456                   ; fb7a: 20 ce fb
                bne +                        ; fb7d: d0 05
                ldx #0                       ; fb7f: a2 00
                jmp cod742                   ; fb81: 4c 92 fb
+               ldy #5                       ; fb84: a0 05
                jsr sub456                   ; fb86: 20 ce fb
                bne +                        ; fb89: d0 05
                ldx #1                       ; fb8b: a2 01
                jmp cod742                   ; fb8d: 4c 92 fb
+               ldx #2                       ; fb90: a2 02
cod742          txa                          ; fb92: 8a
                pha                          ; fb93: 48
                lda dat151,x                 ; fb94: bd 7e f5
                tax                          ; fb97: aa
                ldy #3                       ; fb98: a0 03
                sec                          ; fb9a: 38
-               lda arr89,y                  ; fb9b: b9 d0 00
                sbc $f5c1,x                  ; fb9e: fd c1 f5
                cmp #$30                     ; fba1: c9 30
                bcs +                        ; fba3: b0 04
                clc                          ; fba5: 18
                adc #$0a                     ; fba6: 69 0a
                clc                          ; fba8: 18
+               sta arr164,y                 ; fba9: 99 30 05
                inx                          ; fbac: e8
                dey                          ; fbad: 88
                bpl -                        ; fbae: 10 eb
                pla                          ; fbb0: 68
                tax                          ; fbb1: aa
                lda dat154,x                 ; fbb2: bd cd f5
                sta arr164                   ; fbb5: 8d 30 05
                ldx #0                       ; fbb8: a2 00
-               lda arr165,x                 ; fbba: bd 31 05
                cmp #$30                     ; fbbd: c9 30
                bne +                        ; fbbf: d0 0a
                lda #$20                     ; fbc1: a9 20
                sta arr165,x                 ; fbc3: 9d 31 05
                inx                          ; fbc6: e8
                cpx #2                       ; fbc7: e0 02
                bne -                        ; fbc9: d0 ef
+               lda #0                       ; fbcb: a9 00
                rts                          ; fbcd: 60
sub456          lda dat150,y                 ; fbce: b9 73 f5
                tax                          ; fbd1: aa
                lda dat151,y                 ; fbd2: b9 7e f5
                sta ram7                     ; fbd5: 85 0e
                ldy #0                       ; fbd7: a0 00
-               lda dat152,x                 ; fbd9: bd 89 f5
                cmp arr95,y                  ; fbdc: d9 dc 00
                beq +                        ; fbdf: f0 05
                bcc cod743                   ; fbe1: 90 09
                jmp cod745                   ; fbe3: 4c fa fb
+               inx                          ; fbe6: e8
                iny                          ; fbe7: c8
                cpy #4                       ; fbe8: c0 04
                bne -                        ; fbea: d0 ed
cod743          ldx ram7                     ; fbec: a6 0e
                ldy #0                       ; fbee: a0 00
cod744          lda dat153,x                 ; fbf0: bd 95 f5
                cmp arr95,y                  ; fbf3: d9 dc 00
                beq cod746                   ; fbf6: f0 05
                bcs cod747                   ; fbf8: b0 09
cod745          lda #$ff                     ; fbfa: a9 ff
                rts                          ; fbfc: 60
cod746          inx                          ; fbfd: e8
                iny                          ; fbfe: c8
                cpy #4                       ; fbff: c0 04
                bne cod744                   ; fc01: d0 ed
cod747          lda #0                       ; fc03: a9 00
                rts                          ; fc05: 60
sub457          lda #$ff                     ; fc06: a9 ff
                sta joypad2                  ; fc08: 8d 17 40
                jsr sub464                   ; fc0b: 20 98 fc
                ldy #3                       ; fc0e: a0 03
-               lda arr138,y                 ; fc10: b9 43 03
                sta arr139,y                 ; fc13: 99 46 03
                lda #0                       ; fc16: a9 00
                sta arr138,y                 ; fc18: 99 43 03
                dey                          ; fc1b: 88
                bne -                        ; fc1c: d0 f2
                lda ram173                   ; fc1e: ad 49 03
                beq +                        ; fc21: f0 0a
                lda #3                       ; fc23: a9 03
                sta snd_chn                  ; fc25: 8d 15 40
                lda #$0f                     ; fc28: a9 0f
                sta snd_chn                  ; fc2a: 8d 15 40
+               lda #0                       ; fc2d: a9 00
                sta arr105                   ; fc2f: 85 ff
                sta ram143                   ; fc31: 85 fe
                lda ram142                   ; fc33: a5 fd
                sta dmc_raw                  ; fc35: 8d 11 40
                beq +                        ; fc38: f0 02
                dec ram142                   ; fc3a: c6 fd
+               lda ram167                   ; fc3c: ad 40 03
                cmp #$20                     ; fc3f: c9 20
                bcs +                        ; fc41: b0 05
                ldx #0                       ; fc43: a2 00
                stx ram168                   ; fc45: 8e 41 03
+               cmp #$80                     ; fc48: c9 80
                bcc +                        ; fc4a: 90 03
                inc ram168                   ; fc4c: ee 41 03
+               tay                          ; fc4f: a8
                lsr a                        ; fc50: 4a
                lsr a                        ; fc51: 4a
                lsr a                        ; fc52: 4a
                lsr a                        ; fc53: 4a
                lsr a                        ; fc54: 4a
                sta arr1                     ; fc55: 85 00
                tya                          ; fc57: 98
                ldx ram168                   ; fc58: ae 41 03
                bne +                        ; fc5b: d0 05
                sec                          ; fc5d: 38
                adc arr1                     ; fc5e: 65 00
                bne cod748                   ; fc60: d0 03
+               clc                          ; fc62: 18
                sbc arr1                     ; fc63: e5 00
cod748          sta ram167                   ; fc65: 8d 40 03
                rts                          ; fc68: 60
sub458          ldy #$7f                     ; fc69: a0 7f
                bne cod749                   ; fc6b: d0 05
sub459          ldy #$7f                     ; fc6d: a0 7f
sub460          stx sq1_vol                  ; fc6f: 8e 00 40
cod749          sty sq1_sweep                ; fc72: 8c 01 40
sub461          ldx #0                       ; fc75: a2 00
cod750          tay                          ; fc77: a8
                lda dat1,y                   ; fc78: b9 06 80
                sta sq1_lo,x                 ; fc7b: 9d 02 40
                lda $8007,y                  ; fc7e: b9 07 80
                ora #%00001000               ; fc81: 09 08
                sta sq1_hi,x                 ; fc83: 9d 03 40
cod751          rts                          ; fc86: 60
sub462          ldy #$7f                     ; fc87: a0 7f
                sty sq2_sweep                ; fc89: 8c 05 40
                ldx #4                       ; fc8c: a2 04
                bne cod750                   ; fc8e: d0 e7
sub463          ldx #8                       ; fc90: a2 08
                cmp #2                       ; fc92: c9 02
                beq cod751                   ; fc94: f0 f0
                bne cod750                   ; fc96: d0 df
sub464          lda ram171                   ; fc98: ad 47 03
                beq +                        ; fc9b: f0 08
                jsr sub458                   ; fc9d: 20 69 fc
                lda #0                       ; fca0: a9 00
                sta ram174                   ; fca2: 8d 4a 03
+               lda ram174                   ; fca5: ad 4a 03
                cmp #$36                     ; fca8: c9 36
                bcs +                        ; fcaa: b0 0b
                lsr a                        ; fcac: 4a
                tay                          ; fcad: a8
                lda dat160,y                 ; fcae: b9 e6 fc
                sta sq1_vol                  ; fcb1: 8d 00 40
                inc ram174                   ; fcb4: ee 4a 03
+               lda ram172                   ; fcb7: ad 48 03
                beq +                        ; fcba: f0 08
                jsr sub462                   ; fcbc: 20 87 fc
                lda #0                       ; fcbf: a9 00
                sta ram175                   ; fcc1: 8d 4b 03
+               lda ram175                   ; fcc4: ad 4b 03
                cmp #$36                     ; fcc7: c9 36
                bcs +                        ; fcc9: b0 0b
                lsr a                        ; fccb: 4a
                tay                          ; fccc: a8
                lda dat160,y                 ; fccd: b9 e6 fc
                sta sq2_vol                  ; fcd0: 8d 04 40
                inc ram175                   ; fcd3: ee 4b 03
+               lda ram173                   ; fcd6: ad 49 03
                beq +                        ; fcd9: f0 08
                jsr sub463                   ; fcdb: 20 90 fc
                ldy #$38                     ; fcde: a0 38
                sty tri_linear               ; fce0: 8c 08 40
+               jmp cod757                   ; fce3: 4c 5b fd

dat160          hex 9f                       ; fce6

                sta dat14,x                  ; fce7: 9d 9c 9b
                txs                          ; fcea: 9a
                sta $9798,y                  ; fceb: 99 98 97
                stx arr69,y                  ; fcee: 96 95
                sta arr68,x                  ; fcf0: 95 94
                sty arr67,x                  ; fcf2: 94 93

                hex 93 93 92 92 92 92        ; fcf4

                sta (ram80),y                ; fcfa: 91 91
                sta (ram80),y                ; fcfc: 91 91
                sta (ram80),y                ; fcfe: 91 91
                bcc $fd4a                    ; fd00: 90 48
                jmp misc132                  ; fd02: 4c 4e 50

                hex 54                       ; fd05

                cli                          ; fd06: 58

                hex 5c                       ; fd07

                rts                          ; fd08: 60
dat161          sty_abs arr64                ; fd09: 8c 8c 00
                brk                          ; fd0c: 00
                brk                          ; fd0d: 00
                brk                          ; fd0e: 00

                hex 83 83                    ; fd0f

sub465          lda arr40                    ; fd11: a5 51
                and #%00000111               ; fd13: 29 07
                tay                          ; fd15: a8
                ldx $fd01,y                  ; fd16: be 01 fd
                lda dat161,y                 ; fd19: b9 09 fd
                tay                          ; fd1c: a8
                bne +                        ; fd1d: d0 08
                ldy #$8c                     ; fd1f: a0 8c
                lda arr40                    ; fd21: a5 51
                bpl +                        ; fd23: 10 02
                ldy #$83                     ; fd25: a0 83
+               txa                          ; fd27: 8a
                rts                          ; fd28: 60
cod752          sty ram134                   ; fd29: 84 f0
                lda #$5a                     ; fd2b: a9 5a
cod753          ldy #3                       ; fd2d: a0 03
                sty arr100                   ; fd2f: 84 f1
                ldx #$80                     ; fd31: a2 80
                jsr sub459                   ; fd33: 20 6d fc
                bne cod756                   ; fd36: d0 14
cod754          sty ram134                   ; fd38: 84 f0
                lda #$48                     ; fd3a: a9 48
                bne cod753                   ; fd3c: d0 ef
cod755          sty ram134                   ; fd3e: 84 f0
                jsr sub465                   ; fd40: 20 11 fd
                ldx #5                       ; fd43: a2 05
                stx arr100                   ; fd45: 86 f1
                ldx #$80                     ; fd47: a2 80
                jsr sub460                   ; fd49: 20 6f fc
cod756          dec arr100                   ; fd4c: c6 f1
                bne cod758                   ; fd4e: d0 34
                lda #0                       ; fd50: a9 00
                sta ram134                   ; fd52: 85 f0
                lda #$90                     ; fd54: a9 90
                sta sq1_vol                  ; fd56: 8d 00 40
                bne cod758                   ; fd59: d0 29
cod757          ldy arr105                   ; fd5b: a4 ff
                lda ram134                   ; fd5d: a5 f0
                lsr a                        ; fd5f: 4a
                lsr arr105                   ; fd60: 46 ff
                lsr a                        ; fd62: 4a
                bcs cod756                   ; fd63: b0 e7
                lsr arr105                   ; fd65: 46 ff
                bcs cod752                   ; fd67: b0 c0
                lsr a                        ; fd69: 4a
                bcs cod756                   ; fd6a: b0 e0
                lsr arr105                   ; fd6c: 46 ff
                bcs cod754                   ; fd6e: b0 c8
                lsr a                        ; fd70: 4a
                bcs cod756                   ; fd71: b0 d9
                lsr arr105                   ; fd73: 46 ff
                bcs cod755                   ; fd75: b0 c7
                lsr a                        ; fd77: 4a
                lsr arr105                   ; fd78: 46 ff
                lsr a                        ; fd7a: 4a
                lsr arr105                   ; fd7b: 46 ff
                lsr a                        ; fd7d: 4a
                bcs cod760                   ; fd7e: b0 17
                lsr arr105                   ; fd80: 46 ff
                bcs cod759                   ; fd82: b0 03
cod758          jmp cod770                   ; fd84: 4c 14 fe
cod759          sty ram134                   ; fd87: 84 f0
                lda #$3e                     ; fd89: a9 3e
                sta arr100                   ; fd8b: 85 f1
                lda #$18                     ; fd8d: a9 18
                jsr sub461                   ; fd8f: 20 75 fc
                lda #$86                     ; fd92: a9 86
                sta sq1_sweep                ; fd94: 8d 01 40
cod760          lda arr100                   ; fd97: a5 f1
                cmp #$38                     ; fd99: c9 38
                bne +                        ; fd9b: d0 05
                ldy #$bd                     ; fd9d: a0 bd
                sty sq1_sweep                ; fd9f: 8c 01 40
+               lsr a                        ; fda2: 4a
                bcs +                        ; fda3: b0 04
                lda #$90                     ; fda5: a9 90
                bne cod761                   ; fda7: d0 08
+               cmp #$0a                     ; fda9: c9 0a
                bcc +                        ; fdab: 90 02
                lda #$0a                     ; fdad: a9 0a
+               ora #%10010000               ; fdaf: 09 90
cod761          sta sq1_vol                  ; fdb1: 8d 00 40
                bne cod756                   ; fdb4: d0 96
cod762          lda ram142                   ; fdb6: a5 fd
                clc                          ; fdb8: 18
                adc #3                       ; fdb9: 69 03
                cmp #$60                     ; fdbb: c9 60
                bcs cod763                   ; fdbd: b0 02
                sta ram142                   ; fdbf: 85 fd
cod763          lda #8                       ; fdc1: a9 08
                sta tri_linear               ; fdc3: 8d 08 40
                lda ram136                   ; fdc6: a5 f3
                bne +                        ; fdc8: d0 07
                lda #$7e                     ; fdca: a9 7e
                sta tri_lo                   ; fdcc: 8d 0a 40
                bne cod764                   ; fdcf: d0 04
+               dec ram136                   ; fdd1: c6 f3
                bne cod765                   ; fdd3: d0 1b
cod764          ldx #$0a                     ; fdd5: a2 0a
                tya                          ; fdd7: 98
                and #%00001000               ; fdd8: 29 08
                beq +                        ; fdda: f0 02
                ldx #7                       ; fddc: a2 07
+               stx ram136                   ; fdde: 86 f3
                tya                          ; fde0: 98
                and #%01000000               ; fde1: 29 40
                bne cod768                   ; fde3: d0 26
                lda arr40                    ; fde5: a5 51
                tax                          ; fde7: aa
                and #%11110000               ; fde8: 29 f0
                bne cod766                   ; fdea: d0 17
                lda #1                       ; fdec: a9 01
                bne cod767                   ; fdee: d0 15
cod765          tya                          ; fdf0: 98
                and #%00001000               ; fdf1: 29 08
                bne cod769                   ; fdf3: d0 1c
                lda ram136                   ; fdf5: a5 f3
dat162          cmp #5                       ; fdf7: c9 05
                bne cod769                   ; fdf9: d0 16
                tya                          ; fdfb: 98
                and #%00100000               ; fdfc: 29 20
                bne cod768                   ; fdfe: d0 0b
                ldx ram167                   ; fe00: ae 40 03
cod766          lda #0                       ; fe03: a9 00
cod767          sta arr138                   ; fe05: 8d 43 03
                stx tri_lo                   ; fe08: 8e 0a 40
cod768          lda arr138                   ; fe0b: ad 43 03
                sta tri_hi                   ; fe0e: 8d 0b 40
cod769          jmp cod776                   ; fe11: 4c 93 fe
cod770          ldy arr104                   ; fe14: a4 fc
                lda ram141                   ; fe16: a5 fa
                bne +                        ; fe18: d0 0a
                tya                          ; fe1a: 98
                and #%00001000               ; fe1b: 29 08
                bne cod762                   ; fe1d: d0 97
                tya                          ; fe1f: 98
                and #%00010000               ; fe20: 29 10
                bne cod763                   ; fe22: d0 9d
+               tya                          ; fe24: 98
                and #%00000011               ; fe25: 29 03
                bne +                        ; fe27: d0 06
                sta arr103                   ; fe29: 85 fb
                sta ram136                   ; fe2b: 85 f3
                beq cod775                   ; fe2d: f0 4b
+               eor arr103                   ; fe2f: 45 fb
                beq cod773                   ; fe31: f0 1e
                lda arr104                   ; fe33: a5 fc
                sta arr103                   ; fe35: 85 fb
                asl a                        ; fe37: 0a
                asl a                        ; fe38: 0a
                tay                          ; fe39: a8
                bne cod772                   ; fe3a: d0 0d
cod771          lda arr40                    ; fe3c: a5 51
                and #%00000011               ; fe3e: 29 03
                sta arr101                   ; fe40: 85 f4
                lda arr104                   ; fe42: a5 fc
                asl a                        ; fe44: 0a
                asl a                        ; fe45: 0a
                ora arr101                   ; fe46: 05 f4
                tay                          ; fe48: a8
cod772          lda $fedc,y                  ; fe49: b9 dc fe
                sta arr101                   ; fe4c: 85 f4
                jmp cod774                   ; fe4e: 4c 55 fe
cod773          dec ram137                   ; fe51: c6 f6
                bne cod775                   ; fe53: d0 25
cod774          ldy arr101                   ; fe55: a4 f4
                inc arr101                   ; fe57: e6 f4
                lda $feec,y                  ; fe59: b9 ec fe
                beq cod771                   ; fe5c: f0 de
                tax                          ; fe5e: aa
                ror a                        ; fe5f: 6a
                txa                          ; fe60: 8a
                rol a                        ; fe61: 2a
                rol a                        ; fe62: 2a
                rol a                        ; fe63: 2a
                and #%00000111               ; fe64: 29 07
                tay                          ; fe66: a8
                lda dat167,y                 ; fe67: b9 f4 ff
                sta ram137                   ; fe6a: 85 f6
                txa                          ; fe6c: 8a
                and #%00111110               ; fe6d: 29 3e
                cmp #2                       ; fe6f: c9 02
                beq cod775                   ; fe71: f0 07
                jsr sub462                   ; fe73: 20 87 fc
                lda #0                       ; fe76: a9 00
                sta ram139                   ; fe78: 85 f8
cod775          ldy ram139                   ; fe7a: a4 f8
                cpy #8                       ; fe7c: c0 08
                bcs +                        ; fe7e: b0 08
                lda dat163,y                 ; fe80: b9 8b fe
                sta sq2_vol                  ; fe83: 8d 04 40
                inc ram139                   ; fe86: e6 f8
+               jmp cod776                   ; fe88: 4c 93 fe
dat163          sty arr67,x                  ; fe8b: 94 93

                hex 92 92                    ; fe8d

                sta (ram80),y                ; fe8f: 91 91
                sta (ram79),y                ; fe91: 91 90
cod776          lda ram141                   ; fe93: a5 fa
                bne cod777                   ; fe95: d0 17
                lda ram143                   ; fe97: a5 fe
                sta ram141                   ; fe99: 85 fa
                beq cod778                   ; fe9b: f0 42
                ldy #8                       ; fe9d: a0 08
-               asl a                        ; fe9f: 0a
                bcs +                        ; fea0: b0 03
                dey                          ; fea2: 88
                bne -                        ; fea3: d0 fa
+               lda $ff8a,y                  ; fea5: b9 8a ff
                sta arr102                   ; fea8: 85 f5
                lda #1                       ; feaa: a9 01
                sta ram138                   ; feac: 85 f7
cod777          dec ram138                   ; feae: c6 f7
                bne cod778                   ; feb0: d0 2d
                ldy arr102                   ; feb2: a4 f5
                inc arr102                   ; feb4: e6 f5
                lda cod781,y                 ; feb6: b9 8b ff
                bne +                        ; feb9: d0 07
                sta ram141                   ; febb: 85 fa
                sta tri_linear               ; febd: 8d 08 40
                beq cod778                   ; fec0: f0 1d
+               bpl +                        ; fec2: 10 09
                sta ram140                   ; fec4: 85 f9
                ldy arr102                   ; fec6: a4 f5
                inc arr102                   ; fec8: e6 f5
                lda cod781,y                 ; feca: b9 8b ff
+               jsr sub463                   ; fecd: 20 90 fc
                lda ram140                   ; fed0: a5 f9
                and #%01110000               ; fed2: 29 70
                lsr a                        ; fed4: 4a
                lsr a                        ; fed5: 4a
                sta tri_linear               ; fed6: 8d 08 40
                lda ram140                   ; fed9: a5 f9
                and #%00001111               ; fedb: 29 0f
                sta ram138                   ; fedd: 85 f7
cod778          rts                          ; fedf: 60
                brk                          ; fee0: 00
                brk                          ; fee1: 00
                asl misc48                   ; fee2: 0e 22 31
                and (arr32),y                ; fee5: 31 45
                ror ram70                    ; fee7: 66 84
                sty arr65                    ; fee9: 84 8d
                stx arr54,y                  ; feeb: 96 71
                jmp ($b0aa)                  ; feed: 6c aa b0
                cpx misc210                  ; fef0: ec e6 6a
                tax                          ; fef3: aa
                ror ram91                    ; fef4: 66 a2
                tax                          ; fef6: aa
                inc ram124                   ; fef7: e6 d8
                brk                          ; fef9: 00
                bvs $ff6c                    ; fefa: 70 70
                bvs cod780                   ; fefc: 70 6c
cod779          tax                          ; fefe: aa
dat164          bcs $fead                    ; feff: b0 ac
                tax                          ; ff01: aa
                inc arr51                    ; ff02: e6 6a
                ror a                        ; ff04: 6a
                ror a                        ; ff05: 6a
                ror ram91                    ; ff06: 66 a2
                tax                          ; ff08: aa

                hex 67                       ; ff09

                cli                          ; ff0a: 58

                hex 9c                       ; ff0b

                ldy #0                       ; ff0c: a0 00

                hex dc                       ; ff0e

                ldy #$5c                     ; ff0f: a0 5c
                rts                          ; ff11: 60

                hex e2                       ; ff12

                ldx arr48                    ; ff13: a6 62
sub466          ror ram132                   ; ff15: 66 ea
                ldy misc219                  ; ff17: ac 6a 6c
                beq cod779                   ; ff1a: f0 e2
                brk                          ; ff1c: 00
                bcs $fec9                    ; ff1d: b0 aa
                ldx #$66                     ; ff1f: a2 66
                ror a                        ; ff21: 6a
                ldy $a0a6                    ; ff22: ac a6 a0

                hex 62                       ; ff25

                ror arr74                    ; ff26: 66 aa
                ldx #$9c                     ; ff28: a2 9c
                rts                          ; ff2a: 60

                hex 62                       ; ff2b

                ldx arr72                    ; ff2c: a6 a0
                tya                          ; ff2e: 98
                ldx arr1                     ; ff2f: a6 00
                bvs cod783                   ; ff31: 70 6a
                bvs cod784                   ; ff33: 70 6a
                bvs cod785                   ; ff35: 70 6a
                bvs $ffa3                    ; ff37: 70 6a
                jmp (misc218)                ; ff39: 6c 66 6c
                ror ram58                    ; ff3c: 66 6c
                ror ram58                    ; ff3e: 66 6c
                ror arr51                    ; ff40: 66 6a

                hex 62                       ; ff42

                ror a                        ; ff43: 6a

                hex 62                       ; ff44

                ror a                        ; ff45: 6a

                hex 62                       ; ff46

                ror a                        ; ff47: 6a

                hex 62                       ; ff48

                ror arr46                    ; ff49: 66 58

                hex 5c                       ; ff4b

                rts                          ; ff4c: 60

                hex 62                       ; ff4d

                ror arr51                    ; ff4e: 66 6a
                jmp (misc233)                ; ff50: 6c 00 70
                jmp (misc246)                ; ff53: 6c 6a 70
                jmp (misc197)                ; ff56: 6c 6a 66
                jmp (misc197)                ; ff59: 6c 6a 66

                hex 62                       ; ff5c

                ror a                        ; ff5d: 6a
                ror arr46                    ; ff5e: 66 58

                hex 5c                       ; ff60

                rts                          ; ff61: 60
                bvs cod789                   ; ff62: 70 6c
                ror a                        ; ff64: 6a
                bvs $ffd3                    ; ff65: 70 6c
                ror a                        ; ff67: 6a
                ror ram58                    ; ff68: 66 6c
cod780          ror a                        ; ff6a: 6a
                ror arr48                    ; ff6b: 66 62
                ror a                        ; ff6d: 6a
                inc arr1                     ; ff6e: e6 00

                hex 3a 34                    ; ff70

                bit misc59                   ; ff72: 2c 34 3a

                hex 34                       ; ff75

                bit_abs arr22                ; ff76: 2c 34 00
                rol misc36,x                 ; ff79: 3e 36 2c
                rol arr27,x                  ; ff7c: 36 3e
                rol arr18,x                  ; ff7e: 36 2c
                rol arr1,x                   ; ff80: 36 00

                hex 3a                       ; ff82

                bmi $ffaf                    ; ff83: 30 2a
                bmi cod786                   ; ff85: 30 3a
                bmi $ffb3                    ; ff87: 30 2a
                bmi cod781                   ; ff89: 30 00
cod781          php                          ; ff8b: 08
dat165          ora (arr15),y                ; ff8c: 11 21

                hex 2b 2b                    ; ff8e

                and (ram47),y                ; ff90: 31 5c
cod782          rts                          ; ff92: 60

                hex b3                       ; ff93

                bmi cod788                   ; ff94: 30 38
                rol misc131,x                ; ff96: 3e 48 50
                lsr arr47,x                  ; ff99: 56 60
                brk                          ; ff9b: 00

                hex 92                       ; ff9c
cod783          hex 52                       ; ff9d

                rts                          ; ff9e: 60
cod784          bvc sub467                   ; ff9f: 50 5e
cod785          lsr misc111                  ; ffa1: 4e 5c 4c

                hex 5a                       ; ffa4

                lsr a                        ; ffa5: 4a
                cli                          ; ffa6: 58
                ldy arr34                    ; ffa7: a4 48
                rts                          ; ffa9: 60
                sei                          ; ffaa: 78
                brk                          ; ffab: 00
                ldy arr34                    ; ffac: a4 48
                lsr arr36,x                  ; ffae: 56 4c

                hex 5a 50                    ; ffb0

                lsr misc165,x                ; ffb2: 5e 52 60
                brk                          ; ffb5: 00
                ldx #$48                     ; ffb6: a2 48

                hex 50                       ; ffb8

                lsr arr47,x                  ; ffb9: 56 60
                brk                          ; ffbb: 00

                hex fa                       ; ffbc

                pha                          ; ffbd: 48
                cmp arr34                    ; ffbe: c5 48
                pha                          ; ffc0: 48

cod786          hex fa                       ; ffc1

                pha                          ; ffc2: 48
                sbc arr39,x                  ; ffc3: f5 50

                hex 50                       ; ffc5

                bvc cod787                   ; ffc6: 50 02

                hex fa                       ; ffc8

                pha                          ; ffc9: 48

cod787          hex fa                       ; ffca

                bvc cod782                   ; ffcb: 50 c5

                hex 50                       ; ffcd

cod788          bvc cod787                   ; ffce: 50 fa
cod789          bvc $ffc7                    ; ffd0: 50 f5
                lsr arr45,x                  ; ffd2: 56 56
                lsr arr3,x                   ; ffd4: 56 02

                hex fa                       ; ffd6

                bvc $ffd3                    ; ffd7: 50 fa
                lsr arr83,x                  ; ffd9: 56 c5
                lsr arr45,x                  ; ffdb: 56 56

                hex fa                       ; ffdd

dat166          lsr arr102,x                 ; ffde: 56 f5
                rts                          ; ffe0: 60
                rts                          ; ffe1: 60
                rts                          ; ffe2: 60
                rts                          ; ffe3: 60

                hex 02 02                    ; ffe4

                brk                          ; ffe6: 00
                ldy arr41                    ; ffe7: a4 52

                hex 5a                       ; ffe9

                brk                          ; ffea: 00

                hex 92                       ; ffeb

                pha                          ; ffec: 48
                jmp misc149                  ; ffed: 4c 50 54
                cli                          ; fff0: 58

                hex 5c                       ; fff1

                rts                          ; fff2: 60
                brk                          ; fff3: 00
dat167          php                          ; fff4: 08
                asl a                        ; fff5: 0a

                hex 14                       ; fff6

                plp                          ; fff7: 28

                hex 50                       ; fff8

                asl_absx arr98               ; fff9: 1e ed 00
                brk                          ; fffc: 00
                cpy ram134                   ; fffd: c4 f0
sub467          hex ff                       ; ffff

