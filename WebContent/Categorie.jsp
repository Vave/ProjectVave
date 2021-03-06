<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="Manager.CategorieManager" %>
<%@page import="Model.Categorie" %>
<%@page import="Manager.EvalManager" %>
<%@page import="Model.Evaluation" %>
<%@page import="Manager.LieuManager" %>
<%@page import="Model.Lieu" %>
<%@page import="Manager.UserManager" %>
<%@page import="Model.User" %>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%
	String listcate = request.getParameter("listcate");
	String cateaff = request.getParameter("descrip");
	CategorieManager cmanager = new CategorieManager();
	EvalManager emanager = new EvalManager();
	Categorie cate = new Categorie();
	LieuManager lmanager = new LieuManager();
	Lieu eta = new Lieu();
	List<Evaluation> evalcate = new ArrayList<Evaluation>();

	String ajout = "Error";
	if( ajout.equals(session.getAttribute("AjoutCate"))){ %>
		<script type="text/javascript">
		alert("Vous avez entr� un nom de cat�gorie d�j� existant! Veuillez recommencer!");
		</script> <%
		ajout = null;
		session.setAttribute("AjoutCate", "Valid");
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="Commun.css"/>
		<link rel="stylesheet" type="text/css" href="Eval.css"/>
	<title>Cat�gorie</title>
</head>
	<body>
		<header>
			<div id="logo">
				<img/>
			</div>
			<span id="menu_button">
				<input id="button_menu_left" type="button" value="Accueil" onclick="self.location.href='Accueil.jsp'"/>
				<input id="button_menu_left" type="button" value="Lieu" onclick="self.location.href='Lieu.jsp?listlieu=aff'"/>
				<% if(session.getAttribute("login") == null){ %>
					<input id="button_menu_right" type="button" value="Connexion" onclick="self.location.href='Login.jsp'"/>
					<input id="button_menu_right" type="button" value="Inscription" onclick="self.location.href = 'register.jsp'"/>
				<% } else{ %>
					<input id="button_menu_right" type="submit" value="D�connexion" onclick="self.location.href = 'Logout'"/>
					<div id="msg_co">
						Bonjour <%= session.getAttribute("login") %>, &nbsp;
					</div>
				<% } %>
			</span>
			<div id="content">
				<section id="info_content">
					<b><u>Information:</u></b>
					</br></br>
						<%if (listcate.equals("aff")){ %>
							<i>Cliquez sur une cat�gorie pour afficher ses informations</i>
						<% } else { %>
							<% cate = cmanager.GetCateByNom(cateaff);%>
							<b><u>Nom:</u></b>
							</br>
							<%= cate.getNom() %>
							</br></br>
							<b><u>Description:</u></b>
							</br>
							<%= cate.getDescription() %>
							</br></br>
							<% if(session.getAttribute("login") != null){ %>
								<a href="AddCate.jsp?Cate=<%= cate.getNom() %>"><i>Modifier la cat�gorie</i></a>
							<%} %>
						<% } %>
				</section>
				
				<section id="main_content">
					<% listcate = request.getParameter("listcate");
						if (listcate.equals("aff")){ 
							cmanager.GetListeCate();
							
							%> <h1> Liste des Cat�gories</h1>
								
								<% if(session.getAttribute("login") != null){ %>
								<button id="add_eval" onclick="self.location.href='AddCate.jsp?Cate=null'">Ajouter une cat�gorie</button></br><% } %><hr> <%
							for ( Categorie c : cmanager.getCategories()){ %>
								<a href='Categorie.jsp?listcate=cate&descrip=<%= c.getNom() %>'><li><%= c.getNom() %></li></a>
							<%}%>
						
					<% }else{ %>
						<% emanager.GetListEvalByCate(cate);%> 
							<h1>Liste des Evaluations</h1><a href="Categorie.jsp?listcate=aff"><i>Afficher toutes les cat�gories.</i></a>
								<% if(session.getAttribute("login") != null){ %>
								<button id="add_eval" onclick="self.location.href='AddEval.jsp'">Ajouter une �valuation</button><br><%} %><hr> <%
							for(Evaluation e : emanager.getEvalcate()){
								eta = lmanager.GetLieuById(e.getId_eta());%>
							<div id="eval">
								<div id="eta">
									<u><b>Etablissement:</b></u><br>
									<%= eta.getNom() %><br> <%= eta.getAdresse() %><br> <%= eta.getCodepostal() %> <%= eta.getVille() %> <br>
									<u>Tel:</u> <%= eta.getTelephone() %> <br>
									<button TARGET=popup onclick="window.open('MapBing.jsp?adr=<%= eta.getAdresse() %> <%= eta.getCodepostal() %> <%= eta.getVille() %>','popup','width=420,height=430,left=0,top=0,scrollbars=1')">Voir la carte</button>
									 <br><br>
								</div>
								<div id="user_eval">
									<u><b>Evaluateur:</b></u><br>
									<% User us = new User();
										UserManager umanager = new UserManager();
										us = umanager.GetUserById(e.getId_uti());%>
										<%= us.getPseudo() %><br>
										<%= us.getDate() %>
								</div>
								<div id="carac_eval">
									<u><b>Evaluation:</b></u>
									<br>
									<u>Titre:</u> <%= e.getNom() %>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Note:<%= e.getNote() %>/5   &nbsp;&nbsp;&nbsp; <%= e.getDateEval() %>
									<br>
									<u>Objet:</u> <%= e.getComCourt() %><br>
									<u>Commentaire:</u><br>
									<%= e.getComLong() %><br>
									<u>Autre:</u><br>
									<%= e.getAutreEva() %><br>
								</div>
							</div>
 							<br><br>
						<% } %>
					<%} %>
				</section>
			</div>
			
		</header>
		<section>
			
		</section>
	</body>
</html>