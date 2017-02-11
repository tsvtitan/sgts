unit SgtsKgesGraphsConsts;

interface

resourcestring

  SSeriesDefName='№%d';
  SChartFootTitleEmpty='%s. %s';
  SChartFootTitle='%s. %s. %s';

  SGraphTypeDefault='Стандартный график';
  SNeedParamsToLeftAxis='Необходимо выбрать параметры для левой оси Yл';
  SNeedParamsToBottomAxis='Необходимо выбрать параметры для нижней оси Yл';
  SNeedSelectPoints='Необходимо выбрать измерительные точки';

  SInterfaceGraphGmo='Графики по Гидрометеорологии. Результаты наблюдений';
  SInterfaceGraphPzmGmo='Графики по Пьезометрам. Результаты наблюдений';
  SInterfaceGraphFltGmo='Графики по Фильтрации. Результаты наблюдений';
  SInterfaceGraphHmzGmo='Графики по Химанализу. Результаты наблюдений';
  SInterfaceGraphHmzIntensity='Графики по Химанализу. Интенсивность выноса кальция';
  SInterfaceGraphTvlGmo='Графики по Влажности. Результаты наблюдений';

  SConfigParamPeriodType='PeriodType';
  SConfigParamPeriodChecked='PeriodChecked';
  SConfigParamDateBegin='DateBegin';
  SConfigParamDateEnd='DateEnd';
  SConfigParamCycleBegin='CycleBegin';
  SConfigParamCycleEnd='CycleEnd';
  SConfigParamLeftAxisParams='LeftAxisParams';
  SConfigParamRightAxisParams='RightAxisParams';
  SConfigParamBottomAxisParams='BottomAxisParams';
  SConfigParamGraphName='GraphName';
  SConfigParamPoints='Points';
  SConfigParamChartComponent='ChartComponent';
  SConfigParamHistories='Histories';

  SAllPeriod='за весь период';
  SFromDate='по дате: с %s';
  SToDate='по дате: с начала по %s';
  SFromToDate='по дате: с %s по %s';
  SFromCycle='по циклу: с %s';
  SToCycle='по циклу: с начала по %s';
  SFromToCycle='по циклу: с %s по %s';

  SHistoryAllPeriod='Предыстория за весь период';
  SHistoryFromDate='Предыстория по дате: с %s';
  SHistoryToDate='Предыстория по дате: с начала по %s';
  SHistoryFromToDate='Предыстория по дате: с %s по %s';
  SHistoryFromCycle='Предыстория по циклу: с %s';
  SHistoryToCycle='Предыстория по циклу: с начала по %s';
  SHistoryFromToCycle='Предыстория по циклу: с %s по %s';

  SCaptionAxisParam='Параметр';
  SParamNameNotEmpty='Наименование параметра не может быть пустым.';
  SInputAxisParam='Введите наименование параметра';

  SCaptionHistory='История';
  SInputCaptionHistory='Введите заголок истории';
  SHistoryCaptionNotEmpty='Заголовок истории не может быть пустым.';

  SCaptionPoint='Измерительная точка';
  SInputCaptionPoint='Введите заголовок точки';
  SPointCaptionNotEmpty='Заголовок точки не может быть пустым.';


implementation

end.
