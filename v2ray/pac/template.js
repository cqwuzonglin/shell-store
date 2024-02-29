"use strict";
/*
* Generated from https://github.com/NewFuture/pac
* see all pac files https://pac.newfuture.cc
*/
var RegListHost = __REG_LIST__ || [];
var DomainListHost = __DOMAIN_LIST__ || [];
var FullListHost = __FULL_LIST__ || {};
var RegExpList = [];
function DomainLike(host) {
    for (let i = 0; i < DomainListHost.length; i++) {
        if (DomainListHost[i].indexOf(host) > -1){
            return true;
        }
    }
    return false;
}
function RegExpTest(host) {
    if (RegExpList.length === 0) {
        for (let i = 0; i < RegListHost.length; i++) {
            RegExpList[i] = new RegExp(RegListHost[i]);
        }
    }
    for (let i = 0; i < RegExpList.length; i++) {
        if (RegExpList[i].test(host)) {
            return true
        }
    }
    return false;
}
function FindProxyForURL(url, host) {
    if (host.indexOf(".") < 0
        || FullListHost[host]
        || DomainLike(host)
        || DomainLike(host)
    ) {/*Plain Host Name or in whitelist*/
        return "DIRECT";
    } else if (/^(\d{1,3}\.){3}\d{1,3}$/.test(host)
    &&(__IS_NET__)
    ) {/*Intranet IP*/
        return "DIRECT";
    }
    return "SOCKS5 127.0.0.1:1080;";
};
