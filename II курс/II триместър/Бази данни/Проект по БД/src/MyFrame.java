import java.awt.*;
import java.awt.event.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTable;
import javax.swing.JTextField;


public class MyFrame extends JFrame{

	
	Connection conn 		 = null;
	PreparedStatement state  = null;
	ResultSet result 		 = null;
	
	PreparedStatement state1 = null;
	ResultSet result1 		 = null;
	
	PreparedStatement state2 = null;
	ResultSet result2 		 = null;
	
	int id;
	
    JFrame frame = new JFrame();
    JPanel p1 	 = new JPanel();
    JPanel p2 	 = new JPanel();
    JPanel p3 	 = new JPanel();
    JPanel p4 	 = new JPanel();
   
	JLabel buildingL = new JLabel("��� �� ������:");
	JLabel addressL  = new JLabel("�����:");
	JLabel heightL 	 = new JLabel("��������:");
	
	JTextField buildingTF = new JTextField();
	JTextField addressTF  = new JTextField();
	JTextField heightTF   = new JTextField();
	
	JButton addBt 	 = new JButton("��������");
	JButton deleteBt = new JButton("���������");
	JButton editBt   = new JButton("�����������");
	JButton searchBt = new JButton("������� �� ���");
    JButton refreshBt = new JButton("������");
	
	
	JLabel roomSizeL 	   = new JLabel("������ �� ����:");
	JLabel roomNameL 	   = new JLabel("��� ����:");
	JLabel colorL 		   = new JLabel("����:");
	
	JTextField roomNameTF 		= new JTextField();
	JTextField roomSizeTF 		= new JTextField();
	JTextField colorTF 		    = new JTextField();
	
	JButton addBt1 	   = new JButton("��������");
	JButton editBt1    = new JButton("�����������");
	JButton deleteBt1  = new JButton("���������");
	JButton searchBt1  = new JButton("������� �� ���");
    JButton refreshBt1 = new JButton("������");
	
    
	
	JLabel buildingNL 	  = new JLabel("��� �� ������:");
	JLabel typeRoomL 	  = new JLabel("��� ����:");
	
	JTextField priceTF    = new JTextField();

	JButton addBt2 	  = new JButton("��������");
	JButton editBt2   = new JButton("�����������");
	JButton deleteBt2 = new JButton("���������");
	

    JComboBox<String> buildingNameComboBox = new JComboBox<String>();
    JComboBox<String> roomTypeComboBox = new JComboBox<String>();
	
    JLabel priceL 			= new JLabel("����:");
	
	JLabel queryBuildingL 	= new JLabel("��� �� ������:");
    JLabel queryTypeRoomL 	= new JLabel("��� ����:");
    
 
	JTextField queryBuildingTF 	= new JTextField();
	JTextField queryTypeRoomTF 	= new JTextField();
    
    JButton showBt 				= new JButton("������");
    
    
    
	JTable table 		 	= new JTable();
	JScrollPane myScroll 	= new JScrollPane(table); 
	
	JTable table1 		 	= new JTable();
	JScrollPane myScroll1 	= new JScrollPane(table1); 
	
	JTable table2 		 	= new JTable();
	JScrollPane myScroll2 	= new JScrollPane(table2); 

