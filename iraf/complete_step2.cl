# Initialize the parameters
unlearn pselect
unlearn rename
unlearn delete
#
# PARAMETERS TO CHANGE
##############################################################################
# Change these parameters depending on the filter
#
# This is the filter itself
s1 = "b"
#
# Change the value of high_mag depending on what instr. mag range you're using
# high_mag is the brightest magnitude of the magnitude range; increment is the
# magnitude step (i.e., the bins are currently 0.2 mag wide)
# steps is the number of steps to take
#
# Do a search and replace on the galaxy name
#
real start,increment,high_mag
int steps,q
#
start = -4.1
increment = 0.2
steps = 40
##############################################################################
#
for (q = 0; q < 3; q+=1){

if(q == 0){
  s1 = "b"
}

if(q == 1){
  s1 = "v"
}

if(q == 2){
  s1 = "r"
}

for (i = 1; i <= steps; i+=1) {

high_mag = start + increment * i

# Run pselect on the phot output files
pselect ("n7332_"//(s1)//"_gcs_add."//(high_mag)//".mag.1", "temp1", "MAG != INDEF")
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   68. || XCE >  398.) || (YCE < 3583. || YCE > 3606.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  205. || XCE >  271.) || (YCE < 3554. || YCE > 3628.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1612. || XCE > 1689.) || (YCE < 3906. || YCE > 3928.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1558. || XCE > 1742.) || (YCE < 3990. || YCE > 4003.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  610. || XCE >  656.) || (YCE < 3963. || YCE > 4001.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  433. || XCE >  469.) || (YCE < 3395. || YCE > 3445.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2106. || XCE > 2415.) || (YCE < 3836. || YCE > 3854.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2163. || XCE > 2383.) || (YCE < 3749. || YCE > 3781.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1408. || XCE > 1456.) || (YCE < 3190. || YCE > 3202.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3638. || XCE > 3761.) || (YCE < 3490. || YCE > 3515.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3702. || XCE > 3831.) || (YCE < 3370. || YCE > 3401.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3722. || XCE > 3788.) || (YCE < 3292. || YCE > 3313.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3086. || XCE > 3363.) || (YCE < 3329. || YCE > 3349.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3152. || XCE > 3186.) || (YCE < 3320. || YCE > 3370.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3181. || XCE > 3213.) || (YCE < 3311. || YCE > 3374.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3202. || XCE > 3252.) || (YCE < 3306. || YCE > 3376.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3240. || XCE > 3293.) || (YCE < 3311. || YCE > 3363.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3106. || XCE > 3327.) || (YCE < 3254. || YCE > 3276.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3165. || XCE > 3202.) || (YCE < 3233. || YCE > 3297.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3186. || XCE > 3247.) || (YCE < 3233. || YCE > 3297.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3238. || XCE > 3277.) || (YCE < 3242. || YCE > 3290.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3779. || XCE > 3847.) || (YCE < 3585. || YCE > 3601.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3747. || XCE > 3824.) || (YCE < 3549. || YCE > 3554.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3697. || XCE > 3829.) || (YCE < 2823. || YCE > 2846.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3695. || XCE > 3767.) || (YCE < 2869. || YCE > 2894.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3140. || XCE > 3306.) || (YCE < 2625. || YCE > 2644.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3188. || XCE > 3279.) || (YCE < 2541. || YCE > 2566.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2818. || XCE > 2890.) || (YCE < 2530. || YCE > 2548.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2790. || XCE > 2913.) || (YCE < 2610. || YCE > 2623.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2593. || XCE > 2727.) || (YCE < 2673. || YCE > 2694.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2565. || XCE > 2740.) || (YCE < 2753. || YCE > 2766.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2461. || XCE > 3372.) || (YCE < 3021. || YCE > 3023.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2443. || XCE > 3354.) || (YCE < 2980. || YCE > 2984.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3108. || XCE > 3302.) || (YCE < 2844. || YCE > 2907.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3283. || XCE > 3363.) || (YCE < 2864. || YCE > 2900.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3081. || XCE > 3117.) || (YCE < 2871. || YCE > 2884.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3102. || XCE > 3174.) || (YCE < 2780. || YCE > 2853.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3156. || XCE > 3202.) || (YCE < 2760. || YCE > 2853.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3165. || XCE > 3263.) || (YCE < 2778. || YCE > 2850.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3240. || XCE > 3292.) || (YCE < 2807. || YCE > 2855.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3188. || XCE > 3267.) || (YCE < 2732. || YCE > 2800.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3136. || XCE > 3211.) || (YCE < 2735. || YCE > 2773.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3147. || XCE > 3177.) || (YCE < 2705. || YCE > 2741.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3124. || XCE > 3177.) || (YCE < 2678. || YCE > 2712.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3102. || XCE > 3158.) || (YCE < 2646. || YCE > 2682.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3092. || XCE > 3136.) || (YCE < 2605. || YCE > 2641.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3072. || XCE > 3122.) || (YCE < 2573. || YCE > 2610.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3067. || XCE > 3108.) || (YCE < 2546. || YCE > 2575.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3054. || XCE > 3092.) || (YCE < 2512. || YCE > 2555.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3038. || XCE > 3070.) || (YCE < 2487. || YCE > 2521.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3249. || XCE > 3327.) || (YCE < 2912. || YCE > 2975.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3311. || XCE > 3342.) || (YCE < 2932. || YCE > 2975.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3172. || XCE > 3233.) || (YCE < 2900. || YCE > 3048.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3215. || XCE > 3281.) || (YCE < 2912. || YCE > 2994.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3245. || XCE > 3283.) || (YCE < 2973. || YCE > 3048.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3256. || XCE > 3311.) || (YCE < 3030. || YCE > 3084.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3270. || XCE > 3324.) || (YCE < 3057. || YCE > 3125.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3308. || XCE > 3342.) || (YCE < 3098. || YCE > 3155.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3322. || XCE > 3365.) || (YCE < 3132. || YCE > 3189.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3338. || XCE > 3374.) || (YCE < 3184. || YCE > 3223.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3345. || XCE > 3402.) || (YCE < 3205. || YCE > 3264.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3386. || XCE > 3406.) || (YCE < 3248. || YCE > 3287.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2833. || XCE > 2899.) || (YCE < 2339. || YCE > 2407.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3838. || XCE > 3897.) || (YCE < 3146. || YCE > 3166.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1385. || XCE > 1470.) || (YCE < 3016. || YCE > 3071.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2226. || XCE > 2269.) || (YCE < 2975. || YCE > 3084.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2183. || XCE > 2235.) || (YCE < 2848. || YCE > 2871.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2194. || XCE > 2231.) || (YCE < 2778. || YCE > 2796.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2067. || XCE > 2478.) || (YCE < 2366. || YCE > 2396.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2233. || XCE > 2303.) || (YCE < 2332. || YCE > 2432.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1410. || XCE > 1454.) || (YCE < 3105. || YCE > 3123.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  606. || XCE >  852.) || (YCE < 2870. || YCE > 2891.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  661. || XCE >  863.) || (YCE < 2943. || YCE > 2970.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  633. || XCE >  690.) || (YCE < 2532. || YCE > 2625.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  686. || XCE >  724.) || (YCE < 2518. || YCE > 2641.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  720. || XCE >  767.) || (YCE < 2522. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  761. || XCE >  815.) || (YCE < 2520. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  797. || XCE >  861.) || (YCE < 2518. || YCE > 2659.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  813. || XCE > 1208.) || (YCE < 2504. || YCE > 2657.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1165. || XCE > 1333.) || (YCE < 2509. || YCE > 2659.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1258. || XCE > 1499.) || (YCE < 2536. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1570. || XCE > 1731.) || (YCE < 2220. || YCE > 2241.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1610. || XCE > 1685.) || (YCE < 2195. || YCE > 2275.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < -104. || XCE >  493.) || (YCE < 2584. || YCE > 2600.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -2. || XCE >  509.) || (YCE < 2630. || YCE > 2637.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  605. || XCE >  723.) || (YCE < 2789. || YCE > 2809.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -4. || XCE > 1334.) || (YCE < 2961. || YCE > 2971.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    0. || XCE > 1418.) || (YCE < 3007. || YCE > 3009.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  198. || XCE >  241.) || (YCE < 2261. || YCE > 2279.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  205. || XCE >  241.) || (YCE < 2347. || YCE > 2354.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -9. || XCE > 1518.) || (YCE < 1983. || YCE > 2108.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  191. || XCE >  230.) || (YCE < 2156. || YCE > 2174.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  366. || XCE >  394.) || (YCE < 2133. || YCE > 2145.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1637. || XCE > 1689.) || (YCE < 1884. || YCE > 1904.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1610. || XCE > 1671.) || (YCE < 1852. || YCE > 1866.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1392. || XCE > 4046.) || (YCE < 1981. || YCE > 2100.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2019. || XCE > 4046.) || (YCE < 2172. || YCE > 2209.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1764. || XCE > 4073.) || (YCE < 1927. || YCE > 1936.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 4073. || XCE > 4073.) || (YCE < 1927. || YCE > 1927.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2837. || XCE > 2991.) || (YCE < 1845. || YCE > 1981.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2728. || XCE > 3091.) || (YCE < 1909. || YCE > 1954.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3137. || XCE > 3314.) || (YCE < 1475. || YCE > 1493.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3193. || XCE > 3259.) || (YCE < 1455. || YCE > 1523.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2782. || XCE > 2919.) || (YCE < 1502. || YCE > 1518.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2812. || XCE > 2898.) || (YCE < 1477. || YCE > 1543.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2750. || XCE > 2950.) || (YCE < 1387. || YCE > 1407.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2950. || XCE > 2989.) || (YCE < 1366. || YCE > 1391.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2941. || XCE > 2982.) || (YCE < 1296. || YCE > 1309.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2782. || XCE > 2919.) || (YCE < 1305. || YCE > 1334.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3693. || XCE > 3771.) || (YCE < 1216. || YCE > 1268.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2567. || XCE > 2760.) || (YCE < 1352. || YCE > 1373.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2624. || XCE > 2692.) || (YCE < 1325. || YCE > 1405.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  491. || XCE > 2075.) || (YCE < 1336. || YCE > 1356.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1118. || XCE > 1320.) || (YCE < 1243. || YCE > 1288.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1282. || XCE > 1882.) || (YCE < 1256. || YCE > 1281.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  427. || XCE >  520.) || (YCE < 1438. || YCE > 1461.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  427. || XCE >  523.) || (YCE < 1516. || YCE > 1538.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  584. || XCE >  748.) || (YCE < 1245. || YCE > 1261.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  632. || XCE >  698.) || (YCE < 1223. || YCE > 1300.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  727. || XCE >  793.) || (YCE < 1139. || YCE > 1211.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  625. || XCE >  879.) || (YCE < 1159. || YCE > 1182.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  102. || XCE >  191.) || (YCE < 1225. || YCE > 1245.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  109. || XCE >  179.) || (YCE < 1300. || YCE > 1332.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  195. || XCE >  257.) || (YCE < 1763. || YCE > 1809.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  400. || XCE > 1129.) || (YCE < 1254. || YCE > 1282.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1077. || XCE > 1134.) || (YCE < 1241. || YCE > 1291.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE >  495.) || (YCE < 1336. || YCE > 1359.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   84. || XCE >  195.) || (YCE <  710. || YCE >  731.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  123. || XCE >  182.) || (YCE <  701. || YCE >  756.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  641. || XCE >  732.) || (YCE <  885. || YCE >  940.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  404. || XCE >  534.) || (YCE <  488. || YCE >  510.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  445. || XCE >  500.) || (YCE <  463. || YCE >  542.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -7. || XCE > 1109.) || (YCE <  676. || YCE >  701.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1061. || XCE > 1182.) || (YCE <  624. || YCE >  747.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1077. || XCE > 2202.) || (YCE <  665. || YCE >  701.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2742. || XCE > 2938.) || (YCE <  619. || YCE >  637.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2808. || XCE > 2881.) || (YCE <  592. || YCE >  671.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2946. || XCE > 3000.) || (YCE <  617. || YCE >  679.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3300. || XCE > 3387.) || (YCE <  197. || YCE >  209.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3280. || XCE > 3369.) || (YCE <  154. || YCE >  170.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3871. || XCE > 3891.) || (YCE <  181. || YCE >  211.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3853. || XCE > 3868.) || (YCE <  138. || YCE >  163.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -1. || XCE > 2599.) || (YCE <  379. || YCE >  406.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  -19. || XCE > 2617.) || (YCE <  425. || YCE >  443.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  772. || XCE > 2190.) || (YCE <  252. || YCE >  261.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   35. || XCE > 2971.) || (YCE <  306. || YCE >  315.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -1. || XCE >  572.) || (YCE <  134. || YCE >  161.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3019. || XCE > 3055.) || (YCE < 2454. || YCE > 2490.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  520. || XCE >  656.) || (YCE < 2554. || YCE > 2617.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 3355.) || (YCE < 2972. || YCE > 2990.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 3837.) || (YCE < 3544. || YCE > 3563.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  501. || XCE >  538.) || (YCE < 1145. || YCE > 1163.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2365. || XCE > 3446.) || (YCE < 2081. || YCE > 2127.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2883. || XCE > 2937.) || (YCE < 2081. || YCE > 2145.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  147. || XCE >  265.) || (YCE < 1954. || YCE > 1990.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  192. || XCE >  238.) || (YCE < 1936. || YCE > 2008.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 2946.) || (YCE <  263. || YCE >  272.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  520. || XCE >  620.) || (YCE < 1963. || YCE > 1972.)"
!\mv temp2 temp1
#
#
rename ("temp1", "n7332_"//(s1)//"_gcs_add."//(high_mag)//".mag.1a")
#
# Run pselect on the addstar output files
pselect ("n7332_"//(s1)//"_gcs_add."//(high_mag)//".art", "temp1", "MAG != INDEF")
pselect infi=temp1 outfi=temp2 expr="(XCE <   68. || XCE >  398.) || (YCE < 3583. || YCE > 3606.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  205. || XCE >  271.) || (YCE < 3554. || YCE > 3628.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1612. || XCE > 1689.) || (YCE < 3906. || YCE > 3928.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1558. || XCE > 1742.) || (YCE < 3990. || YCE > 4003.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  610. || XCE >  656.) || (YCE < 3963. || YCE > 4001.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  433. || XCE >  469.) || (YCE < 3395. || YCE > 3445.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2106. || XCE > 2415.) || (YCE < 3836. || YCE > 3854.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2163. || XCE > 2383.) || (YCE < 3749. || YCE > 3781.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1408. || XCE > 1456.) || (YCE < 3190. || YCE > 3202.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3638. || XCE > 3761.) || (YCE < 3490. || YCE > 3515.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3702. || XCE > 3831.) || (YCE < 3370. || YCE > 3401.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3722. || XCE > 3788.) || (YCE < 3292. || YCE > 3313.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3086. || XCE > 3363.) || (YCE < 3329. || YCE > 3349.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3152. || XCE > 3186.) || (YCE < 3320. || YCE > 3370.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3181. || XCE > 3213.) || (YCE < 3311. || YCE > 3374.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3202. || XCE > 3252.) || (YCE < 3306. || YCE > 3376.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3240. || XCE > 3293.) || (YCE < 3311. || YCE > 3363.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3106. || XCE > 3327.) || (YCE < 3254. || YCE > 3276.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3165. || XCE > 3202.) || (YCE < 3233. || YCE > 3297.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3186. || XCE > 3247.) || (YCE < 3233. || YCE > 3297.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3238. || XCE > 3277.) || (YCE < 3242. || YCE > 3290.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3779. || XCE > 3847.) || (YCE < 3585. || YCE > 3601.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3747. || XCE > 3824.) || (YCE < 3549. || YCE > 3554.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3697. || XCE > 3829.) || (YCE < 2823. || YCE > 2846.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3695. || XCE > 3767.) || (YCE < 2869. || YCE > 2894.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3140. || XCE > 3306.) || (YCE < 2625. || YCE > 2644.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3188. || XCE > 3279.) || (YCE < 2541. || YCE > 2566.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2818. || XCE > 2890.) || (YCE < 2530. || YCE > 2548.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2790. || XCE > 2913.) || (YCE < 2610. || YCE > 2623.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2593. || XCE > 2727.) || (YCE < 2673. || YCE > 2694.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2565. || XCE > 2740.) || (YCE < 2753. || YCE > 2766.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2461. || XCE > 3372.) || (YCE < 3021. || YCE > 3023.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2443. || XCE > 3354.) || (YCE < 2980. || YCE > 2984.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3108. || XCE > 3302.) || (YCE < 2844. || YCE > 2907.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3283. || XCE > 3363.) || (YCE < 2864. || YCE > 2900.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3081. || XCE > 3117.) || (YCE < 2871. || YCE > 2884.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3102. || XCE > 3174.) || (YCE < 2780. || YCE > 2853.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3156. || XCE > 3202.) || (YCE < 2760. || YCE > 2853.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3165. || XCE > 3263.) || (YCE < 2778. || YCE > 2850.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3240. || XCE > 3292.) || (YCE < 2807. || YCE > 2855.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3188. || XCE > 3267.) || (YCE < 2732. || YCE > 2800.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3136. || XCE > 3211.) || (YCE < 2735. || YCE > 2773.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3147. || XCE > 3177.) || (YCE < 2705. || YCE > 2741.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3124. || XCE > 3177.) || (YCE < 2678. || YCE > 2712.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3102. || XCE > 3158.) || (YCE < 2646. || YCE > 2682.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3092. || XCE > 3136.) || (YCE < 2605. || YCE > 2641.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3072. || XCE > 3122.) || (YCE < 2573. || YCE > 2610.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3067. || XCE > 3108.) || (YCE < 2546. || YCE > 2575.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3054. || XCE > 3092.) || (YCE < 2512. || YCE > 2555.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3038. || XCE > 3070.) || (YCE < 2487. || YCE > 2521.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3249. || XCE > 3327.) || (YCE < 2912. || YCE > 2975.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3311. || XCE > 3342.) || (YCE < 2932. || YCE > 2975.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3172. || XCE > 3233.) || (YCE < 2900. || YCE > 3048.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3215. || XCE > 3281.) || (YCE < 2912. || YCE > 2994.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3245. || XCE > 3283.) || (YCE < 2973. || YCE > 3048.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3256. || XCE > 3311.) || (YCE < 3030. || YCE > 3084.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3270. || XCE > 3324.) || (YCE < 3057. || YCE > 3125.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3308. || XCE > 3342.) || (YCE < 3098. || YCE > 3155.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3322. || XCE > 3365.) || (YCE < 3132. || YCE > 3189.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3338. || XCE > 3374.) || (YCE < 3184. || YCE > 3223.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3345. || XCE > 3402.) || (YCE < 3205. || YCE > 3264.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3386. || XCE > 3406.) || (YCE < 3248. || YCE > 3287.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2833. || XCE > 2899.) || (YCE < 2339. || YCE > 2407.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3838. || XCE > 3897.) || (YCE < 3146. || YCE > 3166.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1385. || XCE > 1470.) || (YCE < 3016. || YCE > 3071.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2226. || XCE > 2269.) || (YCE < 2975. || YCE > 3084.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2183. || XCE > 2235.) || (YCE < 2848. || YCE > 2871.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2194. || XCE > 2231.) || (YCE < 2778. || YCE > 2796.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2067. || XCE > 2478.) || (YCE < 2366. || YCE > 2396.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2233. || XCE > 2303.) || (YCE < 2332. || YCE > 2432.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1410. || XCE > 1454.) || (YCE < 3105. || YCE > 3123.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  606. || XCE >  852.) || (YCE < 2870. || YCE > 2891.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  661. || XCE >  863.) || (YCE < 2943. || YCE > 2970.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  633. || XCE >  690.) || (YCE < 2532. || YCE > 2625.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  686. || XCE >  724.) || (YCE < 2518. || YCE > 2641.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  720. || XCE >  767.) || (YCE < 2522. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  761. || XCE >  815.) || (YCE < 2520. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  797. || XCE >  861.) || (YCE < 2518. || YCE > 2659.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  813. || XCE > 1208.) || (YCE < 2504. || YCE > 2657.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1165. || XCE > 1333.) || (YCE < 2509. || YCE > 2659.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1258. || XCE > 1499.) || (YCE < 2536. || YCE > 2645.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1570. || XCE > 1731.) || (YCE < 2220. || YCE > 2241.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1610. || XCE > 1685.) || (YCE < 2195. || YCE > 2275.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < -104. || XCE >  493.) || (YCE < 2584. || YCE > 2600.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -2. || XCE >  509.) || (YCE < 2630. || YCE > 2637.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  605. || XCE >  723.) || (YCE < 2789. || YCE > 2809.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -4. || XCE > 1334.) || (YCE < 2961. || YCE > 2971.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    0. || XCE > 1418.) || (YCE < 3007. || YCE > 3009.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  198. || XCE >  241.) || (YCE < 2261. || YCE > 2279.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  205. || XCE >  241.) || (YCE < 2347. || YCE > 2354.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -9. || XCE > 1518.) || (YCE < 1983. || YCE > 2108.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  191. || XCE >  230.) || (YCE < 2156. || YCE > 2174.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  366. || XCE >  394.) || (YCE < 2133. || YCE > 2145.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1637. || XCE > 1689.) || (YCE < 1884. || YCE > 1904.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1610. || XCE > 1671.) || (YCE < 1852. || YCE > 1866.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1392. || XCE > 4046.) || (YCE < 1981. || YCE > 2100.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2019. || XCE > 4046.) || (YCE < 2172. || YCE > 2209.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1764. || XCE > 4073.) || (YCE < 1927. || YCE > 1936.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 4073. || XCE > 4073.) || (YCE < 1927. || YCE > 1927.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2837. || XCE > 2991.) || (YCE < 1845. || YCE > 1981.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2728. || XCE > 3091.) || (YCE < 1909. || YCE > 1954.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3137. || XCE > 3314.) || (YCE < 1475. || YCE > 1493.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3193. || XCE > 3259.) || (YCE < 1455. || YCE > 1523.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2782. || XCE > 2919.) || (YCE < 1502. || YCE > 1518.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2812. || XCE > 2898.) || (YCE < 1477. || YCE > 1543.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2750. || XCE > 2950.) || (YCE < 1387. || YCE > 1407.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2950. || XCE > 2989.) || (YCE < 1366. || YCE > 1391.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2941. || XCE > 2982.) || (YCE < 1296. || YCE > 1309.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2782. || XCE > 2919.) || (YCE < 1305. || YCE > 1334.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3693. || XCE > 3771.) || (YCE < 1216. || YCE > 1268.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2567. || XCE > 2760.) || (YCE < 1352. || YCE > 1373.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2624. || XCE > 2692.) || (YCE < 1325. || YCE > 1405.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  491. || XCE > 2075.) || (YCE < 1336. || YCE > 1356.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1118. || XCE > 1320.) || (YCE < 1243. || YCE > 1288.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1282. || XCE > 1882.) || (YCE < 1256. || YCE > 1281.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  427. || XCE >  520.) || (YCE < 1438. || YCE > 1461.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  427. || XCE >  523.) || (YCE < 1516. || YCE > 1538.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  584. || XCE >  748.) || (YCE < 1245. || YCE > 1261.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  632. || XCE >  698.) || (YCE < 1223. || YCE > 1300.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  727. || XCE >  793.) || (YCE < 1139. || YCE > 1211.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  625. || XCE >  879.) || (YCE < 1159. || YCE > 1182.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  102. || XCE >  191.) || (YCE < 1225. || YCE > 1245.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  109. || XCE >  179.) || (YCE < 1300. || YCE > 1332.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  195. || XCE >  257.) || (YCE < 1763. || YCE > 1809.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  400. || XCE > 1129.) || (YCE < 1254. || YCE > 1282.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1077. || XCE > 1134.) || (YCE < 1241. || YCE > 1291.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE >  495.) || (YCE < 1336. || YCE > 1359.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   84. || XCE >  195.) || (YCE <  710. || YCE >  731.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  123. || XCE >  182.) || (YCE <  701. || YCE >  756.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  641. || XCE >  732.) || (YCE <  885. || YCE >  940.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  404. || XCE >  534.) || (YCE <  488. || YCE >  510.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  445. || XCE >  500.) || (YCE <  463. || YCE >  542.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -7. || XCE > 1109.) || (YCE <  676. || YCE >  701.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1061. || XCE > 1182.) || (YCE <  624. || YCE >  747.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 1077. || XCE > 2202.) || (YCE <  665. || YCE >  701.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2742. || XCE > 2938.) || (YCE <  619. || YCE >  637.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2808. || XCE > 2881.) || (YCE <  592. || YCE >  671.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2946. || XCE > 3000.) || (YCE <  617. || YCE >  679.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3300. || XCE > 3387.) || (YCE <  197. || YCE >  209.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3280. || XCE > 3369.) || (YCE <  154. || YCE >  170.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3871. || XCE > 3891.) || (YCE <  181. || YCE >  211.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3853. || XCE > 3868.) || (YCE <  138. || YCE >  163.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -1. || XCE > 2599.) || (YCE <  379. || YCE >  406.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  -19. || XCE > 2617.) || (YCE <  425. || YCE >  443.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  772. || XCE > 2190.) || (YCE <  252. || YCE >  261.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   35. || XCE > 2971.) || (YCE <  306. || YCE >  315.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <   -1. || XCE >  572.) || (YCE <  134. || YCE >  161.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 3019. || XCE > 3055.) || (YCE < 2454. || YCE > 2490.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  520. || XCE >  656.) || (YCE < 2554. || YCE > 2617.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 3355.) || (YCE < 2972. || YCE > 2990.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 3837.) || (YCE < 3544. || YCE > 3563.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  501. || XCE >  538.) || (YCE < 1145. || YCE > 1163.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2365. || XCE > 3446.) || (YCE < 2081. || YCE > 2127.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE < 2883. || XCE > 2937.) || (YCE < 2081. || YCE > 2145.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  147. || XCE >  265.) || (YCE < 1954. || YCE > 1990.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  192. || XCE >  238.) || (YCE < 1936. || YCE > 2008.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <    2. || XCE > 2946.) || (YCE <  263. || YCE >  272.)"
!\mv temp2 temp1
#
pselect infi=temp1 outfi=temp2 expr="(XCE <  520. || XCE >  620.) || (YCE < 1963. || YCE > 1972.)"
!\mv temp2 temp1
#
rename ("temp1", "n7332_"//(s1)//"_gcs_add."//(high_mag)//".pselect")
}
}
# Reset delete verify parameter!
#
delete.verify=yes
