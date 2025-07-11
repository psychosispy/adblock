#!/bin/sh

# 下载规则
#curl -o i-AdGuard_cookie.txt https://filters.adtidy.org/extension/ublock/filters/18_optimized.txt
#curl -o i-AdGuard_Popups.txt https://filters.adtidy.org/extension/ublock/filters/19_optimized.txt
curl -o i-EasyList.txt https://filters.adtidy.org/extension/ublock/filters/101_optimized.txt
curl -o i-EasyList_Chinese.txt https://filters.adtidy.org/extension/ublock/filters/104_optimized.txt
curl -o i-AdGuard_AppBanners.txt https://filters.adtidy.org/extension/ublock/filters/20_optimized.txt
curl -o i-AdGuard_MobileAds.txt https://filters.adtidy.org/extension/ublock/filters/11_optimized.txt
curl -o i-cjx-annoyance.txt https://raw.githubusercontent.com/cjx82630/cjxlist/master/cjx-annoyance.txt
curl -o i-antiadblockfilters.txt https://easylist-downloads.adblockplus.org/antiadblockfilters.txt
curl -o i-CN.txt https://raw.githubusercontent.com/Crystal-RainSlide/AdditionalFiltersCN/master/CN.txt
curl -o i-Intl.txt https://raw.githubusercontent.com/Crystal-RainSlide/AdditionalFiltersCN/master/Intl.txt
curl -o i-addlist.txt https://raw.githubusercontent.com/psychosispy/adblock/refs/heads/main/i-addlist.txt
curl -o wlist.txt https://raw.githubusercontent.com/psychosispy/adblock/refs/heads/main/main/wlist.txt

# 合并规则并去除注释、重复项
cat i-*.txt > i-merged.txt
cat i-merged.txt | grep -v '^!' | grep -v '^！' | grep -v '^# ' | grep -v '^# ' | grep -v '^[\[]' | grep -v '^[【]' > i-tmp.txt
sort i-tmp.txt | uniq > i-raw.txt
grep -vFf wlist.txt i-raw.txt > i-final.txt

python rule.py i-final.txt

# 计算规则数
num=$(wc -l < i-final.txt)

# 添加标题和时间
{
  echo "[Adblock Plus 2.0]"
  echo "! Title: ABP Merge Rules"
  echo "! Description: 该规则合并自AdGuard，以及补充的一些规则"
  echo "! Homepage: https://github.com/psychosispy/adblock"
  echo "! Version: $(date +"%Y-%m-%d %H:%M:%S")"
  echo "! Total count: $num"
  cat i-final.txt
} > ads.txt

# 清理临时文件
rm i-*.txt i-merged.txt i-tmp.txt i-raw.txt i-final.txt wlist.txt

exit 0

