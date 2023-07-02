object Form1: TForm1
  Left = 0
  Top = 0
  Hint = #1057#1090#1080#1088#1072#1077#1090' '#1083#1086#1084#1072#1085#1091#1102' '#1083#1080#1085#1080#1102' '#1080' '#1088#1072#1083#1086#1078#1077#1085#1085#1099#1077' '#1083#1080#1089#1090#1099
  Caption = 'Form1'
  ClientHeight = 442
  ClientWidth = 771
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnPaint = FormPaint
  TextHeight = 15
  object Label2: TLabel
    Left = 381
    Top = 40
    Width = 79
    Height = 15
    Caption = #1064#1080#1088#1080#1085#1072' '#1083#1080#1089#1090#1072
  end
  object Label3: TLabel
    Left = 386
    Top = 69
    Width = 74
    Height = 15
    Caption = #1042#1099#1089#1086#1090#1072' '#1083#1080#1089#1090#1072
  end
  object Label4: TLabel
    Left = 608
    Top = 121
    Width = 139
    Height = 15
    Caption = #1057#1087#1080#1089#1086#1082' '#1082#1086#1086#1088#1076#1080#1085#1072#1090' '#1090#1086#1095#1077#1082':'
  end
  object EditSheetWidth: TEdit
    Left = 466
    Top = 37
    Width = 121
    Height = 23
    Hint = #1062#1077#1083#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1077' '#1073#1086#1083#1077#1077' 300'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object EditSheetHigh: TEdit
    Left = 466
    Top = 66
    Width = 121
    Height = 23
    Hint = #1062#1077#1083#1086#1077' '#1079#1085#1072#1095#1077#1085#1080#1077' '#1085#1077' '#1073#1086#1083#1077#1077' 300'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
  object Button1: TButton
    Left = 611
    Top = 8
    Width = 75
    Height = 25
    Hint = 
      #1055#1077#1088#1077#1082#1088#1099#1074#1072#1077#1090' '#1079#1072#1076#1072#1085#1085#1091#1102' '#1083#1080#1085#1080#1102' '#1091#1089#1083#1086#1074#1085#1086'-'#1084#1080#1085#1080#1084#1072#1083#1100#1085#1099#1084' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086#1084' '#1083#1080#1089#1090#1086 +
      #1074
    Caption = #1056#1072#1079#1083#1086#1078#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 611
    Top = 38
    Width = 75
    Height = 25
    Caption = #1054#1095#1080#1089#1090#1080#1090#1100
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 611
    Top = 69
    Width = 75
    Height = 25
    Hint = #1059#1076#1072#1083#1103#1077#1090' '#1088#1072#1089#1082#1083#1072#1076#1082#1091' '#1083#1080#1089#1090#1086#1074
    Caption = #1059#1076'. '#1083#1080#1089#1090#1099
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    OnClick = Button3Click
  end
  object MemoDots: TMemo
    Left = 608
    Top = 145
    Width = 137
    Height = 289
    Hint = 
      #1042#1074#1077#1076#1080#1090#1077' '#1090#1086#1095#1082#1080' '#1074' '#1092#1086#1088#1084#1072#1090#1077' X; Y, '#1091#1082#1072#1079#1072#1074' '#1085#1072' '#1082#1072#1078#1076#1086#1081' '#1089#1090#1088#1086#1095#1082#1077' '#1072#1073#1089#1094#1080#1089#1089#1091' ' +
      #1080' '#1086#1088#1076#1080#1085#1072#1090#1099' ('#1074#1077#1083#1080#1095#1080#1085#1072' '#1082#1072#1078#1076#1086#1075#1086' '#1085#1077' '#1073#1086#1083#1077#1077' 300)  '#1095#1077#1088#1077#1079' '#1090#1086#1095#1082#1091' '#1089' '#1079#1072#1087#1103#1090#1086 +
      #1081' '
    Lines.Strings = (
      '')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object Button4: TButton
    Left = 692
    Top = 8
    Width = 75
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 692
    Top = 39
    Width = 75
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 7
    OnClick = Button5Click
  end
end
