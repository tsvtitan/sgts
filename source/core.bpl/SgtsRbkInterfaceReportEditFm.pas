unit SgtsRbkInterfaceReportEditFm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ImgList, Menus, ExtCtrls, StdCtrls,
  SgtsDataEditFm, SgtsDataInsertFm, SgtsDataUpdateFm, SgtsDataDelete,
  SgtsFm, SgtsControls,
  SgtsCoreIntf;

type
  TSgtsRbkInterfaceReportEditForm = class(TSgtsDataEditForm)
    LabelInterface: TLabel;
    LabelBaseReport: TLabel;
    EditBaseReport: TEdit;
    ButtonBaseReport: TButton;
    ComboBoxInterface: TComboBox;
    LabelPriority: TLabel;
    EditPriority: TEdit;
  private
    { Private declarations }
  public
    constructor Create(ACoreIntf: ISgtsCore); override;
  end;

  TSgtsRbkInterfaceReportInsertIface=class(TSgtsDataInsertIface)
  public
    procedure Init; override;
    procedure Insert; override;
  end;

  TSgtsRbkInterfaceReportUpdateIface=class(TSgtsDataUpdateIface)
  public
    procedure Init; override;
    procedure Update; override;
  end;

  TSgtsRbkInterfaceReportDeleteIface=class(TSgtsDataDeleteIface)
  public
    procedure Init; override;
    procedure Delete; override;
  end;
  
var
  SgtsRbkInterfaceReportEditForm: TSgtsRbkInterfaceReportEditForm;

implementation

uses DBClient,
     SgtsIface, SgtsConsts, SgtsProviderConsts,
     SgtsDatabaseCDS, SgtsDialogs, SgtsExecuteDefs,
     SgtsRbkBaseReportsFm, SgtsDataFm, SgtsFunSourceDataFm,
     SgtsCoreObj, SgtsGraphChartFm;

{$R *.dfm}

{ TSgtsRbkInterfaceReportInsertIface }

procedure TSgtsRbkInterfaceReportInsertIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInterfaceReportEditForm;
  InterfaceName:=SInterfaceInterfaceReportInsert;
  with DataSet do begin
    ProviderName:=SProviderInsertInterfaceReport;
    with ExecuteDefs do begin
      AddKey('INTERFACE_REPORT_ID');
      AddEditLink('BASE_REPORT_ID','EditBaseReport','LabelBaseReport','ButtonBaseReport',
                  TSgtsRbkBaseReportsIface,'BASE_REPORT_NAME','NAME','',true);
      AddCombo('INTERFACE','ComboBoxInterface','LabelInterface',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);                  
    end;
  end;
end;

procedure TSgtsRbkInterfaceReportInsertIface.Insert;
begin
  inherited Insert;
  CoreIntf.RefreshReports;
end;

{ TSgtsRbkInterfaceReportUpdateIface }

procedure TSgtsRbkInterfaceReportUpdateIface.Init;
begin
  inherited Init;
  FormClass:=TSgtsRbkInterfaceReportEditForm;
  InterfaceName:=SInterfaceInterfaceReportUpdate;
  with DataSet do begin
    ProviderName:=SProviderUpdateInterfaceReport;
    with ExecuteDefs do begin
      AddKeyLink('INTERFACE_REPORT_ID');
      AddEditLink('BASE_REPORT_ID','EditBaseReport','LabelBaseReport','ButtonBaseReport',
                  TSgtsRbkBaseReportsIface,'BASE_REPORT_NAME','NAME','',true);
      AddCombo('INTERFACE','ComboBoxInterface','LabelInterface',true);
      AddEditInteger('PRIORITY','EditPriority','LabelPriority',true);
    end;
  end;
end;

procedure TSgtsRbkInterfaceReportUpdateIface.Update;
begin
  inherited Update;
  CoreIntf.RefreshReports;
end;

{ TSgtsRbkInterfaceReportDeleteIface }

procedure TSgtsRbkInterfaceReportDeleteIface.Init;
begin
  inherited Init;
  InterfaceName:=SInterfaceInterfaceReportDelete;
  DeleteQuestion:='Удалить отчет: %BASE_REPORT_NAME у интерфейса: %INTERFACE?';
  with DataSet do begin
    ProviderName:=SProviderDeleteInterfaceReport;
    with ExecuteDefs do begin
      AddKeyLink('INTERFACE_REPORT_ID');
      AddInvisible('BASE_REPORT_NAME');
      AddInvisible('INTERFACE');
    end;
  end;
end;

procedure TSgtsRbkInterfaceReportDeleteIface.Delete; 
begin
  inherited Delete;
  CoreIntf.RefreshReports;
end;

{ TSgtsRbkInterfaceReportEditForm }

constructor TSgtsRbkInterfaceReportEditForm.Create(ACoreIntf: ISgtsCore);
begin
  inherited Create(ACoreIntf);
  with ACoreIntf do begin
    GetInterfaceNames(ComboBoxInterface.Items,TSgtsDataIface);
    GetInterfaceNames(ComboBoxInterface.Items,TSgtsFunSourceDataIface);
    GetInterfaceNames(ComboBoxInterface.Items,TSgtsGraphChartIface);
  end;   
end;

end.
