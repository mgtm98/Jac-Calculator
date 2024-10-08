import:py sys;
import:py from PyQt5.QtWidgets { QApplication, QMainWindow, QVBoxLayout, QGridLayout, QPushButton, QLineEdit, QWidget }
import:py from PyQt5.QtCore { Qt }

can create_window() -> QMainWindow {
    window = QMainWindow();
    window.setWindowTitle('JacQt Calculator');
    window.setGeometry(100, 100, 300, 350);
    centralWidget = QWidget(window);
    window.setCentralWidget(centralWidget);
    layout = QVBoxLayout(centralWidget);
    display = QLineEdit();
    display.setReadOnly(True);
    display.setFixedHeight(50);
    display.setAlignment(Qt.AlignmentFlag.AlignRight);
    display.setStyleSheet('font-size: 20px;');
    layout.addWidget(display);
    buttonsLayout = QGridLayout();
    layout.addLayout(buttonsLayout);
    create_buttons(buttonsLayout, display);
    return window;
}

can create_buttons(buttonsLayout: Any, display: Any) {
    buttons = {
        '7': (0, 0),
        '8': (0, 1),
        '9': (0, 2),
        '/': (0, 3),
        '4': (1, 0),
        '5': (1, 1),
        '6': (1, 2),
        '*': (1, 3),
        '1': (2, 0),
        '2': (2, 1),
        '3': (2, 2),
        '-': (2, 3),
        '0': (3, 0),
        '.': (3, 1),
        '=': (3, 2),
        '+': (3, 3),
        'C': (4, 0, 1, 2)
    };
    
    for (btnText, pos) in buttons.items() {
        button = QPushButton(btnText);
        button.setFixedSize(60, 60);
        button.clicked.connect(
            with checked: Any, b: Any=btnText can on_button_click(b, display)
        );
        if btnText == 'C' {
            buttonsLayout.addWidget(button, *pos);
        } else {
            buttonsLayout.addWidget(button, *pos);
        }
    }
}

can on_button_click(btnText: Any, display: Any) {
    if btnText == 'C' {
        display.clear();
    } elif btnText == '=' {
        
        try  {
            expression = display.text();
            result = str(eval(expression));
            display.setText(result);
        } except Exception as e {
            display.setText('Error');
        }
    } else {
        display.setText((display.text() + btnText));
    }
}

with entry {
    if __name__ == '__main__' {
        app = QApplication(sys.argv);
        window = create_window();
        window.show();
        sys.exit(app.exec_());
    }
}

