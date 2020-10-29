<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<html>
	<head>
		<title>Ajouter un document</title>
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
						<h1 class="display-4 text-center">Ajouter un document</h1>
					</div>
				</div>
			</div>
			<div class="row">
			<div class="col-md-4"></div>
			<div class="jumbotron shadow-dark mt-5 col-md-4 col-sm-12">
				<h3 class=" res">Ajouter :</h3>
				<hr class="m-y-md">
				<form accept-charset="utf-8" method="post" action="./ajoutValider.jsp">
					<div class="form-group">
						<label for="titre">Titre</label>
						<input type="text" class="form-control" name="titre" placeholder="Saisissez le titre du documment"></input>
					</div>
					<div class="form-group">
						<label for="createur">Créateur</label>
						<input type="text" name="createur" class="form-control" placeholder="Saisissez le nom du créateur du document"></input>
					</div>
					<div class="form-group">
						<label for="type">Type du document</label>
						<select name="type" class="form-control">
						  <option value="1">Livre</option>
						  <option value="2">DVD</option>
						</select>
					</div>
					<button type="submit" class="btn btn-success">Ajouter</button>
				</form>
			</div>
			<div class="col-md-4"></div>
			</div>
			</div>
	</body>
</html>