classdef imageprocessing < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        IMAGEPROCESSINGUIFigure      matlab.ui.Figure
        UIAxes2                      matlab.ui.control.UIAxes
        UIAxes                       matlab.ui.control.UIAxes
        GRAYSCALEButton              matlab.ui.control.Button
        INVERTButton                 matlab.ui.control.Button
        BINARYButton                 matlab.ui.control.Button
        SKELETONButton               matlab.ui.control.Button
        SMOOTHENINGButton            matlab.ui.control.Button
        POWERLAWButton               matlab.ui.control.Button
        HISTOGRAMEQUALIZATIONButton  matlab.ui.control.Button
        SHARPENINGButton             matlab.ui.control.Button
        GREENButton                  matlab.ui.control.Button
        REDButton                    matlab.ui.control.Button
        IMAGEPROCESSINGLabel         matlab.ui.control.Label
        UPLOADButton                 matlab.ui.control.Button
        SAVEButton                   matlab.ui.control.Button
        EDGEButton                   matlab.ui.control.Button
        BLUEButton                   matlab.ui.control.Button
        RESETButton                  matlab.ui.control.Button
        HISTOGRAMButton              matlab.ui.control.Button
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: UPLOADButton
        function UPLOADButtonPushed(app, event)
           global a;
           [filename,filepath] = uigetfile({'*.*;*.jpg;*.png'});
           filename = strcat(filepath, filename);
           a = imread(filename);
           imshow(a,'Parent',app.UIAxes);
        end

        % Button pushed function: GRAYSCALEButton
        function GRAYSCALEButtonPushed(app, event)
            global a;
            b=rgb2gray(a);
            imshow(b,'Parent',app.UIAxes2);
        end

        % Button pushed function: INVERTButton
        function INVERTButtonPushed(app, event)
            global a;
            c=255-a;
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: BINARYButton
        function BINARYButtonPushed(app, event)
            global a;
            c=im2bw(a);
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: EDGEButton
        function EDGEButtonPushed(app, event)
            global a;
            b=rgb2gray(a);
            c=edge(b,"roberts");
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: SKELETONButton
        function SKELETONButtonPushed(app, event)
            global a;
            b=im2bw(a);
            c=bwmorph(b,"Skel",Inf);
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: SHARPENINGButton
        function SHARPENINGButtonPushed(app, event)
            global a;
            c=imsharpen(a);
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: SMOOTHENINGButton
        function SMOOTHENINGButtonPushed(app, event)
            global a;
            h=fspecial("gaussian");
            c=imfilter(a,h);
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: POWERLAWButton
        function POWERLAWButtonPushed(app, event)
            global a;
            gamma= 1.35;
            c=double(a).^gamma
            imshow(uint8(c),'Parent',app.UIAxes2);
        end

        % Button pushed function: HISTOGRAMEQUALIZATIONButton
        function HISTOGRAMEQUALIZATIONButtonPushed(app, event)
            global a;
            c=histeq(a);
            imshow(c,'Parent',app.UIAxes2);
        end

        % Button pushed function: REDButton
        function REDButtonPushed(app, event)
            global a;
            [r c d]=size(a);
            z=zeros(r,c);
            tempr=a;
            tempr(:,:,2)=z;
            tempr(:,:,3)=z;
            imshow(tempr,'Parent',app.UIAxes2);
        end

        % Button pushed function: GREENButton
        function GREENButtonPushed(app, event)
            global a;
            [r c d]=size(a);
            z=zeros(r,c);
            tempg=a;
            tempg(:,:,1)=z;
            tempg(:,:,3)=z;
            imshow(tempg,'Parent',app.UIAxes2);
        end

        % Button pushed function: BLUEButton
        function BLUEButtonPushed(app, event)
            global a;
            [r c d]=size(a);
            z=zeros(r,c);
            tempb=a;
            tempb(:,:,1)=z;
            tempb(:,:,2)=z;
            imshow(tempb,'Parent',app.UIAxes2);
        end

        % Button pushed function: SAVEButton
        function SAVEButtonPushed(app, event)
            filter = {'*.jpg';'*.png'}
            [filename, pathname] = uiputfile(filter);
            newfilename = fullfile(pathname, filename);
            saveas(fig2Save, newfilename);
        end

        % Button pushed function: RESETButton
        function RESETButtonPushed(app, event)
            cla(app.UIAxes,"reset");
            cla(app.UIAxes2,"reset");
        end

        % Button pushed function: HISTOGRAMButton
        function HISTOGRAMButtonPushed(app, event)
            global a;
            b=im2double(a);
            imhist(b);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create IMAGEPROCESSINGUIFigure and hide until all components are created
            app.IMAGEPROCESSINGUIFigure = uifigure('Visible', 'off');
            app.IMAGEPROCESSINGUIFigure.Color = [1 1 1];
            app.IMAGEPROCESSINGUIFigure.Position = [100 100 1080 660];
            app.IMAGEPROCESSINGUIFigure.Name = 'IMAGE PROCESSING';

            % Create HISTOGRAMButton
            app.HISTOGRAMButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.HISTOGRAMButton.ButtonPushedFcn = createCallbackFcn(app, @HISTOGRAMButtonPushed, true);
            app.HISTOGRAMButton.BackgroundColor = [1 1 1];
            app.HISTOGRAMButton.FontWeight = 'bold';
            app.HISTOGRAMButton.Position = [972 9 100 90];
            app.HISTOGRAMButton.Text = 'HISTOGRAM';

            % Create RESETButton
            app.RESETButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.RESETButton.ButtonPushedFcn = createCallbackFcn(app, @RESETButtonPushed, true);
            app.RESETButton.BackgroundColor = [0.302 0.7451 0.9333];
            app.RESETButton.FontWeight = 'bold';
            app.RESETButton.Position = [12 560 100 41];
            app.RESETButton.Text = 'RESET';

            % Create BLUEButton
            app.BLUEButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.BLUEButton.ButtonPushedFcn = createCallbackFcn(app, @BLUEButtonPushed, true);
            app.BLUEButton.BackgroundColor = [0 0 1];
            app.BLUEButton.FontWeight = 'bold';
            app.BLUEButton.FontColor = [1 1 1];
            app.BLUEButton.Position = [621 11 100 90];
            app.BLUEButton.Text = 'BLUE';

            % Create EDGEButton
            app.EDGEButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.EDGEButton.ButtonPushedFcn = createCallbackFcn(app, @EDGEButtonPushed, true);
            app.EDGEButton.BackgroundColor = [0.502 0.502 0.502];
            app.EDGEButton.FontWeight = 'bold';
            app.EDGEButton.Position = [11 339 100 90];
            app.EDGEButton.Text = 'EDGE';

            % Create SAVEButton
            app.SAVEButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.SAVEButton.ButtonPushedFcn = createCallbackFcn(app, @SAVEButtonPushed, true);
            app.SAVEButton.BackgroundColor = [1 1 0];
            app.SAVEButton.FontWeight = 'bold';
            app.SAVEButton.Position = [972 557 100 41];
            app.SAVEButton.Text = 'SAVE';

            % Create UPLOADButton
            app.UPLOADButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.UPLOADButton.ButtonPushedFcn = createCallbackFcn(app, @UPLOADButtonPushed, true);
            app.UPLOADButton.IconAlignment = 'center';
            app.UPLOADButton.BackgroundColor = [0.4667 0.6745 0.1882];
            app.UPLOADButton.FontWeight = 'bold';
            app.UPLOADButton.FontColor = [1 1 1];
            app.UPLOADButton.Position = [490 560 100 41];
            app.UPLOADButton.Text = 'UPLOAD';

            % Create IMAGEPROCESSINGLabel
            app.IMAGEPROCESSINGLabel = uilabel(app.IMAGEPROCESSINGUIFigure);
            app.IMAGEPROCESSINGLabel.BackgroundColor = [0.4941 0.1843 0.5569];
            app.IMAGEPROCESSINGLabel.HorizontalAlignment = 'center';
            app.IMAGEPROCESSINGLabel.FontWeight = 'bold';
            app.IMAGEPROCESSINGLabel.FontColor = [1 1 1];
            app.IMAGEPROCESSINGLabel.Position = [11 617 1060 34];
            app.IMAGEPROCESSINGLabel.Text = 'IMAGE PROCESSING';

            % Create REDButton
            app.REDButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.REDButton.ButtonPushedFcn = createCallbackFcn(app, @REDButtonPushed, true);
            app.REDButton.BackgroundColor = [1 0 0];
            app.REDButton.FontWeight = 'bold';
            app.REDButton.FontColor = [1 1 1];
            app.REDButton.Position = [360 11 100 90];
            app.REDButton.Text = 'RED ';

            % Create GREENButton
            app.GREENButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.GREENButton.ButtonPushedFcn = createCallbackFcn(app, @GREENButtonPushed, true);
            app.GREENButton.BackgroundColor = [0.3922 0.8314 0.0745];
            app.GREENButton.FontWeight = 'bold';
            app.GREENButton.FontColor = [1 1 1];
            app.GREENButton.Position = [490 11 100 90];
            app.GREENButton.Text = 'GREEN';

            % Create SHARPENINGButton
            app.SHARPENINGButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.SHARPENINGButton.ButtonPushedFcn = createCallbackFcn(app, @SHARPENINGButtonPushed, true);
            app.SHARPENINGButton.BackgroundColor = [0.4941 0.1843 0.5569];
            app.SHARPENINGButton.FontWeight = 'bold';
            app.SHARPENINGButton.FontColor = [1 1 1];
            app.SHARPENINGButton.Position = [972 449 100 90];
            app.SHARPENINGButton.Text = 'SHARPENING';

            % Create HISTOGRAMEQUALIZATIONButton
            app.HISTOGRAMEQUALIZATIONButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.HISTOGRAMEQUALIZATIONButton.ButtonPushedFcn = createCallbackFcn(app, @HISTOGRAMEQUALIZATIONButtonPushed, true);
            app.HISTOGRAMEQUALIZATIONButton.BackgroundColor = [0.9373 0.6902 1];
            app.HISTOGRAMEQUALIZATIONButton.FontWeight = 'bold';
            app.HISTOGRAMEQUALIZATIONButton.FontColor = [1 1 1];
            app.HISTOGRAMEQUALIZATIONButton.Position = [972 119 100 90];
            app.HISTOGRAMEQUALIZATIONButton.Text = {'HISTOGRAM'; 'EQUALIZATION'};

            % Create POWERLAWButton
            app.POWERLAWButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.POWERLAWButton.ButtonPushedFcn = createCallbackFcn(app, @POWERLAWButtonPushed, true);
            app.POWERLAWButton.BackgroundColor = [0.8784 0.3882 1];
            app.POWERLAWButton.FontWeight = 'bold';
            app.POWERLAWButton.FontColor = [1 1 1];
            app.POWERLAWButton.Position = [972 229 100 90];
            app.POWERLAWButton.Text = 'POWER LAW';

            % Create SMOOTHENINGButton
            app.SMOOTHENINGButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.SMOOTHENINGButton.ButtonPushedFcn = createCallbackFcn(app, @SMOOTHENINGButtonPushed, true);
            app.SMOOTHENINGButton.BackgroundColor = [0.7255 0.3059 0.8314];
            app.SMOOTHENINGButton.FontWeight = 'bold';
            app.SMOOTHENINGButton.FontColor = [1 1 1];
            app.SMOOTHENINGButton.Position = [972 339 100 90];
            app.SMOOTHENINGButton.Text = 'SMOOTHENING';

            % Create SKELETONButton
            app.SKELETONButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.SKELETONButton.ButtonPushedFcn = createCallbackFcn(app, @SKELETONButtonPushed, true);
            app.SKELETONButton.BackgroundColor = [0.8 0.8 0.8];
            app.SKELETONButton.FontWeight = 'bold';
            app.SKELETONButton.Position = [11 119 100 90];
            app.SKELETONButton.Text = 'SKELETON';

            % Create BINARYButton
            app.BINARYButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.BINARYButton.ButtonPushedFcn = createCallbackFcn(app, @BINARYButtonPushed, true);
            app.BINARYButton.BackgroundColor = [0.9412 0.9412 0.9412];
            app.BINARYButton.FontWeight = 'bold';
            app.BINARYButton.Position = [11 9 100 90];
            app.BINARYButton.Text = 'BINARY';

            % Create INVERTButton
            app.INVERTButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.INVERTButton.ButtonPushedFcn = createCallbackFcn(app, @INVERTButtonPushed, true);
            app.INVERTButton.BackgroundColor = [0.651 0.651 0.651];
            app.INVERTButton.FontWeight = 'bold';
            app.INVERTButton.Position = [11 229 100 90];
            app.INVERTButton.Text = 'INVERT';

            % Create GRAYSCALEButton
            app.GRAYSCALEButton = uibutton(app.IMAGEPROCESSINGUIFigure, 'push');
            app.GRAYSCALEButton.ButtonPushedFcn = createCallbackFcn(app, @GRAYSCALEButtonPushed, true);
            app.GRAYSCALEButton.BackgroundColor = [0 0 0];
            app.GRAYSCALEButton.FontWeight = 'bold';
            app.GRAYSCALEButton.FontColor = [1 1 1];
            app.GRAYSCALEButton.Position = [11 449 100 90];
            app.GRAYSCALEButton.Text = 'GRAYSCALE';

            % Create UIAxes
            app.UIAxes = uiaxes(app.IMAGEPROCESSINGUIFigure);
            title(app.UIAxes, 'INPUT')
            app.UIAxes.GridLineStyle = 'none';
            app.UIAxes.XColor = 'none';
            app.UIAxes.XTick = [];
            app.UIAxes.YColor = 'none';
            app.UIAxes.YTick = [];
            app.UIAxes.YTickLabel = '';
            app.UIAxes.ZColor = 'none';
            app.UIAxes.BoxStyle = 'full';
            app.UIAxes.Color = 'none';
            app.UIAxes.Box = 'on';
            app.UIAxes.Position = [122 109 410 429];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.IMAGEPROCESSINGUIFigure);
            title(app.UIAxes2, 'OUTPUT')
            app.UIAxes2.FontWeight = 'bold';
            app.UIAxes2.XColor = 'none';
            app.UIAxes2.XTick = [];
            app.UIAxes2.YColor = 'none';
            app.UIAxes2.YTick = [];
            app.UIAxes2.ZColor = 'none';
            app.UIAxes2.Color = 'none';
            app.UIAxes2.Position = [542 109 420 429];

            % Show the figure after all components are created
            app.IMAGEPROCESSINGUIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = imageprocessing

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.IMAGEPROCESSINGUIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.IMAGEPROCESSINGUIFigure)
        end
    end
end