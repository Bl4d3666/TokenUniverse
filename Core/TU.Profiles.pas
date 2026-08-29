unit TU.Profiles;

{ This module provides UI handling for loading and unloading user profiles. }

interface

uses
  Ntapi.WinNt, Ntapi.ntseapi, TU.Tokens;

// Load a user profile for token
[RequiredPrivilege(SE_BACKUP_PRIVILEGE, rpAlways)]
[RequiredPrivilege(SE_RESTORE_PRIVILEGE, rpAlways)]
procedure TuUiLoadProfile(
  OwnerWindow: THwnd;
  Token: IToken
);

// Unload a user profile for token
[RequiredPrivilege(SE_BACKUP_PRIVILEGE, rpAlways)]
[RequiredPrivilege(SE_RESTORE_PRIVILEGE, rpAlways)]
procedure TuUiUnloadProfile(
  OwnerWindow: THwnd;
  Token: IToken
);

implementation

uses
  Ntapi.ntregapi, NtUtils, NtUtils.Security.Sid,
  NtUtils.Registry, NtUtils.Profiles, TU.Suggestions, DelphiUiLib.Strings;

procedure TuUiLoadProfile;
var
  hxKey: IHandle;
begin
  UnvxLoadProfile(hxKey, Token.Handle).RaiseOnError;
  ShowSuccessMessage(OwnerWindow, 'User profile successfully loaded.');
end;

procedure TuUiUnloadProfile;
var
  User: TGroup;
  SidString, ConfirmationMessage: String;
  OpenedKeys: Cardinal;
begin
  ConfirmationMessage := 'Are you sure you want to unload the user profile ' +
    'for the token?';

  if Token.QueryUser(User).IsSuccess and
    RtlxSidToString(User.Sid, SidString).IsSuccess and
    NtxQueryOpenSubKeys(OpenedKeys, REG_PATH_USER + '\' +
    SidString).IsSuccess then
    ConfirmationMessage := ConfirmationMessage +
      #$D#$A#$D#$A'Currently opened keys: ' + UiLibUIntToDec(OpenedKeys);

  if not AskForConfirmation(OwnerWindow, ConfirmationMessage) then
    Exit;

  UnvxUnloadProfile(Token.Handle).RaiseOnError;
  ShowSuccessMessage(OwnerWindow, 'User profile successfully unloaded.');
end;

end.
