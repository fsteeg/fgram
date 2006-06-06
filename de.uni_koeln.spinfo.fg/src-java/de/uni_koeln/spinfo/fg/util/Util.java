// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class Util {
    /**
     * Reads a file to a string, eliminating newline-characters
     * 
     * @param file
     *            The file to read
     * @return Returns the content of the file read, as a string
     */
    public static String getText(String loc) {
        File file = new File(loc);
        StringBuilder text = new StringBuilder();
        try {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line = "";
            while ((line = reader.readLine()) != null) {
                text.append(line).append(" ");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return text.toString();
    }

    /**
     * Saves a string to a file
     * 
     * @param location
     *            The location to save the file to
     * @param content
     *            The content to be saved
     */
    public static void saveString(String location, String content) {
        File f = new File(location);
        try {
            FileWriter writer = new FileWriter(f);
            writer.write(content.toCharArray());
            writer.close();
            System.out.println("Wrote output " + content + " to: "
                    + f.getAbsolutePath() + "\n");
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
