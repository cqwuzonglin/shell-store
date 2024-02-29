#!/usr/bin/env node

"use strict";
//配置读取和自动生成代理配置PAC

var file = require("./file.js");
var pac = require("./pac.js");

var OUTPUT_PATH = 'dist/'; //输出路径
var PROXY_TYPE = ["HTTP"]; //代理方式列表

/*
 * 生成一组PAC
 */
function generate(name) {
    if ('dist' === name) {
        return
    }
    var hosts = file.readLines(name + '/direct-list.txt');
    var nets = file.readLines(name + '/net.txt');
    pac(hosts, nets);

    var proxylist = file.readLines(name + '/proxy.txt');
    var f = name + '/pac.txt';

    //ss pac
    // file.save(OUTPUT_PATH + f, pac.setProxy());

    //each output
    proxylist.forEach(function(proxy) {
        //综合多代理切换
        f = file.proxyFile(proxy, name + '/') + '.pac.txt';
        var p = Array.prototype.concat(PROXY_TYPE, "DIRECT").join(" " + proxy + "; ");
        file.save(OUTPUT_PATH + f, pac.setProxy(p));

        //多代理
        // PROXY_TYPE.forEach(function(type) { //每种代理方式生成一个目录
        //     var p = type + " " + proxy;
        //     var f = file.proxyFile(p, name + '/') + '.pac.txt';
        //     file.save(OUTPUT_PATH + f, pac.setProxy(p));
        // });
    });
}

//处理当前文件夹下全部目录
file.listDir().forEach(generate);
