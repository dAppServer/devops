FROM lthn/build:lthn-chain-linux

RUN apt-get install -y qtbase5-dev qt5-default qtdeclarative5-dev qml-module-qtquick-controls \
                       qml-module-qtquick-xmllistmodel qttools5-dev-tools qml-module-qtquick-dialogs \
                       qml-module-qt-labs-settings libqt5qml-graphicaleffects qtmultimedia5-dev \
                       qml-module-qtmultimedia libzbar-dev


#RUN git clone https://gitlab.com/lthn.io/projects/chain/lethean.git && cd lethean && make release-static