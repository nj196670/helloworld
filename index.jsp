<script src="https://maps.googleapis.com/maps/api/js"></script>
<script>

	function initialize() {
		var geocoder = new google.maps.Geocoder();
		var location = {};
		geocoder.geocode({
			'address' : '<%=request.getAttribute("googleMapUrl")%>'
		}, function(results, status) {
			if (status == google.maps.GeocoderStatus.OK) {
				location = results[0].geometry.location;
				var mapCanvas = document.getElementById('map-canvas');
				var mapOptions = {
					center : new google.maps.LatLng(location.lat(), location.lng()),
					zoom : 16,
					mapTypeId : google.maps.MapTypeId.ROADMAP
				}
				var map = new google.maps.Map(mapCanvas, mapOptions);
				var marker = new google.maps.Marker({
					map : map,
					position : results[0].geometry.location
				});
			} else {
				alert("Geocode was not successful for the following reason: " + status);
			}
		});
	}
	google.maps.event.addDomListener(window, 'load', initialize);

</script>

<%-- tpl:put name="headarea" --%>
	<TITLE>Property Report</TITLE>
 	
<%-- /tpl:put --%>
</HEAD>
<BODY>

<div align="center">
<TABLE cellspacing="0" cellpadding="0" border="0" width="755">
	<TBODY>		
		<TR>
			<TD>
			 <table width="755" border="0" cellspacing="1" cellpadding="0" height="400" bgcolor="#E6E6E6">
			    <tr valign="top">			      
			      <td width="100%">
			      	<!-- main body start -->
				      <TABLE width="100%"  border="0" cellpadding="0" cellspacing="0" bgcolor="#E6E6E6">   
						<TBODY><TR>
							<TD>						
							
							<%-- tpl:put name="bodyarea" --%><hx:scriptCollector id="scriptCollector1">
								<h:form  styleClass="form" id="formPropPortfolio">								
									<TABLE width="100%" border="0" cellpadding="0" cellspacing="0">
										<TR>
											<TD align="left" bgcolor="#C0C0C0" class="nav">
												<IMG src="/realestate/images/spacer.gif" alt="" width="10" height="10"> 
												<hx:jspPanel id="tabPanelAdmin" rendered="#{userBean.admin}">
													<h:commandLink id="linkLogoffA" action="#{pc_PropertyPortfolio.doLinkLogoffAction}">
														<h:outputText id="txtLogoffA" value="Log Off"></h:outputText>
													</h:commandLink>&nbsp; | &nbsp; 
													<strong>
													<h:commandLink id="linkReport" action="#{pc_PropertyPortfolio.doLinkReportAction}">
														<h:outputText id="txtReport" value="Report"></h:outputText>
													</h:commandLink>
													</strong>
												<!-- 	<STRONG>&nbsp;Report&nbsp;&nbsp;</STRONG> | &nbsp; -->
													&nbsp; | &nbsp;<A href="editmain.jsp">Edit</A>
												</hx:jspPanel> 
												<hx:jspPanel id="tabPanelVisitor" rendered="#{!userBean.admin}">
													<h:commandLink id="linkLogoffV" action="#{pc_PropertyPortfolio.doLinkLogoffAction}">
														<h:outputText id="txtLogoffV" value="Log Off"></h:outputText>
													</h:commandLink>&nbsp; | <STRONG>&nbsp;Report&nbsp;&nbsp;</STRONG>
												</hx:jspPanel> 
												<IMG src="/realestate/images/spacer.gif" alt="" width="10" height="10">
											</TD>
											<TD align="right" bgcolor="#C0C0C0" class="nav">
						 						<A href="<%=request.getContextPath() %>/convertPdf" target="_blank">Convert to PDF </A>
						 						<IMG src="/realestate/images/spacer.gif" alt="" width="10" height="10">
						 					</TD>
										</TR>
									</TABLE>
									<%  
										PropertyProfile profile = (PropertyProfile)request.getAttribute("propProfile");
										List budgets = (List) profile.getPropBudgets();
										RealEstatePropBudget budget1 = (RealEstatePropBudget) budgets.get(5);
										RealEstatePropBudget budget2 = (RealEstatePropBudget) budgets.get(4);
										RealEstatePropBudget budget3 = (RealEstatePropBudget) budgets.get(3);
										RealEstatePropBudget budget4 = (RealEstatePropBudget) budgets.get(2);
										RealEstatePropBudget budget5 = (RealEstatePropBudget) budgets.get(1);
										RealEstatePropBudget budget6 = (RealEstatePropBudget) budgets.get(0);	
										String yrYrStr = String.valueOf(budget6.getYear()) + "/" + String.valueOf(budget5.getYear());								
												
									%>
									<TABLE width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
									<TR><TD>
									<TABLE width="100%" border="0" cellpadding="5" cellspacing="0">
										<TR><TD height="5"></TD></TR>
										<!-- <TR><TD colspan="2" class="propTitle" align="center"><h:outputText id="txtPropName1" value="#{requestScope.propProfile.property.propName}"></h:outputText>&nbsp;(<h:outputText
																					id="txtPropType1"
																					value="#{requestScope.propProfile.property.addressFull}"></h:outputText>)</TD></TR>
										-->
										<TR>
											<TD width="50%">
												<TABLE width="100%" border="0" cellpadding="2" cellspacing="0">
													<TR><TD class="propMain"><h:outputText id="txtPropName" value="#{requestScope.propProfile.property.propName}"></h:outputText></TD></TR>
													<TR><TD class="propMain"><h:outputText id="txtPropAddr" value="#{requestScope.propProfile.property.streetAddr}"></h:outputText></TD></TR>
													<TR><TD class="propMain"><h:outputText id="txtPropCity" value="#{requestScope.propProfile.property.city}"></h:outputText>,&nbsp;<h:outputText id="txtPropState" value="#{requestScope.propProfile.property.state}"></h:outputText> </TD></TR>
												</TABLE>
											</TD>
											<TD width="50%" class="propMain" valign="top" align="right"><h:outputText id="txtQuarter" value="#{requestScope.propProfile.propRawData.qtrYearFull}"></h:outputText></TD>
										</TR>
										<TR>
											<TD width="55%" align="left">
												<img src="<%=request.getAttribute("propImg")%>" alt="Property Snapshot" width="340" height="180" border="0">											

                                      		</TD>
											<TD width="45%" class="main"> <div id="map-canvas"></div>										
											
											</TD>											
										</TR>