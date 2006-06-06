// Part of "Functional Grammar Language Generator" (http://fgram.sourceforge.net/) (C) 2006 Fabian Steeg
// This library is free software; you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License as published by the Free Software Foundation; either version 2.1 of the License, or (at your option) any later version.
// This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
// You should have received a copy of the GNU Lesser General Public License along with this library; if not, write to the Free Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

package de.uni_koeln.spinfo.fg.ui;

import java.awt.BorderLayout;
import java.awt.Color;
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
import javax.swing.border.LineBorder;

import de.uni_koeln.spinfo.fg.ucs.InputProcessor;
import de.uni_koeln.spinfo.fg.util.Config;
import de.uni_koeln.spinfo.fg.util.Log;

/**
 * A basic swing UI for evaluating a ucs
 * 
 * @author Fabian Steeg
 * 
 */
public class InterpreterFrame extends JFrame implements ActionListener {
    private static final long serialVersionUID = 1L;

    private JTextField input;

    private JTextArea output;

    private JCheckBox debug;

    final private InputProcessor processor;

    /**
     * @param swi
     *            The location of the "swipl" application
     * @throws HeadlessException
     */
    public InterpreterFrame(String swi) throws HeadlessException {
        super();
        this.setSize(new Dimension(600, 200));
        this.setTitle("FGRAM");
        Container container = this.getContentPane();
        input = new JTextField();
        input.setEditable(true);
        input.setSize(this.getWidth(), this.getHeight() / 2);
        input.setBorder(new LineBorder(Color.LIGHT_GRAY));
        input.setText(Config.getString("sample_ucs"));
        output = new JTextArea();
        output.setEditable(false);
        output.setBorder(new LineBorder(Color.LIGHT_GRAY));
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

    /**
     * @see java.awt.event.ActionListener#actionPerformed(java.awt.event.ActionEvent)
     */
    public void actionPerformed(ActionEvent e) {
        String inputUCS = input.getText();
        output.setText(processor.process(inputUCS, debug.isSelected()));
    }

    /**
     * @param args
     *            Not used, uses values from the properties file
     */
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
