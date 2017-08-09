AND  (CreatedBy IN (SELECT UserID FROM dbo.UserList( @UserID, @Date ))
			OR (RestrictOrg <> 'U' AND (OrgID = @OrgID OR (RestrictOrg <> 'R' AND (OrgID IN (SELECT OrgID
																							FROM osInfoRelAccess (NOLOCK)
																							WHERE InfoReleaseNo = C.InfoReleaseNo
																							AND (C.InfoReleaseDate IS NULL OR C.InfoReleaseDate <= @Date )
																							AND (C.InfoReleaseEndDate IS NULL OR C.InfoReleaseEndDate >= @Date )
																							AND AccessOrgID = @OrgID
																							AND ActiveStatus <> 'D')
																					OR OrgID IN (SELECT GrantingOrgID
			     																				FROM cmInfoRelease (NOLOCK)
																								WHERE ClientID = C.ClientID
																								AND (GrantedDate IS NULL OR GrantedDate <= @Date )
																								AND (EndDate IS NULL OR EndDate >= @Date )
																								AND GrantToOrg = @OrgID
																								AND ActiveStatus <> 'D'))))))