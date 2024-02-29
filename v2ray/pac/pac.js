"use strict";
//根据参数自动生成PAC配置
//http://findproxyforurl.com/pac-functions/
var fs = require('fs');
var assert = require('assert');

var TEMPLATE = fs.readFileSync('template.js').toString();
var ValidHostRegex = /^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9])$/;
var ValidIPv4Regex = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/;
var ValidIPv6Regex = /(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))/;

/*
check host
*/
function isDomainIP(host) {
    return ValidHostRegex.test(host) ||
        ValidIPv4Regex.test(host) ||
        ValidIPv6Regex.test(host);
}

/*
Generate white list host
return string
*/
function whiteHost(hosts) {
    var host_obj = {};
    var host;
    for (var i in hosts) {
        host = hosts[i];
        assert(isDomainIP(host), host + '-- hostmust be a ip or domain');
        host_obj[host] = true;
    }
    return JSON.stringify(host_obj, null, 4);
}

/*
Generate regx host expression
return string
*/
function regxHost(hosts, host_var) {
    host_var = host_var || 'host';
    //unique
    hosts = hosts.filter(function(v, i, arr) {
        return arr.indexOf(v) === i;
    });
    //add tail
    hosts = hosts.map(function(s) {
        return s + '.test(' + host_var + ')';
    });
    return hosts.join('\n        || ') || 'false';
}

function inNet(list, host_var) {
    host_var = host_var || 'host';
    var netlist = [];
    var ip, mask, line;
    for (var i in list) {
        line = list[i].split(',');
        assert(2 === line.length, list[i] + '- must be a pair: [ip,mask]');
        ip = line[0].trim();
        assert(ValidIPv4Regex.test(ip), ip + 'must be a valid ip');
        mask = line[1].trim();
        assert(ValidIPv4Regex.test(mask), mask + 'must be a valid ip mask');
        line = 'isInNet(host, "' + ip + '", "' + mask + '")';
        if (netlist.indexOf(line) < 0) {
            netlist.push(line);
        }
    }
    return netlist.join('\n        || ') || 'true';
}

/*
pac generator
 */
var pac = function(host_list, net_list, proxy) {
    var domain_host = [];
    var full_host = [];
    var reg_host = [];
    const regExp = 'regexp:';
    const fullExp = 'full:';
    for (var i in host_list) {
        var host = host_list[i].trim();
        if (host.startsWith(regExp)) {
            var hostReg = host.substring(regExp.length)
            reg_host.push(hostReg);
        } else if (host.startsWith('full:')) {
            var fullHost = host.substring(fullExp.length)
            full_host.push(fullHost);
        } else {
            domain_host.push(host)
        }
    }

    return pac._script = TEMPLATE
        .replace('__FULL_LIST__', whiteHost(full_host))
        .replace('__REG_LIST__', JSON.stringify(reg_host, null, 4))
        .replace('__DOMAIN_LIST__', JSON.stringify(domain_host, null, 4))
        .replace('__IS_NET__', inNet(net_list));
};

exports = module.exports = pac;
