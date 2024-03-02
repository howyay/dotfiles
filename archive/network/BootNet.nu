# BootNet.nu

let dnsRejectHandle = (sudo nft -a list chain inet mullvad output | rg "udp dport 53 reject" | awk -v ORS= '{print $NF}')
let bootstrapDns = "45.90.28.75"

if (nft -a list chain inet mullvad output | rg $bootstrapDns | is-empty) {
  nft insert rule inet mullvad output position $dnsRejectHandle oif "wg-mullvad" tcp dport 53 ip daddr $bootstrapDns accept
  nft insert rule inet mullvad output position $dnsRejectHandle oif "wg-mullvad" udp dport 53 ip daddr $bootstrapDns accept
}

if ((sudo nft -a list table inet excludeTraffic) > /dev/null == false) {
  nft -f /home/haoye/Documents/dotfiles/network/mullvadSubnet.rules
}

#screen -dmS dnsproxy dnsproxy -v -u tls://LAPTOP-9932e3.dns.nextdns.io -l 127.0.0.1 -b $bootstrapDns
dnsproxy -v -u tls://LAPTOP-9932e3.dns.nextdns.io -l 127.0.0.1 -b $bootstrapDns

#netconfig -f update

