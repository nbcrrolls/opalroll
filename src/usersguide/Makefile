# @Copyright@
# 
# 				Rocks(r)
# 		         www.rocksclusters.org
# 		            version 5.0 (V)
# 
# Copyright (c) 2000 - 2008 The Regents of the University of California.
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

PKGROOT		= /var/www/html/roll-documentation/opal/$(VERSION)
REDHAT.ROOT	= $(PWD)/../../
#ROCKSROOT	= ../../../../..
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk
include rocks-version.mk

machine_type = $(shell uname -i)

SEDSPEC += \
	-e 's%@PUBDATE@%$(PUBDATE)%g' \
	-e 's%@YEAR@%$(YEAR)%g' \
	-e 's%@OPAL_VERSION@%$(OPAL_VERSION)%g' \
        -e 's%@MACHINE_TYPE@%$(machine_type)%g' \
        -e 's%@SOFTWARE_NAME@%$(SOFTWARE_NAME)%g' \
        -e 's%@ROCKS_VERSION@%$(ROCKS_VERSION)%g'

default: $(NAME).spec ../$(NAME)-$(VERSION).tar.gz

html: predoc preface.sgml index.sgml installing.sgml requirements.sgml using.sgml ec2.sgml
	jw --backend html --dsl $(PWD)/rocks.dsl#html index.sgml

pdf: predoc preface.sgml index.sgml installing.sgml requirements.sgml using.sgml ec2.sgml
	jw --backend pdf --dsl $(PWD)/rocks.dsl#print index.sgml

preface.sgml: preface.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

index.sgml: index.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

ec2.sgml: ec2.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

installing.sgml: installing.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

requirements.sgml: requirements.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

using.sgml: using.sgml.in
	$(SED) $(SEDSPEC) $^ > $@

build: html pdf

install:: build
	mkdir -p $(ROOT)/$(PKGROOT)/images
	mkdir -p $(ROOT)/$(PKGROOT)/stylesheet-images
	install -ma+r index.pdf 	$(ROOT)/$(PKGROOT)/$(NAME).pdf
	install -ma+r *.html    	$(ROOT)/$(PKGROOT)/
	install -ma+r images/*.png	$(ROOT)/$(PKGROOT)/images/
	install -ma+r stylesheet-images/{*.gif,*.png} \
		$(ROOT)/$(PKGROOT)/stylesheet-images/
	install -ma+r rocks.css $(ROOT)/$(PKGROOT)/

clean::
	rm -f *.html
	rm -f index.pdf
	rm -f index.sgml using.sgml installing.sgml requirements.sgml preface.sgml roll-opal-usersguide.spec.in ec2.sgml

