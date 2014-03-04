CO=git clone 
VERSION=1.0
MAVEN_SETTINGS=$(CURDIR)/settings.xml
NB_THREAD_MAVEN= -T 1
# http://maven.apache.org/guides/mini/guide-repository-ssl.html
# echo |openssl s_client -connect maven.openflexo.org:443 2>&1 |sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' | sudo keytool -import -trustcacerts -alias "openflexo" -keystore  /etc/java/security/cacerts -storepass changeit -noprompt
# http://jira.codehaus.org/browse/HAUS-2329
# http://maven.apache.org/guides/mini/guide-repository-ssl.html
# http://jira.codehaus.org/browse/MNG-3230
#http://ahoehma.wordpress.com/2009/11/17/maven-https-repository-with-self-signed-ssl-certificate/
# qualite
# http://arodrigues.developpez.com/tutoriels/java/maven2/qualite/#LIII-F

# mvn release
# http://blog.sonatype.com/2009/09/maven-tips-and-tricks-using-github/#.Uw-laZiKy0w

CERTIFICAT= -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true 
#CERTIFICAT=
#MVN=export HOME=$(FAKE_HOME);mvn $(CERTIFICAT) -s $(MAVEN_SETTINGS) 
MVN=mvn $(CERTIFICAT) -s $(MAVEN_SETTINGS) 
FAKE_HOME=$(CURDIR)/HOME
export MAVEN_OPTS=-Djavax.net.ssl.trustStore=/etc/java/security/cacerts -Djavax.net.ssl.trustStorePassword=changeit

demo : force
	$(MVN)  package site && $(MVN) site:stage && firefox file://$(CURDIR)/target/staging/index.html;  

force:

