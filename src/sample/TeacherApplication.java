package sample;

import javafx.application.Application;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.layout.*;
import javafx.scene.text.Text;
import javafx.stage.Stage;


import java.util.List;

public class TeacherApplication extends Application {

    private ListView<Teacher> listView;
    private ObservableList<Teacher> data;

    private ListView<Class> ListView;
    private ObservableList<Class> Data;

    private Text txtIdData;
    private Text txtNameData;
    private Text txtSurnameData;
    private Text txtEmailData;

    private TeacherDB DBaccess;

    public static void main(String[] args) {
        Application.launch(args);
    }

    @Override
    public void init() {

        try {
            DBaccess = new TeacherDB();
        }
        catch (Exception e) {

            displayException(e);
        }
    }

    @Override
    public void stop() {

        try {
            DBaccess.closeDB();
        }
        catch (Exception e) {

            displayException(e);
        }
    }

    @Override
    public void start(Stage primaryStage) {

        BorderPane root = new BorderPane();
        Label lblAppName = new Label("TeacherApp v0.1, 2020.1");
        Label lblID = new Label("ID:");
        Label lblName = new Label("First Name:");
        Label lblSurname = new Label("Surname:");
        Label lblEmail = new Label("Email Address:");
        Label teachers = new Label("Teachers:");
        Label chosenClasses = new Label("Teaches Following Classes:");
        Label thisTeacher = new Label("Current Teacher:");
        txtIdData = new Text();
        txtNameData = new Text();
        txtSurnameData = new Text();
        txtEmailData = new Text();

        HBox idData = new HBox(lblID, txtIdData);
        HBox surnameData = new HBox(lblSurname, txtSurnameData);
        HBox nameData = new HBox(lblName, txtNameData);
        HBox emailData = new HBox(lblEmail, txtEmailData);

        idData.setSpacing(10);
        nameData.setSpacing(10);
        surnameData.setSpacing(10);
        emailData.setSpacing(10);

        HBox hBoxLblTop = new HBox(lblAppName);

        VBox vBoxData = new VBox(thisTeacher, idData, nameData, surnameData, emailData);
        vBoxData.setSpacing(20);
        vBoxData.setAlignment(Pos.BASELINE_CENTER);
        vBoxData.setPadding(new Insets(10,0,0,10));

        VBox vBoxListView = new VBox();

        VBox vBoxListView2 = new VBox();


        root.setCenter(vBoxData);

        // View

        listView = new ListView<>();

        listView.getSelectionModel().selectedIndexProperty().addListener(
                new ListSelectChangeListener());
        data = getDBData();
        listView.setItems(data);

        vBoxListView.getChildren().addAll(teachers, listView);

        ListView = new ListView<>();

        vBoxListView2.getChildren().addAll(chosenClasses,ListView);

        root.setLeft(vBoxListView);
        root.setRight(vBoxListView2);

        hBoxLblTop.setAlignment(Pos.TOP_CENTER);
        root.setTop(hBoxLblTop);


        Scene scene = new Scene(root, 800, 400);

        primaryStage.setTitle("TeacherApp v0.1, 2020.1");
        primaryStage.setScene(scene);
        primaryStage.show();

    }

    private class ListSelectChangeListener implements ChangeListener<Number> {

        @Override
        public void changed(ObservableValue<? extends Number> ov,
                            Number old_val, Number new_val) {

            if ((new_val.intValue() < 0) || (new_val.intValue() >= data.size())) {

                return;
            }

            // show data for selected teacher

            Teacher teacher = data.get(new_val.intValue());
            txtIdData.setText(Integer.toString(teacher.getTeacherID()));
            txtNameData.setText(teacher.getTeacherName());
            txtSurnameData.setText(teacher.getTeacherSurname());
            txtEmailData.setText(teacher.getTeacherEmail());

            Data = GetDBData(Integer.valueOf(txtIdData.getText()));

            ListView.setItems(Data);

        }
    }

    private ObservableList<Teacher> getDBData() {

        List<Teacher> list = null;

        try {
            list = DBaccess.getAllRows();
        }
        catch (Exception e) {

            displayException(e);
        }

        ObservableList<Teacher> dbData = FXCollections.observableList(list);
        return dbData;
    }

    private ObservableList<Class> GetDBData(int i) {

        List<Class> List = null;

        try {
            List = DBaccess.GetAllRows(i);
        }
        catch (Exception e) {

            displayException(e);
        }

        ObservableList<Class> dbData = FXCollections.observableList(List);
        return dbData;
    }

    private void displayException(Exception e) {

        System.out.println("###### Exception ######");
        e.printStackTrace();
        System.exit(0);
    }
}
