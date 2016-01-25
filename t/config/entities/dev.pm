my $arcgis_home = '/opt/arcgis';
my $gis_hostname = 'gis.local';
my $gis_tomcat_directory = '/opt/project/gis-tomcat';
my $gis_tomcat_hostname = 'tomcat.gis.local';
my $gis_web_hostname = 'web.gis.local';

return {
    gis => {
        automation => {
            username => $Config::Entities::properties->{'dev.gis.automation.username'},
            password => $Config::Entities::properties->{'dev.gis.automation.password'},
        },
        deployment => {
            arcgis_version => '10.3.1',
            license => 'http://pastdev.com/arcgis/license/authorization.ecp',
            server => 'http://pastdev.com/ArcGIS_for_Server_Linux_1031_145870.tar.gz',
            web_adaptor => 'com.pastdev.arcgis:arcgis-web-adaptor:war:0.0.1-SNAPSHOT'
        },
        home => {
            arcgis_home => $arcgis_home
        },
        hostname => $gis_hostname,
        logs => {
            arcgis => "$arcgis_home/server/logs/serverlog",
            catalina => {
                file=>"$gis_tomcat_directory/logs/catalina.out", 
                hostname => $gis_tomcat_hostname, 
                sudo_username => 'gis-tomcat'
            }
        },
        sudo_username => 'arcgis',
        tomcat => {
            ajp => {
                port => 8509
            },
            http => {
                port => 8580
            },
            catalina_base => $gis_tomcat_directory,
            jmx_port => 8587,
            jpda_port => 8586,
            service => {
                command => "$gis_tomcat_directory/bin/catalina.sh",
                pid_file => "/var/run/gis-tomcat/catalina.pid",
            },
            shutdown => {
                port => 8505,
                password => $Config::Entities::properties->{'dev.gis.tomcat.shutdown.password'},
            },
            sudo_username => 'gis-tomcat',
            trust_store => {
                'Config::Entities::inherit' => ['hostname', 'username', 'sudo_username'],
                file => "$gis_tomcat_directory/certs/truststore.jks",
                imports => {
                    mitre_ba_root => 'http://pki.mitre.org/MITRE%20BA%20Root.crt',
                    mitre_ba_npe_ca1 => 'http://pki.mitre.org/MITRE%20BA%20NPE%20CA-1.crt'
                },
                include_java_home_cacerts => 1,
                password => $Config::Entities::properties->{'dev.gis.tomcat.trust_store.password'},
            }
        },
        web => {
            hostname => $gis_web_hostname,
            https => 1
        },
        web_direct => {
            'Config::Entities::inherit' => ['hostname'],
            https => 0
        }
    },
    piab => {
        catalina_home => "/opt/apache-tomcat/apache-tomcat",
        java_home => '/usr/lib/jvm/java',
        os => 'linux',
        tomcat_artifact => 'org.apache.tomcat:tomcat:zip:7.0.52'
    },
}