	JTable table3 			= new JTable();
    JScrollPane myScroll3 	= new JScrollPane(table3);
  
    
	public MyFrame() {
		
		JTabbedPane tabs = new JTabbedPane();
	    tabs.setBounds(0,0,627,440);
	    
	    frame.setTitle("Application");
	    
	    tabs.add("������", p1);
	    p1.setLayout(null);
	    
	    
	    buildingL.setBounds(0, 9, 267, 44);
	    p1.add(buildingL);
	    addressL.setBounds(0, 84, 136, 35);
	    p1.add(addressL);
	    heightL.setBounds(0, 153, 136, 35);
	    p1.add(heightL);
	    
	    
	    buildingTF.setBounds(270, 10, 267, 44);
	    p1.add(buildingTF);
	    addressTF.setBounds(270, 80, 267, 44);
	    p1.add(addressTF);
	    heightTF.setBounds(270, 149, 267, 44);
	    p1.add(heightTF);
	    
	    
	    addBt.setBounds(10, 210, 108, 44);
	    p1.add(addBt);
	    deleteBt.setBounds(250, 210, 108, 44);
	    p1.add(deleteBt);
	    editBt.setBounds(128, 210, 112, 44);
	    p1.add(editBt);
	    searchBt.setBounds(367, 210, 134, 44);
	    p1.add(searchBt);
	    refreshBt.setBounds(511, 210, 101, 44);
	    p1.add(refreshBt);
	    
	    
	    myScroll.setEnabled(false);
	    myScroll.setBounds(94, 282, 443, 121);
	    myScroll.setPreferredSize(new Dimension(350, 150));
	    p1.add(myScroll);
	    
 
	    table.addMouseListener(new MouseAction());
	    addBt.addActionListener(new AddAction());
	    deleteBt.addActionListener(new DeleteAction());
	    editBt.addActionListener(new EditAction());
	    searchBt.addActionListener(new SearchAction());
	    refreshBt.addActionListener(new RefreshAction());
	    
	    refreshTable();
	    
	    //----------------------------------------------------------------------------------------
		
	    tabs.add("����", p2);
	    p2.setLayout(null);
	    
	    
	    roomNameL.setBounds(0, 19, 94, 26);
	    p2.add(roomNameL);
	    roomSizeL.setBounds(0, 87, 126, 26);
	    p2.add(roomSizeL);
	    colorL.setBounds(0, 158, 169, 26);
	    p2.add(colorL);
	    
	    
	    roomNameTF.setBounds(222, 19, 287, 45);
	    p2.add(roomNameTF);
	    roomSizeTF.setBounds(222, 87, 287, 45);
	    p2.add(roomSizeTF);
	    colorTF.setBounds(222, 149, 287, 45);
	    p2.add(colorTF);
	    
	    
	    addBt1.setBounds(10, 217, 107, 44);
	    p2.add(addBt1);
	    editBt1.setBounds(127, 217, 113, 44);
	    p2.add(editBt1);
	    deleteBt1.setBounds(250, 217, 107, 44);
	    p2.add(deleteBt1);
	    searchBt1.setBounds(367, 217, 139, 44);
	    p2.add(searchBt1);
	    refreshBt1.setBounds(516, 217, 101, 44);
	    p2.add(refreshBt1);

	    
	    myScroll1.setEnabled(false);
	    myScroll1.setBounds(89, 282, 420, 121);
	    myScroll1.setPreferredSize(new Dimension(350, 150));
	    p2.add(myScroll1);
	    

	    table1.addMouseListener(new MouseAction1());
	    addBt1.addActionListener(new AddAction1());
	    deleteBt1.addActionListener(new DeleteAction1());
	    editBt1.addActionListener(new EditAction1());
	    searchBt1.addActionListener(new SearchAction1());
	    refreshBt1.addActionListener(new RefreshAction1());
		
	    refreshTable1();
	    //-----------------------------------------------------------------------------------------
	   
	    tabs.add("����", p3);
	    p3.setLayout(null);
	    
	    
	    buildingNL.setBounds(0, 28, 111, 19);
	    p3.add(buildingNL);
	    typeRoomL.setBounds(0, 91, 124, 19);
	    p3.add(typeRoomL);
	    priceL.setBounds(0, 154, 124, 19);
	    p3.add(priceL);
	    
	    buildingNameComboBox.setBounds(238, 19, 271, 36);
	    p3.add(buildingNameComboBox);
	    
	    roomTypeComboBox.setBounds(238, 79, 271, 36);
	    p3.add(roomTypeComboBox);
	    
		priceTF.setBounds(238, 142, 271, 36);
		priceTF.setColumns(10);
		p3.add(priceTF);
			 
	   
	    addBt2.setBounds(56, 204, 134, 44);
	    p3.add(addBt2);
	    editBt2.setBounds(245, 204, 134, 44);
	    p3.add(editBt2);
	    deleteBt2.setBounds(436, 204, 134, 44);
	    p3.add(deleteBt2);
	    

	    myScroll2.setEnabled(false);
	    myScroll2.setBounds(89, 282, 420, 121);
	    myScroll2.setPreferredSize(new Dimension(350, 150));
	    p3.add(myScroll2);
	    
	   

	    table2.addMouseListener(new MouseAction2());
	    addBt2.addActionListener(new AddAction2());
	    deleteBt2.addActionListener(new DeleteAction2());
	    editBt2.addActionListener(new EditAction2());
	    
	    refreshTable2();
	    refreshBuildingComboBox();
	    refreshRoomTypeComboBox();
	    //------------------------------------------------------------------------------------------
	  
	    tabs.add("������� �� ��� � ���", p4);
	    p4.setLayout(null);
	    
	   
	    queryBuildingL.setBounds(0, 30, 164, 44);
	    p4.add(queryBuildingL);
	    queryTypeRoomL.setBounds(0, 139, 78, 19);
	    p4.add(queryTypeRoomL);
	   
	    
	    queryBuildingTF.setBounds(262, 31, 228, 44);
	    p4.add(queryBuildingTF);
	    queryTypeRoomTF.setBounds(262, 126, 228, 45);
	    p4.add(queryTypeRoomTF);
	    
	  
	    myScroll3.setPreferredSize(new Dimension(350, 150));
	    myScroll3.setEnabled(false);
	    myScroll3.setBounds(75, 276, 420, 111);
	    p4.add(myScroll3);
	    

	    showBt.setBounds(208, 202, 134, 44);
	    p4.add(showBt);
	    
	
	    showBt.addActionListener(new ShowAction());
	
		this.setSize(600, 600);
		this.setDefaultCloseOperation(EXIT_ON_CLOSE);
		
		getContentPane().setLayout(new GridLayout(7, 1));

		frame.getContentPane().add(tabs);
	    frame.setSize(641,477);
	    frame.getContentPane().setLayout(null);
	    frame.setVisible(true);

	}
	
	
	public void refreshTable() {
			conn = DBConnection.getConnection();
			try {
				state = conn.prepareStatement("select * from buildingbb");
				result = state.executeQuery();
				table.setModel(new MyModel(result));
			}catch(SQLException e){
				e.printStackTrace();
			}catch(Exception e){
				e.printStackTrace();
		}
	}
	
