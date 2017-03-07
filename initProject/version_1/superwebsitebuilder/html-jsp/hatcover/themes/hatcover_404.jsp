<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en-US">

<head>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <title>404 Error Page</title>
    <link rel="stylesheet" type="text/css" href="../css/404bootstrap.min.css" media="all" />
    <link rel="stylesheet" type="text/css" href="../css/404style.css" media="all" />
</head>

<body>
    <div class="main">
        <div class="container page-text">
            <div class="row">
                <div class="col-sm-12">
                    <h1 class="rotate">Error 404!</h1>
                    <span>It seems that page you are looking for no longer exists.<br> Please Go to home page. <br> 
                    <a href="http://${feData.osDomainUrl}/">${feData.webSiteShowName}</a></span>
                </div>
            </div>
        </div>
    </div>
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="menu-container clearfix">
                        <ul class="menu"></ul>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="copyright pull-right">Copyright &copy; 2016 <a href="http://${feData.osDomainUrl}/">${feData.webSiteShowName}</a> | All Right Reserved.</div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>