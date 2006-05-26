/**
 * @author Fabian Steeg Created on 12.08.2004
 * 
 * @version $Revision: 1.1 $
 * 
 * $Log: Log.java,v $
 * Revision 1.1  2006/05/24 20:59:37  fsteeg
 * added basic unit test for parser, cleaned some more
 *
 * Revision 1.1  2005/10/20 00:48:54  fsteeg
 * kerberos share
 *
 * Revision 1.1  2005/10/16 02:04:02  fsteeg
 * prolog-generation, refactoring, javadoc, logging
 *
 * Revision 1.1  2005/10/12 00:50:02  fsteeg
 * flashserver-24
 *
 * * IRC-Server und Kanal als Parameter
 * * eigene IP nicht mehr noetig
 * * otherLogin nachrichten der clients gehen nur an den zuletzt neu eingeloggten client und mit kleinen pausen verschickt
 * * benutzerabfrage erganze (who is online)
 *
 * Revision 1.2  2005/08/12 15:47:31  fsteeg
 * flashserver-03
 *
 * Revision 1.1  2005/08/06 21:48:20  fsteeg
 * share project
 *
 * Revision 1.4  2005/06/06 01:30:18  fsteeg
 * cleaned sources
 *
 * Revision 1.3  2005/04/09 01:39:02  fsteeg
 * changes in topic-creation and logging
 *
 * Revision 1.2  2005/04/08 22:09:03  fsteeg
 * changes in topic-creation and logging
 *
 * Revision 1.1  2005/03/26 02:35:28  fsteeg
 * re-share
 *
 * Revision 1.7  2005/03/02 17:27:01  fsteeg
 * major performace increase through major changes in internal storage
 *
 * Revision 1.6  2005/03/01 19:16:17  fsteeg
 * few small cool changes
 *
 * Revision 1.5  2005/02/27 06:00:55  fsteeg
 * cleaned topics more
 *
 * Revision 1.4  2005/02/27 05:48:40  fsteeg
 * add only synonymes that are more than one word to the answers, small things
 *
 * Revision 1.3  2005/02/27 04:46:58  fsteeg
 * cleaned code, added learning synonymes as answers, logging of the chats
 *
 * Revision 1.2  2005/02/19 05:14:53  fsteeg
 * changed paths, running
 *
 * Revision 1.1  2005/02/19 04:39:48  fsteeg
 * share
 *
 * Revision 1.2  2005/01/31 02:37:24  fsteeg
 * refactored generated code
 *
 * Revision 1.1  2005/01/31 01:49:08  fsteeg
 * reshare
 * Revision 1.1 2004/09/08 21:53:27 fsteeg share
 * 
 * Revision 1.2 2004/08/12 03:30:37 fabian share
 * 
 * Revision 1.1 2004/08/12 02:50:12 fabian more logging, learn new topics
 *  
 */

package de.uni_koeln.spinfo.fg.util;

import java.io.File;
import java.util.logging.FileHandler;
import java.util.logging.Handler;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Log {
	public static Logger logger = Logger.getAnonymousLogger();

	public static void init(String logLoc) {
		Handler finer;
		Handler fine;
		Handler info;
		try {
			// String finerLoc = "";
			String fineLoc = "";
			String infoLoc = "";
			String loc = "";
			loc = logLoc;
			File f = new File(loc);
			boolean success = f.mkdir();
			if (!f.exists()) {
				System.out.println("Verzeichnis '" + loc
						+ "' konnte nicht erstellt werden.");
				System.exit(-1);
			}
			fineLoc = loc + java.io.File.separator + "fine-log.xml";
			infoLoc = loc + java.io.File.separator + "info-log.xml";
			
			fine = new FileHandler(fineLoc, false);
			fine.setLevel(Level.FINE);

			info = new FileHandler(infoLoc, false);
			info.setLevel(Level.INFO);

			// logger.addHandler(finer);
			// logger.addHandler(fine);
			// logger.addHandler(info);

			// logger.setLevel(Level.ALL);

			logger.info("Logging to: " + loc);
		} catch (SecurityException x) {

			x.printStackTrace();
		} catch (Exception x) {

			x.printStackTrace();
		}

	}

}