package de.uni_koeln.spinfo.fg.ui;

//TODO insert sample Predicate when hitting tab
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;

import antlr.RecognitionException;
import antlr.TokenStreamException;

import de.uni_koeln.spinfo.fg.ucs.InputProcessor;

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

    private InputProcessor processor;

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

}
