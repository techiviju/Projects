# Secure Note Sharing Implementation

## Overview
This implementation replaces the insecure numeric ID-based sharing system with a secure token-based system that prevents users from guessing or accessing other notes by changing the URL.

## Security Features

### 1. Random Share Tokens
- **Format**: 32-character base64 URL-encoded strings (e.g., `xyz123abc456def789ghi012jkl345mno`)
- **Generation**: Cryptographically secure random tokens using `SecureRandom`
- **Uniqueness**: Database-enforced unique constraint on `share_token` field
- **Validation**: Server-side validation of token format before processing

### 2. URL Structure Changes
- **Old**: `/share/123` (predictable numeric ID)
- **New**: `/share/xyz123abc456def789ghi012jkl345mno` (secure random token)

### 3. Backend Security
- **Token Validation**: Invalid tokens return 404 errors
- **Format Checking**: Only valid base64 URL characters accepted
- **Database Lookup**: Tokens are looked up directly, not derived from IDs
- **Error Handling**: Proper 404 responses for non-existent or invalid tokens

## Implementation Details

### Backend Changes

#### 1. Database Schema
```sql
ALTER TABLE notes ADD COLUMN share_token VARCHAR(32) UNIQUE;
```

#### 2. New Entity Field
```java
@Column(name = "share_token", unique = true, length = 32)
private String shareToken;
```

#### 3. Token Generation Utility
```java
public class ShareTokenGenerator {
    public static String generateShareToken() {
        // 24 bytes = 32 characters in base64
        byte[] randomBytes = new byte[24];
        SECURE_RANDOM.nextBytes(randomBytes);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(randomBytes);
    }
}
```

#### 4. New API Endpoints
- `GET /api/notes/share/{token}` - Get shared note by token (secure)
- `GET /api/notes/share/id/{id}` - Get shared note by ID (deprecated)

#### 5. Repository Method
```java
Optional<Note> findByShareToken(String shareToken);
```

### Frontend Changes

#### 1. Updated API Service
```javascript
async getSharedNote(token) {
    const res = await api.get(`/notes/share/${token}`);
    return res;
}
```

#### 2. Route Parameter Update
```javascript
<Route path="/share/:token" element={<NoteViewer isShared={true} />} />
```

#### 3. Share URL Generation
```javascript
// Uses shareToken instead of numeric ID
setShareUrl(`${baseUrl}/share/${noteData.shareToken}`);
```

## Security Benefits

### 1. Unpredictable URLs
- Tokens are cryptographically random
- No sequential or predictable patterns
- 32-character length provides 2^192 possible combinations

### 2. No Information Disclosure
- URLs don't reveal note IDs or creation order
- No way to guess other note tokens
- Each token is unique and independent

### 3. Proper Error Handling
- Invalid tokens return 404 (not 500 or other errors)
- No information leakage about token validity
- Consistent error responses

### 4. Backward Compatibility
- Old ID-based sharing still works (deprecated)
- Gradual migration path
- No breaking changes for existing functionality

## Testing

### Security Test Cases
1. **Invalid Tokens**: Should return 404
   - Wrong format tokens
   - Non-existent tokens
   - Malformed tokens
   - Empty tokens

2. **Valid Format Tokens**: Should validate format but return 404 if non-existent
   - 32-character base64 URL strings
   - Mixed case tokens
   - Tokens with dashes and underscores

3. **Existing Tokens**: Should return note data
   - Valid tokens for existing notes
   - Proper JSON response structure

## Migration Notes

### For Existing Notes
- New notes automatically get share tokens
- Existing notes can be updated to generate tokens
- Old sharing URLs continue to work (deprecated)

### For Frontend
- All share URLs now use tokens
- No changes needed for regular note viewing
- Share buttons generate token-based URLs

## File Changes Summary

### Backend Files Modified
- `Note.java` - Added shareToken field
- `NoteResponse.java` - Added shareToken to DTO
- `NoteRepository.java` - Added findByShareToken method
- `NoteService.java` - Added token generation and validation
- `NoteController.java` - Added new token-based endpoint
- `ShareTokenGenerator.java` - New utility class

### Frontend Files Modified
- `api.js` - Updated to use token parameter
- `NoteViewer.jsx` - Updated to use tokens for sharing
- `NoteCard.jsx` - Updated share links to use tokens
- `App.jsx` - Updated route parameter name

## Security Considerations

1. **Token Entropy**: 192 bits of entropy (2^192 combinations)
2. **Uniqueness**: Database constraint ensures no duplicates
3. **Validation**: Server-side format validation prevents injection
4. **Error Handling**: Consistent 404 responses prevent information leakage
5. **No Predictability**: Cryptographically secure random generation

This implementation provides a robust, secure note sharing system that prevents unauthorized access while maintaining a good user experience.


