<?xml version="1.0" encoding="utf-16" standalone="yes"?>
<!--
SQL Data Compare
SQL Data Compare
Version:12.0.30.3199-->
<Project version="3" type="SQLComparisonToolsProject">
  <DataSource1 version="3" type="LiveDatabaseSource">
    <ServerName>ROBOT01</ServerName>
    <DatabaseName>BMSTenant</DatabaseName>
    <Username>sa</Username>
    <SavePassword>True</SavePassword>
    <Password encrypted="1">JyGCF/yNVMU=</Password>
    <ScriptFolderLocation />
    <MigrationsFolderLocation />
    <IntegratedSecurity>False</IntegratedSecurity>
  </DataSource1>
  <DataSource2 version="3" type="LiveDatabaseSource">
    <ServerName>ROBOT01</ServerName>
    <DatabaseName>BMSTenantModel</DatabaseName>
    <Username>sa</Username>
    <SavePassword>True</SavePassword>
    <Password encrypted="1">JyGCF/yNVMU=</Password>
    <ScriptFolderLocation />
    <MigrationsFolderLocation />
    <IntegratedSecurity>False</IntegratedSecurity>
  </DataSource2>
  <LastCompared>11/06/2016 22:20:02</LastCompared>
  <Options>Default</Options>
  <InRecycleBin>False</InRecycleBin>
  <Direction>0</Direction>
  <ProjectFilter version="1" type="DifferenceFilter">
    <FilterCaseSensitive>False</FilterCaseSensitive>
    <Filters version="1">
      <None version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </None>
      <Assembly version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Assembly>
      <AsymmetricKey version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </AsymmetricKey>
      <Certificate version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Certificate>
      <Contract version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Contract>
      <DdlTrigger version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </DdlTrigger>
      <Default version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Default>
      <ExtendedProperty version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </ExtendedProperty>
      <EventNotification version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </EventNotification>
      <FullTextCatalog version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </FullTextCatalog>
      <FullTextStoplist version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </FullTextStoplist>
      <Function version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Function>
      <MessageType version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </MessageType>
      <PartitionFunction version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </PartitionFunction>
      <PartitionScheme version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </PartitionScheme>
      <Queue version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Queue>
      <Role version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Role>
      <Route version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Route>
      <Rule version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Rule>
      <Schema version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Schema>
      <SearchPropertyList version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </SearchPropertyList>
      <SecurityPolicy version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </SecurityPolicy>
      <Sequence version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Sequence>
      <Service version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Service>
      <ServiceBinding version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </ServiceBinding>
      <StoredProcedure version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </StoredProcedure>
      <SymmetricKey version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </SymmetricKey>
      <Synonym version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Synonym>
      <Table version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </Table>
      <User version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </User>
      <UserDefinedType version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </UserDefinedType>
      <View version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </View>
      <XmlSchemaCollection version="1">
        <Include>True</Include>
        <Expression>TRUE</Expression>
      </XmlSchemaCollection>
    </Filters>
  </ProjectFilter>
  <ProjectFilterName />
  <UserNote />
  <SelectedSyncObjects version="1" type="SelectedSyncObjects">
    <Schemas type="ListString" version="2" />
    <Grouping type="ListByte" version="2">
      <value type="Byte">0</value>
      <value type="Byte">0</value>
      <value type="Byte">0</value>
      <value type="Byte">0</value>
      <value type="Byte">0</value>
    </Grouping>
    <SelectAll>False</SelectAll>
  </SelectedSyncObjects>
  <SCGroupingStyle>0</SCGroupingStyle>
  <SQLOptions>10</SQLOptions>
  <MappingOptions>82</MappingOptions>
  <ComparisonOptions>0</ComparisonOptions>
  <TableActions type="ArrayList" version="1">
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[dbo].[Areas]:[dbo].[Areas]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[dbo].[Customer]:[dbo].[Customer]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[dbo].[DataChangeLog]:[dbo].[DataChangeLog]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[dbo].[Vehicle]:[dbo].[Vehicle]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Bill].[BillHeader]:[Bill].[BillHeader]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Bill].[BillLine]:[Bill].[BillLine]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Bill].[RoadDistribution]:[Bill].[RoadDistribution]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Item].[Brand]:[Item].[Brand]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Item].[Category]:[Item].[Category]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Item].[Item]:[Item].[Item]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Item].[Product]:[Item].[Product]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Payment].[BillPayment]:[Payment].[BillPayment]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Payment].[BillPaymentCheque]:[Payment].[BillPaymentCheque]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Payment].[Cheque]:[Payment].[Cheque]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Store].[InvoiceHeader]:[Store].[InvoiceHeader]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Store].[InvoiceLine]:[Store].[InvoiceLine]</val>
    </value>
    <value version="1" type="SelectTableEvent">
      <action>DeselectItem</action>
      <val>[Store].[Lot]:[Store].[Lot]</val>
    </value>
  </TableActions>
  <SessionSettings>15</SessionSettings>
  <DCGroupingStyle>0</DCGroupingStyle>
  <SC_DeploymentOptions version="1" type="SC_DeploymentOptions">
    <BackupOptions version="1" type="BackupOptions">
      <BackupProvider>Native</BackupProvider>
      <TypeOfBackup>Full</TypeOfBackup>
      <Folder />
      <Filename />
      <SqbLicenseType>None</SqbLicenseType>
      <SqbVersion>0</SqbVersion>
      <DefaultNativeFolder />
      <DefaultSqbFolder />
      <Password encrypted="1" />
      <NameFileAutomatically>False</NameFileAutomatically>
      <OverwriteIfExists>False</OverwriteIfExists>
      <CompressionLevel>0</CompressionLevel>
      <EncryptionLevel>None</EncryptionLevel>
      <ThreadCount>0</ThreadCount>
      <BackupEnabled>False</BackupEnabled>
    </BackupOptions>
  </SC_DeploymentOptions>
</Project>