	public void clearForm() {
			buildingTF.setText("");
			addressTF.setText("");
			heightTF.setText("");
		}
		
		
	class RefreshAction implements ActionListener{

			@Override
			public void actionPerformed(ActionEvent e) {
				refreshTable();
			}
		}
		
		
	class AddAction implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "insert into buildingbb(name, address, height) values(?,?,?)";
			
			try {
			state = conn.prepareStatement(sql);
			state.setString(1, buildingTF.getText());
			state.setString(2, addressTF.getText());
			state.setString(3, heightTF.getText());
			
			state.execute();
			refreshBuildingComboBox();
			refreshRoomTypeComboBox();
			refreshTable();
			clearForm();
	
			
			}catch (SQLException e1) {
				e1.printStackTrace();
			}	
		}
	}
	
	class MouseAction implements MouseListener {

		@Override
		public void mouseClicked(MouseEvent e) {
			int row = table.getSelectedRow();
			id = Integer.parseInt(table.getValueAt(row, 0).toString());
			buildingTF.setText(table.getValueAt(row, 1).toString());
			addressTF.setText(table.getValueAt(row, 2).toString());
			heightTF.setText(table.getValueAt(row, 3).toString());
		}

		@Override
		public void mousePressed(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	class DeleteAction implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "delete from buildingbb where building_id=?";
			
			try {
				state = conn.prepareStatement(sql);
				state.setInt(1, id);
				state.execute();
				refreshTable();
				refreshBuildingComboBox();
				refreshRoomTypeComboBox();
				clearForm();
				id = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}
	
	class SearchAction implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "select * from buildingbb where name=?";

			try {
				state = conn.prepareStatement(sql);
				state.setString(1, buildingTF.getText());
				result = state.executeQuery();
				table.setModel(new MyModel(result));
			} catch (SQLException e1) {
				e1.printStackTrace();
			} catch (Exception e1) {
				e1.printStackTrace();
			}	
		}
	}
	
	class EditAction implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {	
			int row = table.getSelectedRow();
			String value = (table.getModel().getValueAt(row, 0).toString());
			
			try {
				String sql = "update buildingbb set name=?, address=?, height=? where building_id=" + value;
				state = conn.prepareStatement(sql);
				state.setString(1, buildingTF.getText());
				state.setString(2, addressTF.getText());
				state.setString(3, heightTF.getText());
			
				state.executeUpdate();
				refreshTable();
				refreshBuildingComboBox();
				refreshRoomTypeComboBox();
				clearForm();
				
			  }catch(Exception e1) {
				e1.printStackTrace();
			}
		}
	}
	
	
	class RefreshAction1 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			refreshTable1();
		}
	}
	
	public void refreshTable1() {
		conn = DBConnection.getConnection();
		try {
			state = conn.prepareStatement("select * from roomrr");
			result = state.executeQuery();
			table1.setModel(new MyModel(result));
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
	    }
     }	
	
	public void clearForm1() {
		roomSizeTF.setText("");
		roomNameTF.setText("");
		colorTF.setText("");
	}	

	class AddAction1 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "insert into roomrr(type, size, color) values(?,?,?)";
			
			try {
			state1 = conn.prepareStatement(sql);
			state1.setString(1, roomNameTF.getText());
			state1.setString(2, roomSizeTF.getText());
			state1.setString(3, colorTF.getText());

			
			state1.execute();
			refreshTable1();
			refreshBuildingComboBox();
			refreshRoomTypeComboBox();
			clearForm1();

			}catch (SQLException e1) {
				e1.printStackTrace();
			}	
		}
	}
	
	class MouseAction1 implements MouseListener {

		@Override
		public void mouseClicked(MouseEvent e) {
			int row = table1.getSelectedRow();
			id = Integer.parseInt(table1.getValueAt(row, 0).toString());
			roomSizeTF.setText(table1.getValueAt(row, 1).toString());
			roomNameTF.setText(table1.getValueAt(row, 2).toString());
			colorTF.setText(table1.getValueAt(row, 3).toString());
		}

		@Override
		public void mousePressed(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	class EditAction1 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {	
			int row = table1.getSelectedRow();
			String value = (table1.getModel().getValueAt(row, 0).toString());
			
			try {
				String sql = "update roomrr set type=?, size=?, color=? where room_id=" + value;
				state1 = conn.prepareStatement(sql);
				state1.setString(1, roomSizeTF.getText());
				state1.setString(2, roomNameTF.getText());
				state1.setString(3, colorTF.getText());
			
				state1.executeUpdate();
				refreshTable1();
				refreshBuildingComboBox();
				refreshRoomTypeComboBox();
				clearForm1();
				
			  }catch(Exception e1) {
				e1.printStackTrace();
			}
		}
	}
	
	
	class DeleteAction1 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "delete from roomrr where room_id=?";
			
			try {
				state1 = conn.prepareStatement(sql);
				state1.setInt(1, id);
				state1.execute();
				refreshTable1();
				refreshBuildingComboBox();
				refreshRoomTypeComboBox();
				clearForm1();
				id = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	
	class SearchAction1 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "select * from roomrr where type=?";

			try {
				state1 = conn.prepareStatement(sql);
				state1.setString(1, roomNameTF.getText());
				result = state1.executeQuery();
				table1.setModel(new MyModel(result));
			} catch (SQLException e1) {
				e1.printStackTrace();
			} catch (Exception e1) {
				e1.printStackTrace();
			}	
		}
	}
	
	public void refreshTable2() {
		conn = DBConnection.getConnection();
		try {
			state = conn.prepareStatement("	SELECT levels_id, name, type, price \r\n"
					+ "	FROM Pricee P \r\n"
					+ "	JOIN buildingbb B \r\n"
					+ "	ON P.BUILDING_NAME = B.BUILDING_ID \r\n"
					+ "	JOIN roomrr R \r\n"
					+ "	ON P.ROOM_TYPE = R.ROOM_ID");
			result = state.executeQuery();
			table2.setModel(new MyModel(result));
		}catch(SQLException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
	    }
     }		
	
	public void clearForm2() {
		priceTF.setText("");
	}	
	
	public void refreshBuildingComboBox() {
		
		buildingNameComboBox.removeAllItems();
		
		String sql = "select building_id, name from buildingbb";
		conn = DBConnection.getConnection();
		String item = "";
		
		try {
			state = conn.prepareStatement(sql);
			result = state.executeQuery();
			while(result.next()) {
				item = result.getObject(1).toString()+"."+result.getObject(2).toString();
				buildingNameComboBox.addItem(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void refreshRoomTypeComboBox() {
		
		roomTypeComboBox.removeAllItems();
		
		String sql = "select room_id, type from roomrr";
		conn = DBConnection.getConnection();
		String item = "";
		
		try {
			state = conn.prepareStatement(sql);
			result = state.executeQuery();
			while(result.next()) {
				item = result.getObject(1).toString()+"."+result.getObject(2).toString();
				roomTypeComboBox.addItem(item);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	class AddAction2 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			
			conn = DBConnection.getConnection();
			String firstValue  = buildingNameComboBox.getSelectedItem().toString();
			String secondValue = roomTypeComboBox.getSelectedItem().toString();
			String sql = "insert into pricee(building_name, room_type, price) values(?,?,?)";
			
			try {
			state1 = conn.prepareStatement(sql);
			state1.setInt(1, Integer.parseInt(firstValue.substring(0, firstValue.indexOf('.'))));
			state1.setInt(2, Integer.parseInt(secondValue.substring(0, secondValue.indexOf('.'))));
			state1.setDouble(3, Double.parseDouble(priceTF.getText()));
			
			state1.execute();
			refreshTable2();
			refreshBuildingComboBox();
			refreshRoomTypeComboBox();
			clearForm2();
			
			}catch (SQLException e1) {
				e1.printStackTrace();
			}	
		}
	}
	
	class MouseAction2 implements MouseListener {

		@Override
		public void mouseClicked(MouseEvent e) {
			int row = table2.getSelectedRow();
			id = Integer.parseInt(table2.getValueAt(row, 0).toString());
			buildingNameComboBox.setSelectedItem(table2.getValueAt(row, 1).toString());
			roomTypeComboBox.setSelectedItem(table2.getValueAt(row, 2).toString());
			priceTF.setText(table2.getValueAt(row, 3).toString());

		}

		@Override
		public void mousePressed(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseReleased(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseEntered(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}

		@Override
		public void mouseExited(MouseEvent e) {
			// TODO Auto-generated method stub
			
		}
		
	}
	
	class EditAction2 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {	
			int row 	 = table2.getSelectedRow();
			String value = (table2.getModel().getValueAt(row, 0).toString());
			
			try {
				String sql = "update pricee set price=? where levels_id=" + value;
				state1 = conn.prepareStatement(sql);
				state1.setDouble(1, Double.parseDouble(priceTF.getText()));
			
				state1.executeUpdate();
				refreshTable2();
				refreshBuildingComboBox();
				refreshRoomTypeComboBox();
				clearForm2();
				
			  }catch(Exception e1) {
				e1.printStackTrace();
			}
		}
	}
	
	
	class DeleteAction2 implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "delete from pricee where levels_id=?";
			
			try {
				state1 = conn.prepareStatement(sql);
				state1.setInt(1, id);
				state1.execute();
				refreshTable2();
				clearForm2();
				id = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
	}

	
	class ShowAction implements ActionListener{

		@Override
		public void actionPerformed(ActionEvent e) {
			conn = DBConnection.getConnection();
			String sql = "SELECT name, type, address, size, price \r\n"
					+ "	FROM Pricee P \r\n"
					+ "	JOIN buildingbb B \r\n"
					+ "	ON P.BUILDING_NAME = B.BUILDING_ID \r\n"
					+ "	JOIN roomrr R \r\n"
					+ "	ON P.ROOM_TYPE = R.ROOM_ID \r\n"
					+ " WHERE name = ? AND type = ?";
			try {
				state = conn.prepareStatement(sql);
				state.setString(1, queryBuildingTF.getText());
				state.setString(2, queryTypeRoomTF.getText());
				result = state.executeQuery();
				table3.setModel(new MyModel(result));
			} catch (SQLException e1) {
				e1.printStackTrace();
			} catch (Exception e1) {
				e1.printStackTrace();
			}	
		}
	}
}