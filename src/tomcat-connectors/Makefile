# $Id: Makefile,v 1.1 2012/01/12 20:39:57 clem Exp $
#
# @Copyright@
# @Copyright@
#
# $Log: Makefile,v $
# Revision 1.1  2012/01/12 20:39:57  clem
# First version of the nbcr-opal roll.
# Now it uses the mod_jk by default.
# The roll has been already modified from the nbcr.
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
	
