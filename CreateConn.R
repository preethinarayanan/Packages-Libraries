#' Create a Server Connection
#'
#' @param driver the driver being used, ex: "{SQL Server Native Client 11.0}"
#' @param server the intended server to be used, ex: "sql02-2"
#' @param database the designated database you need to pull from, ex: "SubmissionDB"
#' @param trusted_connection keep as yes
#' @param port the designated port, ex: 1433
#' @param user your database username if needed; default is NULL
#' @param password your database password if needed; default is NULL
#'
#' @importFrom odbc "odbc"
#' @importFrom DBI "dbConnect"
#'
#' @return a database connection object using dbconnect from DBI package
#' @export
#'
#' @examples
#' myconn <- CreateConn(driver = "{SQL Server Native Client 11.0}",
#'                      server = "sql02-2", database = "SubmissionDB", port = 1433)
#'

CreateConn <- function(driver, server, database, trusted_connection = "yes", port, user = NULL, password = NULL) {

  myconn <- dbConnect(odbc(),
                      Driver = driver,
                      Server = server,
                      Database = database,
                      Trusted_Connection = trusted_connection,
                      Port = port,
                      uid = user,
                      pwd = password)

  return(myconn)

}
