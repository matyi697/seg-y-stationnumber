type
  TSegyHeader = packed record
    JobID: Integer;
    LineNumber: Integer;
    ReelNumber: Integer;
    TracesPerEnsemble: Word;
    AuxTracesPerEnsemble: Word;
    SampleInterval: Word;
    SampleIntervalOriginal: Word;
    NumSamples: Word;
    NumSamplesOriginal: Word;
    DataFormat: Word;
    CDPFold: Word;
    TraceSortingCode: Word;
    VerticalSumCode: Word;
    SweepFrequencyStart: Word;
    SweepFrequencyEnd: Word;
    SweepLength: Word;
    SweepTypeCode: Word;
    TraceHeaderNum: Word;
    SweepTraceNum: Word;
    SweepChannelNum: Word;
    SweepTaperLengthStart: Word;
    SweepTaperLengthEnd: Word;
    TaperType: Word;
    CorrelatedDataTraces: Word;
    BinaryGainRecovery: Word;
    AmplitudeRecoveryMethod: Word;
    MeasurementSystem: Word;
    ImpulseSignalPolarity: Word;
    VibratoryPolarityCode: Word;
    Unassigned1: array [1..114] of Byte;
  end;

procedure DisplayStationNumbers(const filename: string);
var
  fileHandle: file of Byte;
  header: TSegyHeader;
  trace: array of Integer;
  i, numTraces, stationNumber: Integer;
begin
  AssignFile(fileHandle, filename);
  Reset(fileHandle);
  
  // Read the header
  BlockRead(fileHandle, header, SizeOf(header));
  
  // Skip the binary header
  Seek(fileHandle, 3600);
  
  // Read the traces
  numTraces := header.TracesPerEnsemble;
  SetLength(trace, numTraces);
  for i := 0 to numTraces - 1 do begin
    BlockRead(fileHandle, trace[i], 4);
  end;
  
  // Display the station numbers
  for i := 0 to numTraces - 1 do begin
    stationNumber := trace[i] div 1000;
    WriteLn('Station number: ', stationNumber);
  end;
  
  CloseFile(fileHandle);
end;
