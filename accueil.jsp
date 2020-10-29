<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="mediatheque.*"%>
<%Utilisateur user;
  String login = null;
if(request.getSession(true).getAttribute("user") == null){
	login = request.getParameter("login");
	String password = request.getParameter("pwd");
	user = Mediatheque.getInstance().getUser(login, password);
} else {
	user = (Utilisateur)request.getSession(true).getAttribute("user");
}%>
<html lang="fr">
	<head>
		<meta charset="UTF-8">
		<title>Accueil</title>
		<meta charset='utf-8'>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="./Bootstrap/css/bootstrap.min.css">
		<script src="./Bootstrap/js/bootstrap.min.js"></script>
		<link href="./styles/style.css" rel="stylesheet" type="text/css"/>
	</head>
	<body class="livre_back">
		
		<div class="container">
			<form action="./index.jsp" method="post">
				<input type="hidden" name ="deconnexion" value="1"></input>
				<button type="submit" class="btn btn-danger">Se déconnecter</button>
			</form>
			<div class="row">
				<div class="col-2"></div>
				<div class="card shadow-dark mt-5 col-8">
					<div class="card-body">
						<h1 class="display-4 text-center">Accueil</h1>
					</div>
				</div>
				<div class="col-2"></div>
			</div>
			<%if(user == null){%>
				<div class="row">
					<div class="col-md-4"></div>
						<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12 btn btn-dark survol-action">
							<h3 class=" text-center action"><a href="./index.jsp">Erreur de connexion</a></h3>
							<hr class="m-y-md">
						</div>
					<div class="col-md-4"></div>
				</div>
			<%} else if(!(user.isBibliothecaire())){%>
			<%request.getSession(true).setAttribute("user", user);
				if(request.getSession(true).getAttribute("login")==null){
				request.getSession(true).setAttribute("login", login);
				}%>
			<div class="row">
				<div class="col-md-1"></div>
				<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12 btn btn-dark survol-action">
					<h3 class="text-center action"><a href="./emprunter.jsp">Emprunter</a></h3>
					<hr class="m-y-md">
				</div>
				<div class="col-md-2"></div>
				<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12 btn btn-dark survol-action">
					<h3 class=" text-center action"><a href="./retour.jsp">Retourner</a></h3>
					<hr class="m-y-md">
				</div>
				<div class="col-md-1"></div>
			</div>
			<%} else if((user.isBibliothecaire())){%>
			<%request.getSession(true).setAttribute("user", user);%>
				<div class="row">
					<div class="col-md-4"></div>
					<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12 btn btn-dark survol-action">
						<h3 class=" text-center action"><a href="./ajoutDoc.jsp">Ajouter un document</a></h3>
						<hr class="m-y-md">
					</div>
					<div class="col-md-4"></div>
				</div>
			<%}%>
		</div>
	</body>
</html>