object ServicoResultadoVenda: TServicoResultadoVenda
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  Dependencies = <
    item
      Name = 'postgresql-x64-12'
      IsGroup = False
    end>
  DisplayName = 'ServicoResultadoVenda'
  OnExecute = ServiceExecute
  Height = 337
  Width = 524
  object Timer1: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = Timer1Timer
    Left = 128
    Top = 96
  end
end
