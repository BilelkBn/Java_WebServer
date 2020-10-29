<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import ="java.util.Scanner" %>
<%@ page import ="java.io.File" %>
<%@ page import ="java.io.FileNotFoundException" %>
<%	Scanner sc = null;
	String line = null;
	try {
		sc = new Scanner(new File("C:/Users/rezou/Desktop/apache-tomcat-9.0.14/webapps/mediathequeProjet/fichier.txt"));
		line = sc.nextLine();
		sc.close();
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	}
%>
<% Class.forName(line);%>
<%if(request.getParameter("deconnexion") != null){
	int deconexion = Integer.parseInt(request.getParameter("deconnexion"));
	if(deconexion == 1){
		request.getSession().invalidate();
	}
}
%>
<html>
	<head>
		<title>Connexion</title>
		<meta charset='utf-8'>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="./Bootstrap/css/bootstrap.min.css">
		<script src="./Bootstrap/js/bootstrap.min.js"></script>
		<link href="./styles/style.css" rel="stylesheet" type="text/css">
	</head>
	<body class="livre_back">
		<div class="container">
			<div class="row">
				<div class="col-2"></div>
				<div class="card shadow-dark mt-5 col-8">
					<div class="card-body">
						<h1 class="display-4 text-center">Connexion</h1>
					</div>
				</div>
			</div>
			<div class="row">
			<div class="col-md-4"></div>
			<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12">
				<h3 class=" res">Se connecter :</h3>
				<hr class="m-y-md">
				<form accept-charset="utf-8" method="post" action="./accueil.jsp">
					<div class="form-group">
						<label for="login">Login</label>
						<input type="text" class="form-control" name="login" id="login" placeholder="Saisissez votre login"></input>
					</div>
					<div class="form-group">
						<label for="password">Mot de passe</label>
						<input type="password" name="pwd" class="form-control" id="pwd" placeholder="Saisissez votre mot de passe"></input>
					</div>
					<button type="submit" class="btn btn-success">Connexion</button>
				</form>
			</div>
			<div class="col-md-4"></div>
			</div>
		</div>
	</body>
</html>