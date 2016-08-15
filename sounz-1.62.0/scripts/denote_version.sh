#!/bin/bash

#This script executes svn info and puts relevant information into a ruby file that can then display
#version information where appropriate on the site

export X=`svn info | grep Revision | awk '{print $2}'`

echo 'class VersionHelper'
  
echo  '  def self.REVISION' 
echo    $X
echo   '  end'
echo 'end'