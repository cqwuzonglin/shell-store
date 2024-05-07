#!/usr/bin/env node
// 下载直连列表到 direct-list.txt 然后运行
// https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/direct-list.txt
"use strict";
//配置读取和自动生成代理配置PAC

var file = require("./file.js");
var pac = require("./pac.js");

var OUTPUT_PATH = 'dist/'; //输出路径

/*
 * 生成一组PAC
 */
function generate(name) {
    if ('dist' === name) {
        return
    }
    var hosts = file.readLines(name + '/direct-list.txt');
    var nets = file.readLines(name + '/net.txt');
    var pacText = pac(hosts, nets);

    var f = name + '/pac.txt';

    //ss pac
    file.save(OUTPUT_PATH + f, pacText);

}

//处理当前文件夹下全部目录
file.listDir().forEach(generate);
