/*
	Die Replay Markup Language (RML) für SQL Server ist eine Sammlung von Tools und Diensten, 
	die verwendet werden, um SQL Server-Workloads zu analysieren und „nachzuspielen“. 
	Sie ermöglicht es Administratoren, SQL Server-Abfragen und -Befehle zu erfassen, 
	erneut auszuführen und zu untersuchen, um Probleme mit der Abfrageleistung und dem 
	Ressourcenverbrauch zu identifizieren und zu beheben.

	Funktionen und Hauptmerkmale des RML-Dienstes:
	1. Workload-Replay: zuvor erfasste Workload erneut abzuspielen (z.b aus Profiler-Trace)

	2. Leistungsanalyse und Vergleich: RML Workloads vor und nach Änderungen 
	   (z. B Indexänderungen oder Abfrageoptimierungen) abspielen und die Leistung vergleichen

	3. Ermittlung problematischer Abfragen: Zeit und Ressourcen der Abfragen

	4. Benutzer- und Sitzungsüberwachung:
	 - Kann Abfragen einzelnen Benutzern und Sitzungen zuordnen
	 => Hilfreich um zu analysieren, wie bestimmte Benutzer oder 
	    Anwendungen die SQL Server-Instanz belasten

	5. Parallelisierung und Lasttests:
	 - Unterstützt das parallele Abspielen von Workloads, was sich für Lasttests eignen


	 Anwendungsfälle des RML-Dienstes:
	 
	 Migrationstests:
	 - Beim verschieben der Datenbank auf eine neue Serverversion oder konfiguration, sorgt der
	   RML-Dienst das die Leistung erhalten bleibt oder verbessert wird

	Troubleshooting und Performance Tuning: 
	 - Durch erneutes Abspielen und Analysieren von Workloads lassen 
	   sich Leistungsprobleme erkennen und gezielt angehen.

	Kapazitätsplanung und Skalierbarkeit: 
	 - Unternehmen können simulieren, wie ihre Workloads auf größeren Servern 
	   oder anderen Hardwarekonfigurationen laufen würden, 
	   um die Skalierbarkeit zu bewerten.
*/