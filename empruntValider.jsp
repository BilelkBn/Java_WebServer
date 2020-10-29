<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="mediatheque.*"%>
<%int numDocument = Integer.parseInt(request.getParameter("numDoc"));%>
<%Utilisateur user = (Utilisateur)request.getSession(true).getAttribute("user");%>
<%Document doc = Mediatheque.getInstance().getDocument(numDocument);%>
<%boolean estEmprunter;%>
<%try{
Mediatheque.getInstance().emprunt(doc, user);
estEmprunter = true;
} catch(EmpruntException e){
	estEmprunter = false;
}%>
<%Object[] args = doc.affiche();%>
<html>
	<head>
		<title>Emprunt</title>
		<meta charset='utf-8'>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
		<link rel="stylesheet" href="./Bootstrap/css/bootstrap.min.css">
		<script src="./Bootstrap/js/bootstrap.min.js"></script>
		<link href="./styles/style.css" rel="stylesheet" type="text/css">
	</head>
	<body class="livre_back">
		<div class="container">
			<form action="./index.jsp" method="post">
				<input type="hidden" name ="deconnexion" value="1"></input>
				<button type="submit" class="btn btn-danger">Se déconnecter</button>
			</form>
			<%if(estEmprunter){%>
			<div class="row">
				<div class="col-2"></div>
				<div class="card shadow-dark mt-5 col-8">
					<div class="card-body">
						<h1 class="display-4 text-center">Vous avez emprunté <%=args[1]%></h1>
					</div>
				</div>
			</div>
			<%} else {%>
				<div class="row">
					<div class="col-2"></div>
					<div class="card shadow-dark mt-5 col-8">
						<div class="card-body">
							<h1 class="display-4 text-center">Désolé, <%=args[1]%> n'est plus disponible</h1>
						</div>
					</div>
				</div>
			<%}%>
			<div class="row">
				<div class="col-md-4"></div>
				<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12 btn btn-dark survol-action">
					<h3 class=" text-center action"><a href="./accueil.jsp">Retour à l'accueil</a></h3>
					<hr class="m-y-md">
				</div>
				<div class="col-md-4"></div>
			</div>

		</div>
	</body>
</html>