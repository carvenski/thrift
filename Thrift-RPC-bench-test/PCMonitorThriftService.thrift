namespace java com.mmtrix.monitor.pc.thrift

struct PCMonitorSampleUnitThriftModel {
    1: required string dataTime;
    2: required i64 timestamp;
    3: required i32 pageId;
    4: required string countryId;
    5: required i32 provinceId;
    6: required i32 cityId;
    7: required i32 ispId;
    8: required string localDns;
    9: required string clientIp;
    10: required string serverIp;
    11: required i32 avgCpuUsageRate;
    12: required i32 currentRamUsageSize;
    13: required i32 maxRamUsageSize;
    14: required i32 firstScreen;
    15: required i32 startRender;
    16: required i32 totalTime;
    17: required i32 basePageDownloadTime;
    18: required i32 clientTime;
    19: required i32 connectTime;
    20: required i32 connectTotalTime;
    21: required i32 contentLoadTime;
    22: required i32 dnsParseTime;
    23: required i32 dnsTime;
    24: required i32 firstPackage;
    25: required i32 netlayerTime;
    26: required i32 redirectTime;
    27: required i32 requestsendTime;
    28: required i32 sslTime;
    29: required i32 basePageSize;
    30: required i32 basePageSpeed;
    31: required i32 downloadSpeed;
    32: required i32 firstScreenBytes;
    33: required i32 pageSize;
    34: required i32 ajaxNumber;
    35: required i32 connectNumberOfTimes;
    36: required i32 dnsParseNumber;
    37: required i32 domNumber;
    38: required i32 firstScreenObjs;
    39: required i32 pageObjs;
    40: required i32 osId;
    41: required i32 browserId;
    42: required i32 errorId;
    43: required i32 closeTime;
    44: required i32 serverIspId;
    45: required i32 iframeNumber;
    46: required i32 additionalDataTime;
    47: required i32 pageOpenTime;
    48: required i32 serverType;
    49: required i32 httpVia;
    50: required i32 noCompressElemNumber;
    51: required i32 noExpiresElemNumber;
    52: required i32 noEtagElemNumber;
    53: required i32 currentCpuUsageRate;
    54: required string remarks;
    55: required string httpCode;
    56: required i32 memorySize;
    57: required string har;
    58: required string imageUrl;
    59: required string pingInfo;
    60: required string tracertInfo;
    61: required string nslookupInfo;
    62: required string reserved3;
    63: required string serverCountryId;
    64: required i32 serverProvinceId;
    65: required i32 serverCityId;
    66: required string errorDesc;
    67: required string responseHeader;
    68: required i32 errorObjs;
}

struct PCMonitorSampleQueryRetThriftModel {
    1: required string dataTime;
    2: required i32 pageId;
    3: required string country;
    4: required string province;
    5: required string city;
    6: required string isp;
    7: required string localDns;
    8: required string clientIp;
    9: required string serverIp;
    10: required i32 avgCpuUsageRate;
    11: required i32 currentRamUsageSize;
    12: required i32 maxRamUsageSize;
    13: required i32 firstScreen;
    14: required i32 startRender;
    15: required i32 totalTime;
    16: required i32 basePageDownloadTime;
    17: required i32 clientTime;
    18: required i32 connectTime;
    19: required i32 connectTotalTime;
    20: required i32 contentLoadTime;
    21: required i32 dnsParseTime;
    22: required i32 dnsTime;
    23: required i32 firstPackage;
    24: required i32 netlayerTime;
    25: required i32 redirectTime;
    26: required i32 requestsendTime;
    27: required i32 sslTime;
    28: required i32 basePageSize;
    29: required i32 basePageSpeed;
    30: required i32 downloadSpeed;
    31: required i32 firstScreenBytes;
    32: required i32 pageSize;
    33: required i32 ajaxNumber;
    34: required i32 connectNumberOfTimes;
    35: required i32 dnsParseNumber;
    36: required i32 domNumber;
    37: required i32 firstScreenObjs;
    38: required i32 pageObjs;
    39: required string httpCode;
    40: required string errorDesc;
    41: required string responseHeader;
    42: required i32 errorObjs;
}

struct PCMonitorSampleRltThriftModel {
    1: required i32 ret;
    2: required string errMsg;
    3: list<PCMonitorSampleQueryRetThriftModel> rlt;
}

struct PCMonitorElementUnitThriftModel {
    1: required string dataTime;
    2: required i64 timestamp;
    3: required i32 elementOrder;
    4: required string elementUrl;
    5: required i32 cityId;
    6: required i32 ispId;
    7: required string clientIp;
    8: required string dnsIp;
    9: required string serverIp;
    10: required i32 serverCityId;
    11: required i32 serverIspId;
    12: required i32 totalTime;
    13: required i32 totalBytes;
    14: required string elementType;
    15: required i32 httpCode;
    16: required string httpServer;
    17: required i32 startTime;
    18: required i32 dnsTime;
    19: required i32 connectTime;
    20: required i32 requestTime;
    21: required i32 firstPackage;
    22: required i32 restPackage;
    23: required i32 sslTime;
    24: required i32 provinceId; 
    25: required i32 pageId;
    26: required string httpVia;
    27: required i32 socketId;
    28: required i32 sendBytes;
    29: required string countryId;
    30: required string serverCountryId;
    31: required i32 serverProvinceId; 
}

service PCMonitorSampleThriftService {
    
    bool putPCMonitorSample(1:i32 pid, 2:i64 timestamp, 3:PCMonitorSampleUnitThriftModel unit); 

    list<list<string>> queryPCMonitorSampleWithColumn(1:i32 pid, 2:i64 startTime, 3:i64 endTime, 4:list<string> columns);

    PCMonitorSampleUnitThriftModel getPCMonitorSample(1:i32 pid, 2:i64 timestamp, 3:string clientIp);
}

service PCMonitorElementThriftService {
    
    bool putPCMonitorElement(1:i32 pid, 2:i64 timestamp, 3:PCMonitorElementUnitThriftModel unit);

}

service PCMonitorDelThriftService {
    bool delRowData(1:list<string> rowkeys, 2:string business);
}