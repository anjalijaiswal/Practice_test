# Ruby program for reading webserver log and parsing it.

The folder structure of project is as follows:

lib -> Ruby code ie Parser class

logs -> logs files

spec -> rspec ie unit test cases related files

Gemfile -> have all the necessary gems required to run the project

# Specs:
I have used rspec for unit testing the class.
1. rspec version: 3.9
2. ruby version: ruby-2.6.6
--------------------------------------------------------------------------------
# Please keep in mind
Pass log file while initialising the Parser class. like:
  parser = Parser.new("webserver.log")

The class is exposing following public methods:
1. list_views: input: you can sort ('ASC' || 'DSC'): it would return an array of hash: [{"/home"=>78}, {"/help_page/1"=>80}, {"/about"=>81}, {"/index"=>82}, {"/contact"=>89}, {"/about/2"=>90}]
if you pass sort as anything other than "ASC" it would just sort in DSC order
2. uniq_views: same input/output as list_view
Extra bit, commented out since not in requirement
3. most_views_by_ip

--------------------------------------------------------------------------------
# Assumption : File size is not more than 1 gb.
--------------------------------------------------------------------------------
# Explanation:
1. Reading file line by line, that way memory usage is way lower, because when the line is processed then it's garbage collected, that way the size of the Objects Freed is quite high. (refer: https://tjay.dev/howto-working-efficiently-with-large-files-in-ruby/)

2. I have used Hash data structure to parse the log data, because they are much faster for retrieving data than arrays and linked lists.
A sorted array could find a particular value in O(log n) with binary search. However, a HashMap can check if it contains a particular key in O(1).

3. Created parser object in such a manner that all the information is preserved, later on if we want to see which page was hit my which IP the most, we have that information.
--------------------------------------------------------------------------------
Scope of improvement: 
1. we can add further reporting tools on the top of the existing framework, gems like ReportBuilder which will give graphical views:
https://github.com/rajatthareja/ReportBuilder/
2.  we can use buffer in case of really long input
