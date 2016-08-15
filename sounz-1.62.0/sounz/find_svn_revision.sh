svn info | grep Revision | awk '{print "svn.revision=", $2}' >  /tmp/revision.txt
