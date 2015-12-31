#!/usr/bin/python
# -*- coding: utf-8 -*-
# d0rk3r.py - a modified v3n0m

import string, sys, time, urllib2, cookielib, re, random, threading, socket, os, subprocess
from random import choice

if sys.platform == 'linux' or sys.platform == 'linux2':
  subprocess.call("clear", shell=True)
  
else:
  subprocess.call("cls", shell=True)
  

timeout = 60
socket.setdefaulttimeout(timeout)

header = ['Mozilla/4.0 (compatible; MSIE 5.0; SunOS 5.10 sun4u; X11)',
          'Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.2pre) Gecko/20100207 Ubuntu/9.04 (jaunty) Namoroka/3.6.2pre',
          'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 5.1; Avant Browser;']       

d0rk = [ 'intitle:index%20of']

sitearray = [ 'com' ]

def search(maxc):
	urls = []
	urls_len_last = 0
	for site in sitearray:
		dark = 0
		for dork in d0rk:
			dark += 1
			page = 0
			try:
				while page < int(maxc):
					try:
		            			jar = cookielib.FileCookieJar("cookies")
		           			query = dork+"+site:"+site
		            			results_web = 'http://www.search-results.com/web?q='+query+'&hl=en&page='+repr(page)+'&src=hmp'
		           			request_web =urllib2.Request(results_web)
		            			agent = random.choice(header)
				            	request_web.add_header('User-Agent', agent)
				            	opener_web = urllib2.build_opener(urllib2.HTTPCookieProcessor(jar))
				            	text = opener_web.open(request_web).read()
				            	stringreg = re.compile('(?<=href=")(.*?)(?=")')
				            	names = stringreg.findall(text)
		            			page += 1
		            			for name in names:
		              				if name not in urls:
			          				if re.search(r'\(',name) or re.search("<", name) or re.search("\A/", name) or re.search("\A(http://)\d", name):
			            					pass
			          				elif re.search("google",name) or re.search("youtube", name) or re.search("phpbuddy", name) or re.search("iranhack",name) or re.search("phpbuilder",name) or re.search("codingforums", name) or re.search("phpfreaks", name) or re.search("%", name) or re.search("facebook", name) or re.search("twitter", name):
		            						pass
			          				elif re.search(site,name):
		            						urls.append(name)
		            			darklen = len(d0rk)
		            			percent = int((1.0*dark/int(darklen))*100)
		      				urls_len = len(urls)
		      				sys.stdout.write("\rSite: %s | Collected urls: %s | D0rks: %s/%s | Percent Done: %s | Current page no.: %s <> " % (site,repr(urls_len),dark,darklen,repr(percent),repr(page)))
		      				sys.stdout.flush()
					except:
						pass
	      
	
			except(KeyboardInterrupt):
				exit
	print urls		 
search(2)
