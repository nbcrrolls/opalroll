# $Id: Makefile,v 1.3 2012/01/17 03:38:47 clem Exp $
#
# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		       version 5.2 (Chimichanga)
# 
# Copyright (c) 2000 - 2009 The Regents of the University of California.
# All rights reserved.	
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
# notice unmodified and in its entirety, this list of conditions and the
# following disclaimer in the documentation and/or other materials provided 
# with the distribution.
# 
# 3. All advertising and press materials, printed or electronic, mentioning
# features or use of this software must display the following acknowledgement: 
# 
# 	"This product includes software developed by the Rocks(r)
# 	Cluster Group at the San Diego Supercomputer Center at the
# 	University of California, San Diego and its contributors."
# 
# 4. Except as permitted for the purposes of acknowledgment in paragraph 3,
# neither the name or logo of this software nor the names of its
# authors may be used to endorse or promote products derived from this
# software without specific prior written permission.  The name of the
# software includes the following terms, and any derivatives thereof:
# "Rocks", "Rocks Clusters", and "Avalanche Installer".  For licensing of 
# the associated name, interested parties should contact Technology 
# Transfer & Intellectual Property Services, University of California, 
# San Diego, 9500 Gilman Drive, Mail Code 0910, La Jolla, CA 92093-0910, 
# Ph: (858) 534-5815, FAX: (858) 534-7345, E-MAIL:invent@ucsd.edu
# 
# THIS SOFTWARE IS PROVIDED BY THE REGENTS AND CONTRIBUTORS ``AS IS''
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
# 
# @Copyright@
#
#

PKGROOT = /opt/tomcat

REDHAT.ROOT = $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk


install:: install_5_5 
	mkdir -p $(ROOT)/etc/rc.d/init.d
	mkdir -p $(ROOT)/etc/sysconfig/tomcat
	install -m755 tomcat-opal $(ROOT)/etc/rc.d/init.d/tomcat-opal


build: build_5_5 

install_6_0:
	mkdir -p $(ROOT)/$(PKGROOT)-$(VERSION_6_0)/logs
	(								\
		cd $(NAME_6_0)-$(VERSION_6_0);				\
		find . -type f |					\
			cpio -pduv $(ROOT)/$(PKGROOT)-$(VERSION_6_0);	\
	)
	chmod a+rx $(ROOT)/$(PKGROOT)-$(VERSION_6_0)/logs
	chown -R 412.412 $(ROOT)/$(PKGROOT)-$(VERSION_6_0)
	chmod -R g+r $(ROOT)/$(PKGROOT)-$(VERSION_6_0)
	find $(ROOT)/$(PKGROOT)-$(VERSION_6_0) -type d -exec chmod g+rwx {} \;

install_5_5:
	mkdir -p $(ROOT)/$(PKGROOT)-$(VERSION_5_5)/logs
	(								\
		cd $(NAME_5_5)-$(VERSION_5_5);				\
		find . -type f |					\
			cpio -pduv $(ROOT)/$(PKGROOT)-$(VERSION_5_5);	\
	)
	chmod a+rx $(ROOT)/$(PKGROOT)-$(VERSION_5_5)/logs
	chown -R 412.412 $(ROOT)/$(PKGROOT)-$(VERSION_5_5)
	chmod -R g+r $(ROOT)/$(PKGROOT)-$(VERSION_5_5)
	find $(ROOT)/$(PKGROOT)-$(VERSION_5_5) -type d -exec chmod g+rwx {} \;
	ln -s $(PKGROOT)-$(VERSION_5_5) $(ROOT)/$(PKGROOT)


build_6_0:
	(								\
		tar -xzf $(NAME_6_0)-$(VERSION_6_0).tar.gz;		\
		cd $(NAME_6_0)-$(VERSION_6_0)/bin;			\
		tar -xzf jsvc.tar.gz;					\
	)
	(								\
		cd $(NAME_6_0)-$(VERSION_6_0)/bin/jsvc-src;		\
		autoconf -f;						\
		sh ./configure --with-java=$(JAVA_HOME);		\
		make;							\
		cp jsvc ..;						\
	)

build_5_5:
	(								\
		tar -xzf $(NAME_5_5)-$(VERSION_5_5).tar.gz;		\
		cd $(NAME_5_5)-$(VERSION_5_5)/bin;			\
		tar -xzf jsvc.tar.gz;					\
	)
	(								\
		cd $(NAME_5_5)-$(VERSION_5_5)/bin/jsvc-src;		\
		autoconf -f;						\
		sh ./configure --with-java=$(JAVA_HOME);		\
		make;							\
		cp jsvc ..;						\
	)



clean::
	rm -rf $(NAME_6_0)-$(VERSION_6_0)
	rm -rf $(NAME_5_5)-$(VERSION_5_5)
