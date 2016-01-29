#!/usr/bin/python


import sys
import requests
import re




if len(sys.argv) < 4:
    print "ERROR: TOOLCHAIN_ID, BEARER, or PROJECT_NAME are not defined."
    exit(1)
    
    
TOOLCHAIN_ID = sys.argv[1]
BEARER = sys.argv[2]
PROJECT_NAME = sys.argv[3]
DRA_SERVICE_NAME = 'draservicebroker'
DRA_PRESENT = False



try:
    r = requests.get( 'https://devops-api.stage1.ng.bluemix.net/v1/toolchains/' + TOOLCHAIN_ID + '?include=metadata', headers={ 'Authorization': BEARER })
    
    data = r.json()
    #print data
    if r.status_code == 200:
        
        for items in data[ 'items' ]:
            #print items[ 'name' ]
            if items[ 'name' ] == PROJECT_NAME:
                #print items[ 'name' ]
                for services in items[ 'services' ]:
                    #print services[ 'service_id' ]
                    if services[ 'service_id' ] == DRA_SERVICE_NAME:
                        DRA_PRESENT = True
                        #Test case
                        #services[ 'dashboard_url' ]='https://da.oneibmcloud.com/dalskdjl/ljalkdj/'
                        print services[ 'dashboard_url' ]
                        urlRegex = re.compile(r'http\w*://\S+?/');
                        mo = urlRegex.search(services[ 'dashboard_url' ])
                        print mo.group()
                        os.environ["DRA_SERVER"]=mo.group()
    else:
        #ERROR response from toolchain API
        print 'ERROR:', r.status_code, '-', data
        #print 'DRA was disabled for this session.'
except requests.exceptions.RequestException as e:
    print 'ERROR: ', e
    #print 'DRA was disabled for this session.'
    
    
    

                
if DRA_PRESENT:
    exit(0)
else:
    exit(1)