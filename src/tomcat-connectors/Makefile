# $Id: Makefile,v 1.3 2012/01/17 03:38:47 clem Exp $
#
# @Copyright@
# @Copyright@
#
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
	
