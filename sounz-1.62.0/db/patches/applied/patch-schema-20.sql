BEGIN;
ALTER TABLE distinction_instances ALTER event_id DROP not null;
COMMIT;