package de.uni_koeln.spinfo.fg.ui;

//TODO insert sample Predicate when hitting tab
import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.HeadlessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JFrame;
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

	public InterpreterFrame() throws HeadlessException {
		super();
		this.setSize(new Dimension(600, 800));
		this.setTitle("FG");
		Container container = this.getContentPane();

		input = new JTextField();
		input.setEditable(true);
		input.setSize(this.getWidth(), this.getHeight() / 2);
		input.setBorder(new TitledBorder("input"));
		input.setText("( d1e1:love[V]: (d1x1:man[N])AgentSubject (d1x2:woman[N])GoalObject )");
		output = new JTextArea();
		output.setEditable(false);
		output.setBorder(new TitledBorder("output"));
		output.setSize(this.getWidth(), this.getHeight() / 2);
		output.setLineWrap(true);

		container.setLayout(new BorderLayout());
		container.add(input, BorderLayout.NORTH);
		container.add(output, BorderLayout.CENTER);
		input.addActionListener(this);

		this.setVisible(true);
	}

	public void actionPerformed(ActionEvent e) {
		String inputUCS = input.getText();
		InputProcessor processor = new InputProcessor(inputUCS);
		try {
            output.setText(processor.process());
        } catch (RecognitionException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        } catch (TokenStreamException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
	}

}
