unit Ntapi.ntstatus;

interface

uses
  Ntapi.ntdef;

const
  STATUS_SUCCESS: NTSTATUS = $00000000;

  // Facilities
  FACILITY_NTWIN32 = $7;

  STATUS_NOT_ALL_ASSIGNED: NTSTATUS = $00000106;

  // Errors
  STATUS_UNSUCCESSFUL: NTSTATUS = $C0000001;
  STATUS_INFO_LENGTH_MISMATCH: NTSTATUS = $C0000004;
  STATUS_ACCESS_DENIED: NTSTATUS = $C0000022;
  STATUS_BUFFER_TOO_SMALL: NTSTATUS = $C0000023;
  STATUS_PRIVILEGE_NOT_HELD: NTSTATUS = $C0000061;
  STATUS_BAD_IMPERSONATION_LEVEL: NTSTATUS = $C00000A5;
  STATUS_NOT_SUPPORTED: NTSTATUS = $C00000BB;
  STATUS_IMPLEMENTATION_LIMIT: NTSTATUS = $C000042B;

implementation

end.
