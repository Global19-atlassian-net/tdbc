# tdbcpostgre.tcl --
#
#	Class definitions and Tcl-level methods for the tdbc::postgre bridge.
#
# Copyright (c) 2009 by Slawomir Cygan
# See the file "license.terms" for information on usage and redistribution
# of this file, and for a DISCLAIMER OF ALL WARRANTIES.
#
#
#------------------------------------------------------------------------------

package require tdbc

::namespace eval ::tdbc::mypostgre {

    namespace export connection datasources drivers

}

#------------------------------------------------------------------------------
#
# tdbc::postgre::connection --
#
#	Class representing a connection to a database through MYSQL.
#
#-------------------------------------------------------------------------------

::oo::class create ::tdbc::postgre::connection {

    superclass ::tdbc::connection

    # The constructor is written in C. It takes alternating keywords
    # and values pairs as its argumenta.  (See the manual page for the
    # available options.)

    # The 'statementCreate' method delegates to the constructor of the
    # statement class

    forward statementCreate ::tdbc::postgre::statement create

    # The 'columns' method returns a dictionary describing the tables
    # in the database

}

#------------------------------------------------------------------------------
#
# tdbc::postgre::statement --
#
#	The class 'tdbc::postgre::statement' models one statement against a
#       database accessed through an MYSQL connection
#
#------------------------------------------------------------------------------

::oo::class create ::tdbc::postgre::statement {

    superclass ::tdbc::statement

    # The 'resultSetCreate' method forwards to the constructor of the
    # result set.

    forward resultSetCreate ::tdbc::postgre::resultset create

    # Methods implemented in C:
    #
    # constructor connection SQLCode
    #	The constructor accepts the handle to the connection and the SQL code
    #	for the statement to prepare.  It creates a subordinate namespace to
    #	hold the statement's active result sets, and then delegates to the
    #	'init' method, written in C, to do the actual work of preparing the
    #	statement.
    # params
    #   Returns descriptions of the parameters of a statement.
    # paramtype paramname ?direction? type ?precision ?scale??
    #   Declares the type of a parameter in the statement

}

#------------------------------------------------------------------------------
#
# tdbc::postgre::resultset --
#
#	The class 'tdbc::postgre::resultset' models the result set that is
#	produced by executing a statement against an MYSQL database.
#
#------------------------------------------------------------------------------

::oo::class create ::tdbc::postgre::resultset {

    superclass ::tdbc::resultset

    # Methods implemented in C include:

    # constructor statement ?dictionary?
    #     -- Executes the statement against the database, optionally providing
    #        a dictionary of substituted parameters (default is to get params
    #        from variables in the caller's scope).
    # columns
    #     -- Returns a list of the names of the columns in the result.
    # nextdict
    #     -- Stores the next row of the result set in the given variable in
    #        the caller's scope as a dictionary whose keys are 
    #        column names and whose values are column values, or else
    #        as a list of cells.
    # nextlist
    #     -- Stores the next row of the result set in the given variable in
    #        the caller's scope as a list of cells.
    # rowcount
    #     -- Returns a count of rows affected by the statement, or -1
    #        if the count of rows has not been determined.

}
