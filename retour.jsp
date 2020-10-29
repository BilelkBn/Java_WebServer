<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="mediatheque.*"%>
<%@ page import="java.util.*"%>zz
<%List<Document> tousLesDoc = Mediatheque.getInstance().tousLesDocuments();%>
<%Object[] args;%>
<%String login = (String)request.getSession(true).getAttribute("login");%>
<html>
	<head>
		<title>Retourner</title>
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
			<div class="row">
				<div class="col-2"></div>
				<div class="card shadow-dark mt-5 col-8">
					<div class="card-body">
						<h1 class="display-4 text-center">Retourner</h1>
					</div>
				</div>
			</div>
			<%boolean aucunRetour = true;%>
			<%for (Document doc : tousLesDoc ){%>
				<%args = doc.affiche();%>
				<%if(login.equals(args[4])){%>
					<form action="./retourValider.jsp" method="get">
						<div class="row jumbotron shadow-dark mt-5 pt-4 pb-4 pr-4 pl-4">
								<h3 class="col-10"><%= args[1]%>, <%= args[2]%> (<%=args[3]%>)</h3>
								<button type="submit" class="btn btn-warning ">Retourner</button>
								<input type="hidden" name ="numDoc" value="<%=args[0]%>"></input>
						</div>
					</form>
					<%aucunRetour = false;%>
				<%}%>
			<%}%>
			<%if(aucunRetour){%>
					<form action="./accueil.jsp" method="get">
						<div class="row jumbotron shadow-dark mt-5 pt-4 pb-4 pr-4 pl-4">
								<h3 class="col-10">Vous n'avez aucun documment emprunté</h3>
								<button type="submit" class="btn btn-danger ">Retourner à l'accueil</button>
								<input type="hidden" name ="login" value="<%=login%>"></input>
						</div>
					</form>
			<%}%>
		</div>
	</body>
</html>