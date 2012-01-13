# $Id: Makefile,v 1.2 2012/01/13 03:47:45 clem Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.2  2012/01/13 03:47:45  clem
# First round of fixes
#
#

REDHAT.ROOT	= $(PWD)/../../
-include $(ROCKSROOT)/etc/Rules.mk
include Rules.mk


install::
	mkdir -p $(ROOT)/etc/httpd/modules
	(								\
		cd $(NAME)-$(VERSION)-src;				\
		install -m755 native/apache-2.0/*.so			\
			$(ROOT)/etc/httpd/modules/;			\
	)

build: 
	gunzip -c $(NAME)-$(VERSION)-src.tar.gz | tar -x
	(								\
		cd $(NAME)-$(VERSION)-src;					\
		cd native;						\
		./configure --with-apxs=/usr/sbin/apxs;			\
		make;							\
	)

clean::
	rm -rf $(NAME)-$(VERSION)-src
	
