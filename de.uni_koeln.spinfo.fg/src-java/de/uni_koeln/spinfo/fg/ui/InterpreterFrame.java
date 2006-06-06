// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ui;

//TODO insert sample Predicate when hitting tab
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;

import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;

import antlr.RecognitionException;
import antlr.TokenStreamException;
import de.uni_koeln.spinfo.fg.ucs.InputProcessor;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * A basic UI for evaluating Predicate-Expressions
 * 
 * @author Fabian Steeg
 * 
 */
public class InterpreterFrame extends JFrame implements ActionListener {
    private static final long serialVersionUID = 1L;

    JTextField input;

    JTextArea output;

    JCheckBox debug;

    final private InputProcessor processor;

    public InterpreterFrame(String swi) throws HeadlessException {
        super();
        this.setSize(new Dimension(600, 200));
        this.setTitle("FG");
        Container container = this.getContentPane();

        input = new JTextField();
        input.setEditable(true);
        input.setSize(this.getWidth(), this.getHeight() / 2);
        input.setBorder(new TitledBorder("input"));
        input
                .setText("(Past E : love [V] : ( D1X : man[N] ) AgSubj ( DMX : woman[N] ) GoObj )");

        output = new JTextArea();
        output.setEditable(false);
        output.setBorder(new TitledBorder("output"));
        output.setSize(this.getWidth(), this.getHeight() / 2);
        output.setLineWrap(true);

        JScrollPane scrollPane = new JScrollPane(output);
        debug = new JCheckBox("verbose");

        container.setLayout(new BorderLayout());
        container.add(input, BorderLayout.NORTH);
        container.add(debug, BorderLayout.SOUTH);
        container.add(scrollPane, BorderLayout.CENTER);
        input.addActionListener(this);

        processor = new InputProcessor(swi);

        this.setVisible(true);
    }

    public void actionPerformed(ActionEvent e) {
        String inputUCS = input.getText();

        try {
            output.setText(processor.process(inputUCS, debug.isSelected()));
        } catch (RecognitionException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        } catch (TokenStreamException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
    }

    // uses values from the properties file
    public static void main(String args[]) {
        Log.init(Config.getString("log_folder"));
        // gui:
        final InterpreterFrame interpreter = new InterpreterFrame(Config
                .getString("prolog_application"));
        WindowListener wl = new WindowAdapter() {

            @Override
            public void windowClosing(WindowEvent e) {
                interpreter.processor.close();
                System.exit(0);
            }

        };
        interpreter.addWindowListener(wl);
    }

}
